import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signIn_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  LoginButton({super.key, required this.formKey});
  final controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 120,
      child: Obx(() => ElevatedButton(
            onPressed: controller.loading.value
                ? null
                : () {
                    if (formKey.currentState!.validate()) {
                      controller.signIn();
                    }
                  },
            child: controller.loading.value
                ? Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  )
                : const Text('Login'),
          )),
    );
  }
}
