

import 'package:ecrime/client/view/investigation_update/investigation_update.dart';

import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  late Timer _timer;
  int _remainingTime = 0;
  bool _showTimer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GenericTextField(
                controller: _emailController,
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(Icons.mail),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text.trim();

                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email);

                    _startTimer();
                    setState(() {
                      _showTimer = true;
                    });

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Important'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  'Your OTP has been sent to your email address.'),
                              Text(
                                  'Please check your email and click on the link to reset your password.'),
                              SizedBox(height: 10),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                _timer.cancel();
                                setState(() {
                                  _showTimer = false;
                                });
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPageClient(),
                                  ),
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    print('Error: $e');
                    
                  }
                },
                child: const Text('Send OTP'),
              ),
              const SizedBox(
                height: 150,
              ),
              
              if (_showTimer)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Time remaining: '),
                      Text('$_remainingTime seconds'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _startTimer() {
    _remainingTime = 60;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        print(_remainingTime);
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
