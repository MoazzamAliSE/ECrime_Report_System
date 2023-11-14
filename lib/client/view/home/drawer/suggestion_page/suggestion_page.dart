import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final TextEditingController _suggestionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Suggestions'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenericTextField(
                  controller: _suggestionController,
                  labelText: 'Enter your suggestion',
                  maxLines: 5,
                  minLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your suggestion';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      setState(() {
                        loading = true;
                      });
                      String suggestion =
                          _suggestionController.value.text.toString();
                      FirebaseDatabase.instance
                          .ref('Suggestions')
                          .child(
                              DateTime.now().microsecondsSinceEpoch.toString())
                          .set({
                        'msg': suggestion,
                        'name': (await UserPref.getUser())['userName'],
                        'email': (await UserPref.getUser())['email'],
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });
                        Get.back();
                        Utils.showSnackBar(
                          'Success',
                          'Your suggestion is sent',
                          const Icon(Icons.done_all),
                        );
                      }).onError((error, stackTrace) {
                        Utils.showSnackBar(
                          'Warning',
                          'Something went wrong',
                          const Icon(Icons.done_all),
                        );
                        setState(() {
                          loading = false;
                        });
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                  label: loading
                      ? Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        )
                      : const Text('Send Suggestion'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _suggestionController.dispose();
    super.dispose();
  }
}
