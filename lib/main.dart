import 'package:ecrime/client/view/complain_corruption/complain_corruption.dart';
import 'package:ecrime/client/view/investigation_update/investigation_update.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyClientApp());
}

class MyClientApp extends StatelessWidget {
  const MyClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primaryColor,
        ),
      ),
      title: 'E-Crime Report System',
      home: const LoginPageClient(),
    );
  }
}
