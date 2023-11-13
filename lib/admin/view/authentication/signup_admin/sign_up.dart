import 'package:ecrime/admin/view%20model/controller/signup_controller.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPageAdmin extends StatefulWidget {
  const SignupPageAdmin({Key? key}) : super(key: key);

  @override
  _SignupPageAdminState createState() => _SignupPageAdminState();
}

class _SignupPageAdminState extends State<SignupPageAdmin> {
  final controller=Get.put(SignUpAdminController());
  final _formKey=GlobalKey<FormState>();
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
            child: Form(
              key: _formKey,
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
          ),

        ],
      ),
    );
  }

   _completeRegistrationButton() {
    return SizedBox(
      height: 45,
      width: 180,
      child: ElevatedButton(
        onPressed:controller.loading.value?null : () async {
          if(_formKey.currentState!.validate()){
            controller.createAccount();

          }
        },
        child:Obx(() => controller.loading.value ? Center(child: SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: AppColor.primaryColor,),),): const Text('Signup as Admin'),)
      ),
    );
  }

   _buildConfirmPasswordField() {
    return Obx(() => GenericTextField(
      controller: controller.confirmPassword,
      labelText: 'Confirm Password',
      hintText: 'Re-enter your password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: controller.obscurePassword.value,
      suffixIcon: GestureDetector(
          onTap:() =>  controller.obscurePassword.toggle(),
          child: const Icon(Icons.visibility)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Confirm Password is required';
        } else if (value != controller.password.value.text.toString()) {
          return 'Passwords do not match';
        }
        return null;
      },
    ));
  }

   _buildPasswordField() {
    return Obx(() => GenericTextField(
      controller: controller.password,
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
      controller: controller.email,
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

   _buildUserNameField() {
    return GenericTextField(
      controller: controller.userName,
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
