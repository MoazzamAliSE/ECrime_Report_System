import 'package:ecrime/client/view/authentication/Login/components/login_screen_body.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
class LoginPageClient extends StatefulWidget {
  const LoginPageClient({Key? key}) : super(key: key);
  @override
  _LoginPageClientState createState() => _LoginPageClientState();
}
class _LoginPageClientState extends State<LoginPageClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: BackgroundFrame(
        child: Center(
          child: LoginScreenBody(),
        ),
      ),
    );
  }
}


