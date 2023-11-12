import 'package:ecrime/admin/view/admin_home/admin_home.dart';
import 'package:ecrime/admin/view/view_corruptions/view_corruptions.dart';
import 'package:ecrime/admin/view/view_fir/view_fir.dart';
import 'package:ecrime/client/res/routes/app_routes.dart';
import 'package:ecrime/client/view/complain_corruption/complain_corruption.dart';
import 'package:ecrime/client/view/splash/splash_screen.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings;
  runApp(const MyClientApp());
}

class MyClientApp extends StatelessWidget {
  const MyClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    // variable for admin or client
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages(), // client side
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: interExtraBold,
              color: AppColor.backgroundColor,
              letterSpacing: 1,
              fontSize: 22,
              wordSpacing: 10),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      title: 'E-Crime Report System',
    );
  }
}
