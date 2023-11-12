import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class ForgotPasswordBtn extends StatelessWidget {
  const ForgotPasswordBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgetPasswordPage(),
              ),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
