import 'package:get/get.dart';

import '../../../../utils/utils.dart';
import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class SignUpBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final controller=Get.put(SignUpController());
  SignUpBtn({super.key, required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
      height: 40,
      width: 120,
      child: ElevatedButton(
        onPressed: () {
          if(controller.profilePicture.isEmpty){
            Utils.showSnackBar('Warning', 'Please set your profile picture', Icon(Icons.warning_amber));
            return;
          }
          if(formKey.currentState!.validate()){
            controller.createAccount();
          }
        },
        child: controller.loading.value? Center(
          child: Container(
            height: 15,
            width: 15,
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          ),
        ) : const Text('Sign Up'),
      ),
    ));
  }
}