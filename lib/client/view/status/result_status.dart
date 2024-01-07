import 'package:flutter/material.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';

class StatusResultPage extends StatefulWidget {
  final String firStatus;
  final double progressPercentage;

  const StatusResultPage({
    Key? key,
    required this.firStatus,
    required this.progressPercentage,
  }) : super(key: key);

  @override
  _StatusResultPageState createState() => _StatusResultPageState();
}

class _StatusResultPageState extends State<StatusResultPage> {
  @override
  Widget build(BuildContext context) {
    Color statusColor = _getStatusColor(widget.firStatus);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Status'),
      ),
      body: BackgroundFrame(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      widget.firStatus,
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Use AnimatedContainer for height animation
                LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(10),
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                  value: widget.progressPercentage,
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Progress: ${(widget.progressPercentage * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
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
