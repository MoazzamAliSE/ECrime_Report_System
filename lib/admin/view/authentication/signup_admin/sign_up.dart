import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecrime/admin/view/admin_home/admin_home.dart';
import 'package:ecrime/admin/view/authentication/login_admin/login_admin.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPageAdmin extends StatefulWidget {
  const SignupPageAdmin({Key? key}) : super(key: key);

  @override
  _SignupPageAdminState createState() => _SignupPageAdminState();
}

class _SignupPageAdminState extends State<SignupPageAdmin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _loading = false;
  Future<void> _signUp() async {
    setState(() {
      _loading = true;
    });

    String email = _emailController.text;
    String userName = _userNameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      _showDialog('Password Mismatch',
          'Passwords do not match. Please enter matching passwords.');
      _loading = false;
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'isAdmin': true,
          'email': email.toString(),
          'userName': userName.toString(),
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      }
    } catch (e) {
      print('Error during signup: $e');

      _showDialog('Signup Failed', 'Error during signup. Please try again.');
    } finally {
      setState(() {
        _loading = false;
      });
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
        title: const Text('Admin Signup'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUserNameField(),
                const SizedBox(height: 15),
                _buildEmailField(),
                const SizedBox(height: 15),
                _buildPasswordField(),
                const SizedBox(height: 15),
                _buildConfirmPasswordField(),
                const SizedBox(height: 20),
                _completeRegistrationButton(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go to Login'),
                ),
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

  ElevatedButton _completeRegistrationButton() {
    return ElevatedButton(
      onPressed: () async {
        await _signUp();
      },
      child: const Text('Signup as Admin'),
    );
  }

  GenericTextField _buildConfirmPasswordField() {
    return GenericTextField(
      controller: _confirmPasswordController,
      labelText: 'Confirm Password',
      hintText: 'Re-enter your password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: true,
      suffixIcon: const Icon(Icons.visibility),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm Password is required';
        } else if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  GenericTextField _buildPasswordField() {
    return GenericTextField(
      controller: _passwordController,
      labelText: 'Password',
      hintText: 'Enter your password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: true,
      suffixIcon: const Icon(Icons.visibility),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  GenericTextField _buildEmailField() {
    return GenericTextField(
      controller: _emailController,
      labelText: 'Email',
      hintText: 'Enter your email',
      prefixIcon: const Icon(Icons.mail),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
            .hasMatch(value)) {
          return 'Enter a valid email address';
        }
        return null;
      },
    );
  }

  GenericTextField _buildUserNameField() {
    return GenericTextField(
      controller: _userNameController,
      labelText: 'Username',
      hintText: 'Enter your username',
      prefixIcon: const Icon(Icons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username is required';
        }
        return null;
      },
    );
  }
}
