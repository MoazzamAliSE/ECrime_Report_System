import 'package:get/get.dart';

import '../../../client/View/widgets/widgets_barrel.dart';
import '../../../client/data/network/firebase_services.dart';

class SigninAdminController extends GetxController{
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool obscurePassword = true.obs;

  setLoading(bool value) {
    loading.value = value;
  }

  signIn() async {
    FirebaseServices.signInAdminAccount();
  }
}


