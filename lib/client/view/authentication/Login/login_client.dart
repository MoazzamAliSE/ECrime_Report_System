// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecrime/client/view/authentication/forget_pass/forget_pass.dart';
import 'package:ecrime/client/view/authentication/sign_up/signup_client.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageClient extends StatefulWidget {
  const LoginPageClient({Key? key}) : super(key: key);

  @override
  _LoginPageClientState createState() => _LoginPageClientState();
}

class _LoginPageClientState extends State<LoginPageClient> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;
  String _errorMessage = '';

  Future<void> _signIn() async {
    setState(() {
      _loading = true;
      _errorMessage = '';
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = userCredential.user;
      print("$user aaa");

      if (user != null) {
        // Check if the user is an admin or a normal user in Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userSnapshot.exists) {
          bool isAdmin = userSnapshot['isAdmin'] ?? false;

          if (isAdmin) {
            // User is an admin, show dialog and do not navigate
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Permission Denied'),
                  content: const Text(
                      'You dont have the permission to enter the home page'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // User is a normal user, navigate to FirUser home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const FirUserHomePage()),
            );
          }
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid email or password. Please try again.';
      });
      print('Error: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'User Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _buildEmailField(),
                const SizedBox(height: 15),
                _buildPasswordField(),
                const SizedBox(height: 15),
                _buildForgetButton(context),
                const SizedBox(height: 15),
                _buildLoginButton(),
                const SizedBox(height: 10),
                //yeh nichay wala daikh layna agar zaroorat hay nahi to is ko aisay karna kay
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 10),
                _buildSignUpButton(context),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSignUpButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }

  ElevatedButton _buildLoginButton() {
    return ElevatedButton(
      onPressed: _loading ? null : _signIn,
      child: _loading ? const CircularProgressIndicator() : const Text('Login'),
    );
  }

  Row _buildForgetButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgetPasswordPage()),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
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
}
