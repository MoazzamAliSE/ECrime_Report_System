import 'package:ecrime/admin/view%20model/controller/assign_fir_controller.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../client/utils/utils.dart';

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
                  MaterialPageRoute(builder: (context) => AssignFIRPage()),
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

class AssignFIRPage extends StatefulWidget {
  AssignFIRPage({super.key});

  @override
  State<AssignFIRPage> createState() => _AssignFIRPageState();
}

class _AssignFIRPageState extends State<AssignFIRPage> {
  // String selectedOfficer = 'Moazzam - SHO';
  final controller = Get.put(AssignFirController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign FIR'),
      ),
      body: BackgroundFrame(
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('Firs'),
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  Text(' ${snapshot.child('assignTo').value.toString()}'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        'Current Status : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(snapshot.child('status').value.toString()),
                    ],
                  ),
                  const Text(
                    'Update Status',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text('Select officer'),
                              content: Obx(
                                () => SizedBox(
                                  height: 120,
                                  child: Column(
                                    children: [
                                      DropdownButton<String>(
                                        value: controller.selectedOfficer.value,
                                        hint: const Text('Select Officer'),
                                        onChanged: (String? newValue) {
                                          controller.selectedOfficer.value =
                                              newValue!;
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
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                      SizedBox(height: 10,),
                                      Align(alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        child: Text('Assign'),
                                        onPressed: () {
                                          FirebaseDatabase.instance.ref('Firs').child(snapshot.child('key').value.toString()).update({
                                            'assignTo' : controller.selectedOfficer.value
                                          }).then((value) {
                                            Get.back();
                                          });
                                        },
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        },
                      );
                    },
                    child: Text('Assign'),
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
