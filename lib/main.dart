import 'package:ecrime/client/res/routes/app_routes.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyClientApp());
}

class MyClientApp extends StatelessWidget {
  const MyClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.pages(),
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      title: 'E-Crime Report System',
    );
  }
}
