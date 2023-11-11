import 'package:ecrime/client/view/authentication/sign_up/components/sign_up_body.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class SignUpPageClient extends StatelessWidget {
  const SignUpPageClient({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SignUpBody(),
    );
  }
}





