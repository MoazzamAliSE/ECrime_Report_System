import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class SuggestionAdmin extends StatelessWidget {
  const SuggestionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
      ),
      body: BackgroundFrame(
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('Suggestions'),
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email : ${snapshot.child('email').value}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Name : ${snapshot.child('name').value}'),
                      const Text(
                        'Suggestion',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${snapshot.child('msg').value}',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ));
  }
}
