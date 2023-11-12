import 'package:ecrime/admin/view/admin_home/admin_home.dart';
import 'package:ecrime/admin/view/view_corruptions/view_corruptions.dart';
import 'package:ecrime/admin/view/view_fir/view_fir.dart';
import 'package:ecrime/client/res/routes/app_routes.dart';
import 'package:ecrime/client/view/complain_corruption/complain_corruption.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings;
  addDummyFIRs();
  addDummyComplaints();

  runApp(const MyClientApp());
}

class MyClientApp extends StatelessWidget {
  const MyClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    var isAdmin = true; // variable for admin or client
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // getPages: AppRoutes.pages(), // client side
      home: isAdmin ? const AdminHomePage() : HomeScreenClient(),
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
