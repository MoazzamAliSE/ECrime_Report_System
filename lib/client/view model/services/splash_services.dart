import 'dart:async';

import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices{
  static checkIsLogin()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();

      Timer(const Duration(seconds: 2), () {
      if(preferences.getString('token')!=null){
        Get.offAllNamed(RoutesName.home);
      }else{
        Get.offAllNamed(RoutesName.login);
      }
      });

  }
}