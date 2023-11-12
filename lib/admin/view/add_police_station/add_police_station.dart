import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPoliceStationPage extends StatefulWidget {
  const AddPoliceStationPage({super.key});

  @override
  _AddPoliceStationPageState createState() => _AddPoliceStationPageState();
}

class _AddPoliceStationPageState extends State<AddPoliceStationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  void _addPoliceStation() {
    String name = nameController.text.trim();
    String location = locationController.text.trim();
    String district = districtController.text.trim();

    FirebaseFirestore.instance
        .collection('policeStations')
        .where('name', isEqualTo: name.toLowerCase())
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Police Station Exists'),
              content: Text('The police station $name already exists.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        FirebaseFirestore.instance.collection('policeStations').add({
          'name': name.toLowerCase(),
          'location': location,
          'district': district,
        }).then((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Police Station Added'),
                content: Text(
                    'The police station $name has been added successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }).catchError((error) {
          print('Error adding police station: $error');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Police Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration:
                  const InputDecoration(labelText: 'Police Station Name'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: districtController,
              decoration: const InputDecoration(labelText: 'District'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPoliceStation,
              child: const Text('Add Police Station'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewPoliceStationsPage extends StatelessWidget {
  const ViewPoliceStationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Police Stations'),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('policeStations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> policeStations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: policeStations.length,
            itemBuilder: (context, index) {
              return PoliceStationListItem(
                  policeStationSnapshot: policeStations[index]);
            },
          );
        },
      ),
    );
  }
}

class PoliceStationListItem extends StatelessWidget {
  final QueryDocumentSnapshot policeStationSnapshot;

  const PoliceStationListItem({super.key, required this.policeStationSnapshot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(policeStationSnapshot['name']),
      subtitle: Text(policeStationSnapshot['district']),
    );
  }
}
