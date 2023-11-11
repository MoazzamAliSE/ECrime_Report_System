import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class CompleteRegistrationBtn extends StatefulWidget {
  final GlobalKey<FormState> formKey;
   CompleteRegistrationBtn({super.key, required this.formKey});
  @override
  State<CompleteRegistrationBtn> createState() => _CompleteRegistrationBtnState();
}

class _CompleteRegistrationBtnState extends State<CompleteRegistrationBtn> {
  final controller=Get.put(SignUpController());
  completeRegistration() async {
    if(widget.formKey.currentState!.validate()){
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CompleteRegistrationPage(),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (controller.password.text.toString() == controller.confirmPassword.text.toString()) {
          await completeRegistration();
        } else {
          Utils.showSnackBar('Warning', 'Password mismatched', Icon(Icons.warning_amber));
        }
      },
      child: const Text('Complete Registration'),
    );
  }
}
