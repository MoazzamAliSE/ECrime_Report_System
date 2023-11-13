import 'package:ecrime/admin/view%20model/controller/signIn_admin_controller.dart';
import 'package:ecrime/admin/view/admin_home/admin_home.dart';
import 'package:ecrime/admin/view/authentication/signup_admin/sign_up.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class LoginPageAdmin extends StatefulWidget {
  const LoginPageAdmin({super.key});

  @override
  _LoginPageAdminState createState() => _LoginPageAdminState();
}

class _LoginPageAdminState extends State<LoginPageAdmin> {
  final controller=Get.put(SigninAdminController());
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Login',
          // style: ,
        ),
        centerTitle: true,
      ),
      body: BackgroundFrame(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildEmailField(),
                    const SizedBox(height: 10),
                    _buildPasswordField(),
                    const SizedBox(height: 20),
                    _buildLoginButton(),
                    const SizedBox(height: 10),
                    _buildSignUpButton(context),
                  ],
                ),
              ),
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
              MaterialPageRoute(builder: (context) => const SignupPageAdmin()),
            );
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }

   _buildLoginButton() {
    return SizedBox(
      width: 150,
      height: 45,
      child: ElevatedButton(
        onPressed:controller.loading.value ? null : () {
          if(_formKey.currentState!.validate()){
            FirebaseServices.signInAdminAccount();
          }
        },
        child: Obx(() => controller.loading.value ? Center(child: const CircularProgressIndicator()) : const Text('Login'),)
      ),
    );
  }

   _buildPasswordField() {
    return Obx(() => GenericTextField(
      controller: controller.userPassword,
      labelText: 'Password',
      hintText: 'Enter your password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: controller.obscurePassword.value,
      suffixIcon: GestureDetector(
          onTap: () => controller.obscurePassword.toggle(),
          child: const Icon(Icons.visibility)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    ));
  }

  GenericTextField _buildEmailField() {
    return GenericTextField(
      controller: controller.userEmail,
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

// class HomeScreenAdmin extends StatelessWidget {
//   const HomeScreenAdmin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Home Page'),
//       ),
//       body: const Center(
//         child: Text('Welcome, Admin!'),
//       ),
//     );
//   }
// }
