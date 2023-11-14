import 'package:ecrime/client/view/status/result_status.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String selectedDistrict = 'Lahore';
  String selectedPoliceStation = 'Thana A division Sahiwal';
  String firNumber = '';
  TextEditingController firNumberController = TextEditingController();

  List<String> districtList = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Rawalpindi',
    'Multan',
    'Faisalabad',
    'Peshawar',
    'Quetta',
    'Sialkot',
    'Gujranwala',
    'Gujrat',
    'Sargodha',
    'Abbottabad',
    'Sialkot',
    'Bahawalpur',
    'Jhelum',
    'Sukkur',
    'Larkana',
    'Mirpur (AJK)',
    'Muzaffarabad (AJK)',
  ];

  List<String> policeStations = [
    'Thana A division Sahiwal',
    'Thana B division Lahore',
    'Thana C division Karachi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check FIR Status'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FirebaseAnimatedList(
            defaultChild: Center(
              child: SizedBox(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            query: FirebaseDatabase.instance.ref('Firs'),
            itemBuilder: (context, snapshot, animation, index) {
              if(snapshot.children.isNotEmpty){

                 if (snapshot.child('email').value.toString().toLowerCase() ==
                    FirebaseAuth.instance.currentUser!.email!.toLowerCase()) {
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Material(
                      color: AppColor.backgroundColor,
                      child: InkWell(
                        onTap: () {
                          Get.to(StatusResultPage(
                            firStatus: snapshot.child('status').value.toString(),
                            progressPercentage: double.parse(snapshot.child('progress').value.toString()), // yaha par change karna...
                          ));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Fir Number: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(snapshot
                                        .child('firNumber')
                                        .value
                                        .toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Submitted at: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
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
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                    ' ${snapshot.child('incidentDetails').value.toString()}'),
                                const Text(
                                  'Assign to: ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                    ' ${snapshot.child('assignTo').value.toString()}'),
                                Row(
                                  children: [
                                    const Text(
                                      'Current Status : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(snapshot
                                        .child('status')
                                        .value
                                        .toString()),





                                  ],
                                ),

                                // if(snapshot
                                //     .child('status')
                                //     .value
                                //     .toString()=='In Progress')
                                //
                                //   Center(
                                //     child: SizedBox(
                                //       height: 5,
                                //       width: 150,
                                //       child: Column(
                                //         children: [
                                //           Row(
                                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Text('Progress',style: TextStyle(
                                //                 fontWeight: FontWeight.bold,
                                //               ),),
                                //               Text(((int.parse(snapshot
                                //                   .child('progress')
                                //                   .value.toString()))*100).toString(),style: TextStyle(
                                //
                                //               ),)
                                //             ],
                                //           ),
                                //           LinearProgressIndicator(
                                //               value: double.parse(snapshot
                                //                   .child('progress')
                                //                   .value.toString())
                                //           ),
                                //         ],
                                //       ),
                                //     ),
                                //   )


                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              }
              
              
              return Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                   child: CircularProgressIndicator(
                     color: AppColor.primaryColor,
                   ),
                ),
              );
              
            },
          ),
        ),
      ),
    );
  }

  // void _showStatusPage(String firStatus) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => StatusResultPage(firStatus: firStatus),
  //     ),
  //   );
  // }
  //
  // Widget _buildDropdown(
  //     String labelText, List<String> items, Function(String?) onChanged) {
  //   return DropdownButtonFormField<String>(
  //     key: Key(labelText),
  //     decoration: InputDecoration(
  //       labelText: labelText,
  //       contentPadding: const EdgeInsets.all(16.0),
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         borderSide: const BorderSide(color: Colors.black, width: 1.0),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  //       ),
  //       errorBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
  //       ),
  //       focusedErrorBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         borderSide: const BorderSide(color: Colors.red, width: 2.0),
  //       ),
  //     ),
  //     items: items.map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
  //       );
  //     }).toList(),
  //     onChanged: onChanged,
  //     value: labelText == 'District' ? selectedDistrict : selectedPoliceStation,
  //   );
  // }
}
