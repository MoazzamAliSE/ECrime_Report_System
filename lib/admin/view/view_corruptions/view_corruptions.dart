import 'package:ecrime/admin/view%20model/controller/view_corruption_controller.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../constants.dart';
import 'corruption_compain_page.dart';

class ViewComplaintsPage extends StatefulWidget {
  const ViewComplaintsPage({Key? key}) : super(key: key);

  @override
  _ViewComplaintsPageState createState() => _ViewComplaintsPageState();
}

class _ViewComplaintsPageState extends State<ViewComplaintsPage> {
  bool isComplainService = false;
  bool isDataLoaded = false;

  final controller = Get.put(ViewCorruptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Complaints'),
      ),
      body: BackgroundFrame(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Material(
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(const CorruptionComplainPage(
                              type: 'corruption',
                            ));
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Complaints of\nCorruption',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.to(const CorruptionComplainPage(
                              type: 'service',
                            ));
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.report,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Complaints of\nService',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Statistics in Pie Chart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() => controller.hasData.value
                  ? PieChart(
                      dataMap: {
                        'All Complains': controller.totalComplains.toDouble(),
                        'Corruption': controller.corruptionComplain.toDouble(),
                        'Service': controller.serviceComplain.toDouble(),
                      },
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: MediaQuery.of(context).size.width / 3,
                      colorList: const [Colors.red, Colors.blue, Colors.green],
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 32,
                      centerText: "Complain Stats",
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendShape: BoxShape.rectangle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        chartValueStyle:
                            TextStyle(color: AppColor.primaryColor),
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                        chartValueBackgroundColor: AppColor.whiteColor,
                      ))
                  : Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  final QueryDocumentSnapshot complaint;

  const ComplaintCard({Key? key, required this.complaint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Corruption Type: ${complaint['complaintType']}'),
          Text('Institute Name: ${complaint['instituteName']}'),
          Text('Region Name: ${complaint['regionName']}'),
          Text('Status: ${complaint['status']}'),
          Text('Description: ${complaint['description']}'),
        ],
      ),
    );
  }
}
