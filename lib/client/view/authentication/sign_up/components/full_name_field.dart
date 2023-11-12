import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/view%20model/controller/authentication_controller/signUp_controller.dart';
import 'package:get/get.dart';

class FullNameField extends StatelessWidget {
  FullNameField({super.key});
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GenericTextField(
      controller: controller.fullName,
      labelText: 'Full Name',
      hintText: 'Enter your full name',
      prefixIcon: const Icon(Icons.person),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Full Name is required';
        }
        return null;
      },
    );
  }
}
