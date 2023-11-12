import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';

class SignUpEmailField extends StatelessWidget {
  SignUpEmailField({super.key});
  final controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
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
}
