import 'package:flutter/material.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class SuggestionsPage extends StatefulWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final TextEditingController _suggestionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Suggestions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericTextField(
              controller: _suggestionController,
              labelText: 'Enter your suggestion',
              maxLines: 5,
              minLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String suggestion = _suggestionController.text;
                print('Suggestion: $suggestion');
              },
              child: const Text('Upload Suggestion'),
            ),
          ],
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
