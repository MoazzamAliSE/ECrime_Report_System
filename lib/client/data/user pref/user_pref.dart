import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static saveUser(Map<String, String> user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userName', user['userName']!);
    pref.setString('fullName', user['fullName']!);
    pref.setString('profilePicture', user['profilePicture']!);
    pref.setString('email', user['email']!);
    pref.setString('phoneNumber', user['phoneNumber']!);
    pref.setString('token', user['token']!);
    pref.setString('type', user['type']!);

    print(user);
  }

  static Future<Map<String, String?>> getUser() async {
    Map<String, String?> user;
    SharedPreferences pref = await SharedPreferences.getInstance();
    user = {
      'userName': pref.getString('userName'),
      'fullName': pref.getString('fullName'),
      'profilePicture': pref.getString('profilePicture'),
      'phoneNumber': pref.getString('phoneNumber'),
      'email': pref.getString('email'),
      'token': pref.getString('token'),
      'type': pref.getString('type'),
    };
    return user;
  }

  static clearUser() async {
    FirebaseAuth.instance.signOut();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
