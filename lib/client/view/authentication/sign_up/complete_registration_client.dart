import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecrime/client/view/authentication/sign_up/signup_client.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteRegistrationPage extends StatefulWidget {
  final String userId;

  const CompleteRegistrationPage({Key? key, required this.userId})
      : super(key: key);

  @override
  _CompleteRegistrationPageState createState() =>
      _CompleteRegistrationPageState();
}

class _CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String _profilePictureUrl = '';
  bool _loading = false;

  Future<void> _pickAndUploadImage(String userId) async {
    final picker = ImagePicker();
    XFile? pickedFile;

    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print('Error picking image: $e');
    }

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        setState(() {
          _loading = true;
        });

        Reference storageReference =
            FirebaseStorage.instance.ref().child('profile_pictures/$userId');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          _profilePictureUrl = downloadUrl;
          _loading = false;
        });

        _showDialog('Success', 'Image uploaded successfully.');
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Registration'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildImagePicker(),
                const SizedBox(height: 40),
                _buildFullNameField(),
                const SizedBox(height: 20),
                _buildPhoneNumberField(),
                const SizedBox(height: 20),
                _buildSignupButton(context),
              ],
            ),
          ),
          if (_loading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  ElevatedButton _buildSignupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .update({
          'fullName': _fullNameController.text,
          'phoneNo': _phoneNumberController.text,
          'profilePictureUrl': _profilePictureUrl,
        });

        _showDialog('Success', 'Registration completed successfully!');
        Navigator.pop(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FirUserHomePage()),
        );
      },
      child: const Text('Sign Up'),
    );
  }

  GenericTextField _buildPhoneNumberField() {
    return GenericTextField(
      controller: _phoneNumberController,
      labelText: 'Phone number',
      hintText: 'Enter your Phone number',
      prefixIcon: const Icon(Icons.numbers),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }

  GenericTextField _buildFullNameField() {
    return GenericTextField(
      controller: _fullNameController,
      labelText: 'Full Name',
      hintText: 'Enter your full name',
      prefixIcon: const Icon(Icons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Full Name is required';
        }
        return null;
      },
    );
  }

  GestureDetector _buildImagePicker() {
    return GestureDetector(
      onTap: () async {
        await _pickAndUploadImage(widget.userId);
      },
      child: CircleAvatar(
        radius: 82,
        backgroundColor: Colors.black,
        child: CircleAvatar(
          radius: 80,
          backgroundImage: _profilePictureUrl.isNotEmpty
              ? NetworkImage(_profilePictureUrl)
              : null,
          child:
              _profilePictureUrl.isEmpty ? const Icon(Icons.camera_alt) : null,
        ),
      ),
    );
  }
}
