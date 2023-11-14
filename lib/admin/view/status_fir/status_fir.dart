import 'package:ecrime/client/utils/utils.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../view_fir/fir_detail_page/fir_detail_page.dart';

class ManageFIRStatusPage extends StatelessWidget {
  const ManageFIRStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage FIR Status'),
      ),
      body: BackgroundFrame(
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('Firs'),
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Submitted by: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(snapshot.child('name').value.toString()),
                      Row(
                        children: [
                          const Text(
                            'Submitted at: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(snapshot
                              .child('incidentDateTime')
                              .value
                              .toString()
                              .substring(
                                  0,
                                  snapshot
                                      .child('incidentDateTime')
                                      .value
                                      .toString()
                                      .indexOf(' -'))),
                        ],
                      ),
                      const Text(
                        'Description: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                          ' ${snapshot.child('incidentDetails').value.toString()}'),
                      const SizedBox(height: 10),
                      const Text(
                        'Assign to: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(' ${snapshot.child('assignTo').value.toString()}'),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Text(
                            'Current Progress : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("50%"), //yaha
                        ],
                      ),
                      const SwipeableProgressIndicator(),
                      Row(
                        children: [
                          const Text(
                            'Current Status : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(snapshot.child('status').value.toString()),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Update Status here',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                              icon: const Icon(Icons.schedule),
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref('Firs')
                                    .child(
                                        snapshot.child('key').value.toString())
                                    .update({'status': 'Pending'}).then(
                                        (value) {
                                  Utils.showSnackBar(
                                      'Success',
                                      'Fir Status Updated',
                                      const Icon(Icons.done_all));
                                });
                              },
                              label: const Text('Pending')),
                          TextButton.icon(
                              icon: const Icon(Icons.cancel),
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref('Firs')
                                    .child(
                                        snapshot.child('key').value.toString())
                                    .update({'status': 'Rejected'}).then(
                                        (value) => Utils.showSnackBar(
                                            'Success',
                                            'Fir Status Updated',
                                            const Icon(Icons.done_all)));
                              },
                              label: const Text('Reject')),
                          TextButton.icon(
                              icon: const Icon(Icons.hourglass_bottom),
                              onPressed: () {
                                FirebaseDatabase.instance
                                    .ref('Firs')
                                    .child(
                                        snapshot.child('key').value.toString())
                                    .update({'status': 'In Progress'}).then(
                                        (value) => Utils.showSnackBar(
                                            'Success',
                                            'Fir Status Updated',
                                            const Icon(Icons.done_all)));
                              },
                              label: const Text('Progress')),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SwipeableProgressIndicator extends StatefulWidget {
  const SwipeableProgressIndicator({super.key});

  @override
  _SwipeableProgressIndicatorState createState() =>
      _SwipeableProgressIndicatorState();
}

class _SwipeableProgressIndicatorState
    extends State<SwipeableProgressIndicator> {
  double _progress = 0.5; // Initial progress value (between 0 and 1)

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Progress: ${(_progress * 100).toStringAsFixed(2)}%',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 5),
          Slider(
            value: _progress,
            onChanged: (value) {
              setState(() {
                _progress = value;
              });
            },
            activeColor: Colors.green, // Set the progress color to green
          ),
        ],
      ),
    );
  }
}
