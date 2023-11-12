import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Suggestion extends StatelessWidget {
  const Suggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text('Suggestions'),
      ),
      body: FirebaseAnimatedList(query: FirebaseDatabase.instance.ref('Suggestions'), itemBuilder: (context, snapshot, animation, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email : ${snapshot.child('email')}',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Name : ${snapshot.child('name')}'),
              Text('Suggestion',style: TextStyle(fontWeight: FontWeight.bold),),
              Text('${snapshot.child('msg')}',style: TextStyle(fontWeight: FontWeight.bold),),

            ],
          ),
        );
      },),
    ));
  }
}
