import 'package:ecrime/client/view/authentication/sign_up/components/password_field.dart';
import 'package:ecrime/client/view/authentication/sign_up/components/signup_email_field.dart';
import 'package:ecrime/client/view/authentication/sign_up/components/signup_name_field.dart';
import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';
import 'complete_registration_btn.dart';
import 'confirm_password_field.dart';

class SignUpBody extends StatelessWidget {
  SignUpBody({super.key});
  final controller=Get.put(SignUpController());
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BackgroundFrame(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Sign Up',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    SignupNameField(),
                    const SizedBox(height: 15),
                    SignUpEmailField(),
                    const SizedBox(height: 15),
                    PasswordField(),
                    const SizedBox(height: 15),
                    ConfirmPasswordField(),
                    const SizedBox(height: 40),
                    CompleteRegistrationBtn(formKey: _formKey),
                    const SizedBox(height: 15),
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
          ),

        ],
      ),
    );
  }
}