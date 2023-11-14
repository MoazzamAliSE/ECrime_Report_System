import 'package:get/get.dart';

import '../../../client/View/widgets/widgets_barrel.dart';
import '../../../client/data/network/firebase_services.dart';

class SignUpAdminController extends GetxController{
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  RxBool loading = false.obs;
  RxBool obscurePassword = true.obs;

  setLoading(value) {
    loading.value = value;
  }



  createAccount() {
    FirebaseServices.createAdminAccount('admin');
  }
}