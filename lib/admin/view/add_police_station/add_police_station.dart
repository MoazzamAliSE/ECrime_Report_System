import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPoliceStationPage()),
                );
              },
              child: Text('Add Police Station'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewPoliceStationsPage()),
                );
              },
              child: Text('View Police Stations'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPoliceStationPage extends StatefulWidget {
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
              title: Text('Police Station Exists'),
              content: Text('The police station $name already exists.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
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
                title: Text('Police Station Added'),
                content: Text('The police station $name has been added successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context); 
                    },
                    child: Text('OK'),
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
        title: Text('Add Police Station'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Police Station Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: districtController,
              decoration: InputDecoration(labelText: 'District'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addPoliceStation,
              child: Text('Add Police Station'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewPoliceStationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Police Stations'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('policeStations').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> policeStations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: policeStations.length,
            itemBuilder: (context, index) {
              return PoliceStationListItem(policeStationSnapshot: policeStations[index]);
            },
          );
        },
      ),
    );
  }
}

class PoliceStationListItem extends StatelessWidget {
  final QueryDocumentSnapshot policeStationSnapshot;

  PoliceStationListItem({required this.policeStationSnapshot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(policeStationSnapshot['name']),
      subtitle: Text(policeStationSnapshot['district']),
    );
  }
}
