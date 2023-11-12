import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                isComplainService = false;
                isDataLoaded = false;
              });
            },
            child: const Text('Complaints of Corruption'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isComplainService = true;
                isDataLoaded = false;
              });
            },
            child: const Text('Complaints of Service'),
          ),
          // Display the appropriate pie chart based on isComplainService
          isDataLoaded ? _buildPieChart() : Container(),
          // Display list tiles for users who have lodged complaints
          isDataLoaded ? _buildUserListTiles() : Container(),
          ElevatedButton(
            onPressed: () {
              addDummyComplaints();
            },
            child: const Text('Add Dummy Data'),
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    // Placeholder data for demonstration purposes
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
    // Fetch the list of users who have lodged complaints
    // For now, I'm assuming you have a Firestore collection 'users' that stores user information.
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        List<QueryDocumentSnapshot> users = snapshot.data!.docs;

        return Column(
          children: users
              .map((user) => ListTile(
                    title: Text(user[
                        'username']), // Assuming 'username' is a field in your 'users' collection
                    onTap: () {
                      // Navigate to a new page showing all complaints from this user
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

  void addDummyComplaints() async {
    // Add dummy users
    DocumentReference johnDoeRef =
        await FirebaseFirestore.instance.collection('users').add({
      'username': 'JohnDoe',
      'email': 'john.doe@example.com',
    });

    DocumentReference janeDoeRef =
        await FirebaseFirestore.instance.collection('users').add({
      'username': 'JaneDoe',
      'email': 'jane.doe@example.com',
    });

    // Add dummy complaints
    await FirebaseFirestore.instance.collection('complaints').add({
      'userId': johnDoeRef.id,
      'complaintType': isComplainService ? 'Service' : 'Corruption',
      'instituteName': 'ABC Institute',
      'regionName': 'City A',
      'status': 'Resolved',
      'description':
          'This is a complaint about ${isComplainService ? 'service' : 'corruption'}.',
    });

    await FirebaseFirestore.instance.collection('complaints').add({
      'userId': johnDoeRef.id,
      'complaintType': isComplainService ? 'Service' : 'Corruption',
      'instituteName': 'XYZ Corporation',
      'regionName': 'City B',
      'status': 'InProgress',
      'description':
          'This is a complaint about ${isComplainService ? 'service' : 'corruption'}.',
    });

    await FirebaseFirestore.instance.collection('complaints').add({
      'userId': janeDoeRef.id,
      'complaintType': isComplainService ? 'Service' : 'Corruption',
      'instituteName': 'PQR Organization',
      'regionName': 'City C',
      'status': 'Rejected',
      'description':
          'This is a complaint about ${isComplainService ? 'service' : 'corruption'}.',
    });

    setState(() {
      isDataLoaded = true;
    });

    print('Dummy data added');
  }
}

class ComplaintsFromUserPage extends StatelessWidget {
  final String userId;

  const ComplaintsFromUserPage({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch and display all complaints from the selected user
    // Use the userId to filter complaints in Firestore
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
            return const CircularProgressIndicator();
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
          // Add more fields as needed
        ],
      ),
    );
  }
}

void addDummyComplaints() async {
  // Add dummy users
  DocumentReference johnDoeRef =
      await FirebaseFirestore.instance.collection('users').add({
    'username': 'JohnDoe',
    'email': 'john.doe@example.com',
  });

  DocumentReference janeDoeRef =
      await FirebaseFirestore.instance.collection('users').add({
    'username': 'JaneDoe',
    'email': 'jane.doe@example.com',
  });

  // Add dummy corruption complaints
  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': johnDoeRef.id,
    'complaintType': 'Corruption',
    'instituteName': 'ABC Institute',
    'regionName': 'City A',
    'status': 'Resolved',
    'description': 'This is a complaint about corruption.',
  });

  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': johnDoeRef.id,
    'complaintType': 'Corruption',
    'instituteName': 'XYZ Corporation',
    'regionName': 'City B',
    'status': 'InProgress',
    'description': 'This is a complaint about corruption.',
  });

  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': janeDoeRef.id,
    'complaintType': 'Corruption',
    'instituteName': 'PQR Organization',
    'regionName': 'City C',
    'status': 'Rejected',
    'description': 'This is a complaint about corruption.',
  });

  // Add dummy service complaints
  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': johnDoeRef.id,
    'complaintType': 'Service',
    'instituteName': 'ABC Service Provider',
    'regionName': 'City A',
    'status': 'Resolved',
    'description': 'This is a complaint about service.',
  });

  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': johnDoeRef.id,
    'complaintType': 'Service',
    'instituteName': 'XYZ Service Company',
    'regionName': 'City B',
    'status': 'InProgress',
    'description': 'This is a complaint about service.',
  });

  await FirebaseFirestore.instance.collection('complaints').add({
    'userId': janeDoeRef.id,
    'complaintType': 'Service',
    'instituteName': 'PQR Service Organization',
    'regionName': 'City C',
    'status': 'Rejected',
    'description': 'This is a complaint about service.',
  });

  print('Dummy data added');
}
