import 'package:ecrime/admin/view/suggestions/suggestion_admin.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:flutter/material.dart';

class HomeScreenAdminBody extends StatelessWidget {
  const HomeScreenAdminBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: 6, // Number of buttons
        itemBuilder: (context, index) {
          return Material(
            child: InkWell(
              splashColor: Colors.white60,
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewFIRsPage()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ViewComplaintsPage()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddPoliceStationPage()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ManageFIRStatusPage()),
                    );
                    break;
                  case 4:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AssignFIRPage()),
                    );
                    break;
                  case 5:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuggestionAdmin()),
                    );
                    break;
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: getGradientForIndex(index),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        getIconForIndex(index),
                        size: 40.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        getTextForIndex(index),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  LinearGradient getGradientForIndex(int index) {
    switch (index) {
      case 0:
        return const LinearGradient(
          colors: [Colors.blue, Colors.teal],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 1:
        return const LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 2:
        return const LinearGradient(
          colors: [Colors.green, Colors.lightGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 3:
        return const LinearGradient(
          colors: [Colors.purple, Colors.deepPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 4:
        return const LinearGradient(
          colors: [Colors.red, Colors.pink],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case 5:
        return const LinearGradient(
          colors: [
            Color.fromARGB(255, 150, 135, 0),
            Color.fromARGB(255, 255, 255, 53)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      default:
        return const LinearGradient(
          colors: [Colors.grey, Colors.grey],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  IconData getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.article_outlined;
      case 1:
        return Icons.warning_outlined;
      case 2:
        return Icons.add_location_outlined;
      case 3:
        return Icons.assignment_turned_in_outlined;
      case 4:
        return Icons.assignment_ind_outlined;
      case 5:
        return Icons.lightbulb;
      default:
        return Icons.error_outline;
    }
  }

  String getTextForIndex(int index) {
    switch (index) {
      case 0:
        return 'View FIRs';
      case 1:
        return 'View Corruption Reports';
      case 2:
        return 'Add Police Stations';
      case 3:
        return 'Manage FIR Status';
      case 4:
        return 'Assign FIR';
      case 5:
        return 'Suggestions';
      default:
        return 'Unknown';
    }
  }
}
