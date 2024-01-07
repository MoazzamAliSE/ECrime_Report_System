import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Map<String, String?>? userData;

  HomeController() {
    getUserData();
  }

  getUserData() async {
    userData ??= await UserPref.getUser();
  }
}
