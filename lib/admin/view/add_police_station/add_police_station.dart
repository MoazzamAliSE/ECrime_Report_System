import 'package:ecrime/admin/view/add_police_station/all_stations.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddPoliceStationPage extends StatefulWidget {
  const AddPoliceStationPage({super.key});

  @override
  _AddPoliceStationPageState createState() => _AddPoliceStationPageState();
}

class _AddPoliceStationPageState extends State<AddPoliceStationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController districtController = TextEditingController();

  bool loading = false;

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
            GenericTextField(
                controller: nameController,
                // decoration:
                // const InputDecoration(
                labelText: 'Police Station Name'
                // ),
                ),
            const SizedBox(height: 10),
            GenericTextField(
                controller: locationController,

                // decoration: const InputDecoration(
                labelText: 'Location'
                // ),
                ),
            const SizedBox(height: 10),
            GenericTextField(
                controller: districtController,

                // decoration: const InputDecoration(
                labelText: 'District'
                // ),
                ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.value.text.toString().isEmpty ||
                    locationController.value.text.toString().isEmpty ||
                    districtController.value.text.toString().isEmpty) {
                  Utils.showSnackBar('Warning', 'Please fill data correctly',
                      const Icon(Icons.warning_amber));
                  return;
                }

                setState(() {
                  loading = true;
                });
                FirebaseDatabase.instance
                    .ref('PoliceStations')
                    .child(DateTime.now().microsecondsSinceEpoch.toString())
                    .set({
                  'name': nameController.value.text.toString(),
                  'location': locationController.value.text.toString(),
                  'district': districtController.value.text.toString(),
                }).then((value) {
                  setState(() {
                    loading = false;
                  });
                  Get.back();
                  Utils.showSnackBar(
                      'Success',
                      'Successfully added police station',
                      const Icon(Icons.done_all));
                }).onError((error, stackTrace) {
                  setState(() {
                    Utils.showSnackBar('Warning', 'Something went wrong',
                        const Icon(Icons.warning_amber));
                    loading = false;
                  });
                });
              },
              child: loading
                  ? Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    )
                  : const Text('Add Police Station'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(const AllStations());
              },
              child: const Text('See all police stations'),
            ),
          ],
        ),
      ),
    );
  }
}
