import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'components/complete_reg_body.dart';
class CompleteRegistrationPage extends StatelessWidget {
  const CompleteRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Registration'),
      ),
      body: CompleteRegBody(),
    );
  }
}










