import 'package:ecrime/client/view%20model/controller/authentication_controller/signUp_controller.dart';
import 'package:get/get.dart';

import '../../../widgets/widgets_barrel.dart';

class SignupNameField extends StatelessWidget {
   SignupNameField({super.key});
  final controller=Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
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
