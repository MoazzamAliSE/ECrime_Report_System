import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class PasswordField extends StatelessWidget {
  PasswordField({super.key});
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => GenericTextField(
          controller: controller.password,
          labelText: 'Password',
          hintText: 'Enter your password',
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
              return 'Password is required';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ));
  }
}
