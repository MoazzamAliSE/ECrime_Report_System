import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignFIRPageAdmin extends StatelessWidget {
  const AssignFIRPageAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Page'),
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
                  MaterialPageRoute(
                      builder: (context) => const AssignFIRPage()),
                );
              },
              child: const Text('Assign FIR'),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignFIRPage extends StatelessWidget {
  const AssignFIRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign FIR'),
      ),
      body: BackgroundFrame(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('firs').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<QueryDocumentSnapshot> firs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: firs.length,
              itemBuilder: (context, index) {
                return FIRAssignmentListItem(firSnapshot: firs[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class FIRAssignmentListItem extends StatefulWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRAssignmentListItem({super.key, required this.firSnapshot});

  @override
  _FIRAssignmentListItemState createState() => _FIRAssignmentListItemState();
}

class _FIRAssignmentListItemState extends State<FIRAssignmentListItem> {
  String selectedOfficer = '';

  void _assignFIRToUser(String role) {
    if (selectedOfficer.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('firs')
          .doc(widget.firSnapshot.id)
          .update({'assignedTo': selectedOfficer, 'assignedRole': role}).then(
              (_) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('FIR Assigned'),
              content: Text(
                  'FIR ${widget.firSnapshot['firNumber']} has been assigned to $selectedOfficer with role $role.'),
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
      }).catchError((error) {
        print('Error assigning FIR: $error');
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select an officer to assign the FIR.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('FIR Number ${widget.firSnapshot['firNumber']}'),
      subtitle: Text(
          'Assigned To: ${widget.firSnapshot['assignedTo'] ?? 'Not Assigned'}'),
      trailing: DropdownButton<String>(
        value: selectedOfficer,
        hint: const Text('Select Officer'),
        onChanged: (String? newValue) {
          setState(() {
            selectedOfficer = newValue!;
          });
        },
        items: <String>[
          'Moazzam - SHO',
          'Talha - Inspector',
          'Furqan - Sub Inspector',
          'Ali - DSP',
          'Babar - ASP',
          'Zeeshan - SP',
          'Zulqarnain - SSP',
          'Other',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Assign FIR'),
              content: Column(
                children: [
                  Text(
                      'Select an officer to assign FIR ${widget.firSnapshot['firNumber']}'),
                  DropdownButton<String>(
                    value: selectedOfficer,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOfficer = newValue!;
                      });
                    },
                    items: <String>[
                      'Moazzam - SHO',
                      'Talha - Inspector',
                      'Furqan - Sub Inspector',
                      'Ali - DSP',
                      'Babar - ASP',
                      'Zeeshan - SP',
                      'Zulqarnain - SSP',
                      'Other',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    List<String> parts = selectedOfficer.split(' - ');
                    String role = parts.length > 1 ? parts[1] : 'Other';
                    _assignFIRToUser(role);
                    Navigator.pop(context);
                  },
                  child: const Text('Assign'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
