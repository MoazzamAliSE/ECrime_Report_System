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
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Card(
          elevation: 3,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            height: 200,
            width: 300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                AppImages.logo,
                height: 150,
                width: 150,
                fit: BoxFit.fitHeight, // Adjust the fit as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
