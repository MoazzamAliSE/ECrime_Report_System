import 'package:ecrime/admin/view/view_admin_barrel.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home Page'),
        centerTitle: true,
      ),
      body: BackgroundFrame(
        child: const HomeScreenAdminBody(),
      ),
    );
  }
}



// class AdminHomePage extends StatelessWidget {
//   const AdminHomePage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Home Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ViewFIRsPage()),
//                 );
//               },
//               icon: const Icon(Icons.article_outlined),
//               label: const Text('View FIRs'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ViewCorruptionReportsPage()),
//                 );
//               },
//               icon: const Icon(Icons.warning_outlined),
//               label: const Text('View Corruption Reports'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => AddPoliceStationPage()),
//                 );
//               },
//               icon: const Icon(Icons.add_location_outlined),
//               label: const Text('Add Police Stations'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const ManageFIRStatusPage()),
//                 );
//               },
//               icon: const Icon(Icons.assignment_turned_in_outlined),
//               label: const Text('Manage FIR Status'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const AssignFIRPage()),
//                 );
//               },
//               icon: const Icon(Icons.assignment_ind_outlined),
//               label: const Text('Assign FIR'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
