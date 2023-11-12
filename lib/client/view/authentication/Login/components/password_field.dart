import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signIn_controller.dart';

class LoginPasswordField extends StatelessWidget {
  LoginPasswordField({super.key});
  final controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => GenericTextField(
          controller: controller.userPassword,
          labelText: 'Password',
          hintText: 'Enter your password',
          prefixIcon: const Icon(Icons.lock),
          obscureText: controller.obscurePassword.value,
          suffixIcon: GestureDetector(
              onTap: () => controller.obscurePassword.toggle(),
              child: controller.obscurePassword.value
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
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
}
