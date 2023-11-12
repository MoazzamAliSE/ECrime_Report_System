import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/network/firebase_services.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();
  RxBool loading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool obscurePassword = true.obs;

  setLoading(bool value) {
    loading.value = value;
  }

  signIn() async {
    FirebaseServices.signInAccount();
  }
}
