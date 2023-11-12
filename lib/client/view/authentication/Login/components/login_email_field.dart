import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';
import '../../../../view model/controller/authentication_controller/signIn_controller.dart';
import '../../../../widgets/generic_text_form_field.dart';

class LoginEmailField extends StatelessWidget {
  LoginEmailField({super.key});
  final controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
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
