import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AdminHomePage(),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

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
                      builder: (context) => const ViewCorruptionReportsPage()),
                );
              },
              child: const Text('View Corruption Reports'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewCorruptionReportsPage extends StatelessWidget {
  const ViewCorruptionReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Corruption Reports'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('corruptionReports')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> corruptionReports = snapshot.data!.docs;

          int totalReports = corruptionReports.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Corruption Reports: $totalReports',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              PieChart(
                PieChartData(
                  sectionsSpace: 5,
                  centerSpaceRadius: 40,
                  startDegreeOffset: 90,
                  sections: _generatePieChartSections(corruptionReports),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
      List<QueryDocumentSnapshot> corruptionReports) {
    Map<String, int> reportStatusCount = {};

    for (var report in corruptionReports) {
      String status = report['status'] ?? 'Unknown';
      reportStatusCount[status] = (reportStatusCount[status] ?? 0) + 1;
    }

    return reportStatusCount.entries.map((entry) {
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
