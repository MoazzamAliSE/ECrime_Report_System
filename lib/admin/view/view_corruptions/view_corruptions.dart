import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

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
                                    fontWeight:
                                        FontWeight.bold, // Make text bold
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
                                    fontWeight:
                                        FontWeight.bold, // Make text bold
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
              isDataLoaded ? _buildPieChart() : Container(),
              isDataLoaded ? _buildUserListTiles() : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    Map<String, int> data = isComplainService
        ? {'Resolved': 5, 'InProgress': 3, 'Rejected': 2}
        : {'Resolved': 3, 'InProgress': 1, 'Rejected': 2};

    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      child: PieChart(
        PieChartData(
          sectionsSpace: 5,
          centerSpaceRadius: 40,
          startDegreeOffset: 90,
          sections: _generatePieChartSections(data),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(Map<String, int> data) {
    return data.entries.map((entry) {
      return PieChartSectionData(
        color: _getStatusColor(entry.key),
        value: entry.value.toDouble(),
        title: '${entry.value}',
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();
  }

  Widget _buildUserListTiles() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        List<QueryDocumentSnapshot> users = snapshot.data!.docs;

        return Column(
          children: users
              .map((user) => ListTile(
                    title: Text(user['username']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ComplaintsFromUserPage(userId: user.id),
                        ),
                      );
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    List<Color> colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.red,
      Colors.purple
    ];
    return colors[status.hashCode % colors.length];
  }
}

class ComplaintsFromUserPage extends StatelessWidget {
  final String userId;

  const ComplaintsFromUserPage({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaints from User'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<QueryDocumentSnapshot> userComplaints = snapshot.data!.docs;

          return ListView(
            children: userComplaints
                .map((complaint) => ComplaintCard(complaint: complaint))
                .toList(),
          );
        },
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
