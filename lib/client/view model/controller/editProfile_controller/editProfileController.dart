import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:get/get.dart';

import '../../../../admin/view/view_admin_barrel.dart';

class EditProfileController extends GetxController {
  Map<String, String?> userDate = {'': ''};
  RxString profileImage = ''.obs;
  String fileName = '';
  RxString newFileName = ''.obs;
  RxBool loading = false.obs;
  Rx<TextEditingController> usernameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> fullNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNoController = TextEditingController().obs;

  EditProfileController() {
    getUserData();
  }
  getUserData() async {
    if (userDate['userName'] == null) {
      userDate = await UserPref.getUser();
      usernameController.value.text = userDate['userName']!;
      emailController.value.text = userDate['email']!;
      fullNameController.value.text = userDate['fullName']!;
      phoneNoController.value.text = userDate['phoneNumber']!;
      profileImage.value = userDate['profilePicture']!;
    }
  }

  picImageFromGallery() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker != null) {
      newFileName.value = picker.path;
      fileName = picker.name;
    } else {
      newFileName.value = '';
    }
  }

  picImageFromCam() async {
    final picker = await ImagePicker().pickImage(source: ImageSource.camera);
    if (picker != null) {
      newFileName.value = picker.path;
      fileName = picker.name;
    } else {
      newFileName.value = '';
    }
  }

  upDateData() async {
    loading.value = true;
    FirebaseStorage storage = FirebaseStorage.instance;
    String key = DateTime.now().microsecondsSinceEpoch.toString();
    String email = (await UserPref.getUser())['email']!;
    var sRef = storage.ref(
        'profile_image/${email.substring(0, email.indexOf('@'))}/$fileName');
    var uploadTask = sRef.putFile(File(newFileName.value));
    await Future.value(uploadTask).then((v) async {
      sRef.getDownloadURL().then((url) async {
        String node = emailController.value.value.text.toString();
        FirebaseServices.updateProfile(
            node.substring(0, node.indexOf('@')), url);
      });
    }).onError((error, stackTrace) {
      Utils.showSnackBar('Warning', 'Something went wrong try again',
          const Icon(Icons.warning_amber));
      loading.value = false;
    });
  }
}
