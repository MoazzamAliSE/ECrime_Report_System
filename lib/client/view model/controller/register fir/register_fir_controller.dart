import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:ecrime/client/model/fire_model.dart';

import 'package:get/get.dart';

class RegisterFirController extends GetxController {
  Rx<FIRModel> model = FIRModel().obs;
  RxString fireType = 'Myself'.obs;
  RxInt stepper = 0.obs;
  RxString evidence = ''.obs;
  RxString evidenceType = ''.obs;
  RxString fileName = ''.obs;
  RxBool loading = false.obs;
  Rx<DateTime> date = (DateTime.now()).obs;
  registerFir() {
    FirebaseServices.registerFir();
  }

  picEvidenceImageVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4'],
      allowMultiple: false,
    );

    if (result != null) {
      evidence.value = result.files.first.path!;
      evidenceType.value = 'media';
      fileName.value = result.files.first.name;
    } else {
      evidence.value = '';
      evidenceType.value = '';
    }
  }

  picEvidenceDoc() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    if (result != null) {
      evidenceType.value = 'doc';
      evidence.value = result.files.first.path!;
      fileName.value = result.files.first.name;
    } else {
      evidenceType.value = '';
      evidence.value = '';
    }
  }
}
