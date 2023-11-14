import 'package:ecrime/client/view/authentication/Login/components/password_field.dart';
import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signIn_controller.dart';
import '../../../widgets/widgets_barrel.dart';
import 'forgot_password_btn.dart';
import 'login_button.dart';
import 'login_email_field.dart';
import 'move_signup_btn.dart';

class LoginScreenClientBody extends StatelessWidget {
  LoginScreenClientBody({super.key});
  final controller = Get.put(SignInController());
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                children: [
                  Text(
                    'Welcome Back To ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ImageLogoAuth(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LoginEmailField(),
              const SizedBox(height: 15),
              LoginPasswordField(),
              const SizedBox(height: 15),
              const ForgotPasswordBtn(),
              const SizedBox(height: 15),
              LoginButton(formKey: _formKey),
              const SizedBox(height: 10),
              if (controller.errorMessage.isNotEmpty)
                Obx(
                  () => Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 10),
              const MoveSignUpButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
