import 'package:ecrime/client/view/authentication/sign_up/components/phone_number_field.dart';
import 'package:ecrime/client/view/authentication/sign_up/components/pic_image_circle.dart';
import 'package:ecrime/client/view/authentication/sign_up/components/sign_up_btn.dart';
import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';
import 'full_name_field.dart';

class CompleteRegBody extends StatelessWidget {
  CompleteRegBody({super.key});
  final _formKey=GlobalKey<FormState>();
  final controller=Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return BackgroundFrame(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PicImageCircle(),
                  const SizedBox(height: 40),
                  FullNameField(),
                  const SizedBox(height: 20),
                  PhoneNumberField(),
                  const SizedBox(height: 20),
                  SignUpBtn(formKey: _formKey),
                ],
              ),
            ),
          ),
          if (controller.loading.value)
            Obx(() => Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),)
        ],
      ),
    );
  }
}
