import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class PhoneNumberField extends StatelessWidget {
  PhoneNumberField({super.key});
  final controller=Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return GenericTextField(
      controller: controller.phoneNumber,
      keyboardType: TextInputType.number,
      labelText: 'Phone number',
      hintText: 'Enter your Phone number',
      prefixIcon: const Icon(Icons.numbers),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        return null;
      },
    );
  }
}