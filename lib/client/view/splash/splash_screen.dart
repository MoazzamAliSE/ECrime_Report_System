import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/res/images.dart';
import 'package:ecrime/client/view%20model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices.checkIsLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset(AppImages.logo,height: 150,width: 150,)),
    );
  }
}
