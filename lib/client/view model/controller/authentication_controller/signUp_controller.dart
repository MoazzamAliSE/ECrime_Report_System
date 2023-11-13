import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final fullName = TextEditingController();
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  RxString profilePicture = ''.obs;
  RxBool loading = false.obs;
  RxBool obscurePassword = true.obs;

  setLoading(value) {
    loading.value = value;
  }

  picImage() async {
    final picker = ImagePicker();
    XFile? pickedFile;
    try {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        profilePicture.value = pickedFile.path;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  createAccount() {
    FirebaseServices.createAccount('client');
  }
}
