import 'package:ecrime/admin/view/view_admin_barrel.dart';

class FIRListItem extends StatelessWidget {
  final QueryDocumentSnapshot firSnapshot;

  const FIRListItem({super.key, required this.firSnapshot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(firSnapshot['userImage']),
      ),
      title: Text('FIR Number ${firSnapshot['firNumber']}'),
      subtitle: Text('Submitted at ${firSnapshot['timestamp']}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FIRDetailPage(firSnapshot: firSnapshot),
          ),
        );
      },
    );
  }
}