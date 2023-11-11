import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/view/authentication/Login/login_client.dart';
import 'package:ecrime/client/view/investigation_update/investigation_update.dart';
import 'package:ecrime/client/view/splash/splash_screen.dart';
import 'package:ecrime/client/view/status/status_view.dart';
import 'package:get/get.dart';

class AppRoutes{
  static List<GetPage> pages(){
    return [
      GetPage(name: RoutesName.splash, page: ()=>const SplashScreen()),
      GetPage(name: RoutesName.login, page: ()=>const LoginPageClient()),
      GetPage(name: RoutesName.signUp, page: ()=>const SignUpPageClient()),
      GetPage(name: RoutesName.home, page: ()=> HomeScreenClient()),
      GetPage(name: RoutesName.registerFir, page: ()=>const RegisterFIR()),
      GetPage(name: RoutesName.completeAccount, page: ()=>const CompleteRegistrationPage()),
      GetPage(name: RoutesName.investigationUpdate, page: ()=>const InvestigationDetailsPage()),
      GetPage(name: RoutesName.status, page: ()=>const StatusPage()),
      GetPage(name: RoutesName.womenHelp, page: ()=>WomenHelpPage()),
    ];
  }
}