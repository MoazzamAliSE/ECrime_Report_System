import 'package:get/get.dart';

import '../../../../view model/controller/authentication_controller/signUp_controller.dart';
import '../../../widgets/widgets_barrel.dart';

class PicImageCircle extends StatelessWidget {
  PicImageCircle({super.key});
  final controller=Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.picImage();
      },
      child: CircleAvatar(
          radius: 82,
          backgroundColor: Colors.black,
          child:Obx(() =>  CircleAvatar(
            radius: 80,
            backgroundImage: controller.profilePicture.isNotEmpty
                ? FileImage(File(controller.profilePicture.value))
                : null,
            child:
            controller.profilePicture.isEmpty ? const Icon(Icons.camera_alt) : null,
          ),)
      ),
    );
  }
}