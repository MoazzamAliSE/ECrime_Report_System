import 'package:ecrime/client/View/widgets/widgets_barrel.dart';

class MoveSignUpButton extends StatelessWidget {
  const MoveSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpPageClient(),
              ),
            );
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
