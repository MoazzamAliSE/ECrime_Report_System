import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageFIRStatusPage extends StatelessWidget {
  const ManageFIRStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage FIR Status'),
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
                return FIRStatusListItem(firSnapshot: firs[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class FIRStatusListItem extends StatelessWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRStatusListItem({super.key, required this.firSnapshot});

  void _changeFIRStatus(String newStatus, BuildContext context) {
    FirebaseFirestore.instance
        .collection('firs')
        .doc(firSnapshot.id)
        .update({'status': newStatus}).then((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('FIR Status Updated'),
            content: Text(
                'The status of FIR ${firSnapshot['firNumber']} has been updated to $newStatus.'),
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
      print('Error updating FIR status: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('FIR Number ${firSnapshot['firNumber']}'),
      subtitle: Text('Status: ${firSnapshot['status']}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            onPressed: () => _changeFIRStatus('Accepted', context),
            icon: const Icon(Icons.check, color: Colors.green),
            label: const Text('Accept'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.green),
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () => _changeFIRStatus('Rejected', context),
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text('Reject'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.red),
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () => _changeFIRStatus('Cancelled', context),
            icon: const Icon(Icons.cancel, color: Colors.orange),
            label: const Text('Cancel'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.orange),
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () => _changeFIRStatus('Continue', context),
            icon: const Icon(Icons.arrow_circle_up, color: Colors.orange),
            label: const Text('Continue'),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.orange),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
