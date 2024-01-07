import 'package:ecrime/admin/view/authentication/login_admin/login_admin.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                SharedPreferences pref=await SharedPreferences.getInstance();
                pref.clear();
                Get.offAll(LoginPageAdmin());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BackgroundFrame(
        child: const HomeScreenAdminBody(),
      ),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // Navigate to your login or home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPageAdmin()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
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
