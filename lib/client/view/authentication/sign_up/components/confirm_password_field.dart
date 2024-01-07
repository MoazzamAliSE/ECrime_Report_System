import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class ConfirmPasswordField extends StatelessWidget {
  ConfirmPasswordField({super.key});
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => GenericTextField(
          controller: controller.confirmPassword,
          labelText: 'Confirm Password',
          hintText: 'Re-enter your password',
          prefixIcon: const Icon(Icons.lock),
          obscureText: controller.obscurePassword.value,
          suffixIcon: GestureDetector(
            onTap: () => controller.obscurePassword.toggle(),
            child: controller.obscurePassword.value
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Confirm Password is required';
            } else if (value != controller.password.text.toString()) {
              return 'Passwords do not match';
            }
            return null;
          },
        ));
  }
}
