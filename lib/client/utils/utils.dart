import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static String extractFirebaseError(String error) {
    return error.substring(error.indexOf(']') + 1);
  }

  static void showSnackBar(String title, String message, Widget icon) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: Colors.white,
      title: title,
      isDismissible: true,
      duration: const Duration(milliseconds: 2000),
      icon: icon,
      titleText: Text(
        title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, height: 0),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.grey, height: 0),
      ),
      borderColor: Colors.black,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 20,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      snackStyle: SnackStyle.GROUNDED,
    ));
  }
}
