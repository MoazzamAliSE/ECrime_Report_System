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
            return  Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submitted by: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(snapshot.child('name').value.toString()),
                  Row(
                    children: [
                      const Text(
                        'Submitted at: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  Text(
                      ' ${snapshot.child('incidentDetails').value.toString()}'),
                  const SizedBox(height: 10),
                  const Text(
                    'Assign to: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),

                  Text(
                      ' ${snapshot.child('assignTo').value.toString()}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Current Status : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(snapshot
                          .child('status')
                          .value
                          .toString()),






                    ],
                  ),
                  const Text(
                    'Update Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(onPressed: () {
                        FirebaseDatabase.instance.ref('Firs').child(snapshot.child('key').value.toString()).update({
                          'status' : 'Pending'
                        }).then((value) {
                          Utils.showSnackBar('Success', 'Suceesfully Updated', Icon(Icons.done_all));
                        });
                      }, child: Text('Pending')),
                      TextButton(onPressed: () {
                        FirebaseDatabase.instance.ref('Firs').child(snapshot.child('key').value.toString()).update({
                          'status' : 'Rejected'
                        });
                      }, child: Text('Reject')),
                      TextButton(onPressed: () {
                        FirebaseDatabase.instance.ref('Firs').child(snapshot.child('key').value.toString()).update({
                          'status' : 'In Progress'
                        });
                      }, child: Text('Progress')),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


