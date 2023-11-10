// ignore_for_file: use_build_context_synchronously

import 'package:ecrime/client/view/authentication/sign_up/complete_registration_client.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _loading = false;

  Future<void> _signUp() async {
    setState(() {
      _loading = true;
    });

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Add user details to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': _usernameController.text,
          'email': _emailController.text,
          'isAdmin': false,
        });

        // Navigate to CompleteRegistrationPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompleteRegistrationPage(userId: user.uid),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      // Handle registration errors
      _showDialog('Error', 'Registration failed. Please try again.');
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
        title: const Text('Sign Up'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  _buildUserNameField(),
                  const SizedBox(height: 15),
                  _buildEmailField(),
                  const SizedBox(height: 15),
                  _buildPasswordField(),
                  const SizedBox(height: 15),
                  _buildConfirmPasswordField(),
                  const SizedBox(height: 40),
                  _completeRegistrationButton(),
                ],
              ),
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
        if (_passwordController.text == _confirmPasswordController.text) {
          await _signUp();
        } else {
          _showDialog(
              'Password Mismatch', 'Please make sure your passwords match.');
        }
      },
      child: const Text('Complete Registration'),
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
      controller: _usernameController,
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

class FirUserHomePage extends StatelessWidget {
  const FirUserHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FirUser Home'),
      ),
      body: const Center(
        child: Text('Welcome to FirUser Home!'),
      ),
    );
  }
}
