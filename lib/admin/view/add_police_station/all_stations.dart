import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class AllStations extends StatelessWidget {
  const AllStations({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('All Police Station'),
      ),
      body: FirebaseAnimatedList(
        query: FirebaseDatabase.instance.ref('PoliceStations'),
        itemBuilder: (context, snapshot, animation, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name : ${snapshot.child('name').value.toString()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'Location : ${snapshot.child('location').value.toString()}'),
                  Text(
                      'District : ${snapshot.child('district').value.toString()}'),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
