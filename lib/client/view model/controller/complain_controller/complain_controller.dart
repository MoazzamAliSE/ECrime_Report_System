import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:get/get.dart';

import '../../../View/widgets/widgets_barrel.dart';

class ComplainController extends GetxController{
  RxBool loading=false.obs;
  RxString region=''.obs;
  RxString institute=''.obs;
  final detail=TextEditingController();
  RxString evidence=''.obs;
  RxString evidenceName=''.obs;



  picEvidence() async {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'mp4' 'pdf' 'doc' 'docx'],
        allowMultiple: false,
      );

      if (result != null) {
        evidence.value = result.files.first.path!;
        evidenceName.value = result.files.first.name;
      } else {
        evidence.value = '';
        evidenceName.value = '';
      }

  }


  registerComplain(String type){

    if(region.isEmpty || institute.isEmpty || detail.value.text.toString().isEmpty){
      Utils.showSnackBar('Warning', 'Please fill data correctly', Icon(Icons.warning_amber));
      return;
    }

    if(evidenceName.isEmpty){
      Utils.showSnackBar('Warning', 'Can\'n register without evidence', Icon(Icons.warning_amber));
      return;
    }

    FirebaseServices.registerComplain(type);
  }

}