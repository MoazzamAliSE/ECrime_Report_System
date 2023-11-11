import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';

class StatusResultPage extends StatelessWidget {
  final String firStatus;

  const StatusResultPage({Key? key, required this.firStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(firStatus);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Status'),
      ),
      body: BackgroundFrame(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Your FIR Status',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    firStatus,
                    style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      
      default:
        return Colors.grey;
    }
  }
}
