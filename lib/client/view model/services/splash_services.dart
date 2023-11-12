import 'dart:async';

import 'package:ecrime/admin/view/authentication/login_admin/login_admin.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/view/status/status_view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../admin/view/admin_home/admin_home.dart';

class SplashServices {
  static checkIsLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    bool isAdmin = false;
    if (isAdmin) {
      Timer(const Duration(seconds: 2), () {
        // Get.off(const StatusPage()); //test
        Get.off(const LoginPageAdmin()); //admin
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        if (preferences.getString('token') != null) {
          Get.offAllNamed(RoutesName.home);
        } else {
          Get.offAllNamed(RoutesName.login);
        }
      });
    }
  }
}
