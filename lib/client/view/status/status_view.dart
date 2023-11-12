import 'package:ecrime/client/view/status/result_status.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String selectedDistrict = 'Lahore';
  String selectedPoliceStation = 'Thana A division Sahiwal';
  String firNumber = '';
  TextEditingController firNumberController = TextEditingController();

  List<String> districtList = [
    'Lahore',
    'Karachi',
    'Islamabad',
    'Rawalpindi',
    'Multan',
    'Faisalabad',
    'Peshawar',
    'Quetta',
    'Sialkot',
    'Gujranwala',
    'Gujrat',
    'Sargodha',
    'Abbottabad',
    'Sialkot',
    'Bahawalpur',
    'Jhelum',
    'Sukkur',
    'Larkana',
    'Mirpur (AJK)',
    'Muzaffarabad (AJK)',
  ];

  List<String> policeStations = [
    'Thana A division Sahiwal',
    'Thana B division Lahore',
    'Thana C division Karachi'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check FIR Status'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter the Following details',
                style: TextStyle(
                  fontSize: 18, // You can adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildDropdown('District', districtList, (value) {
                setState(() {
                  selectedDistrict = value!;
                });
              }),
              const SizedBox(height: 16.0),
              _buildDropdown('Police Station', policeStations, (value) {
                setState(() {
                  selectedPoliceStation = value!;
                });
              }),
              const SizedBox(height: 16.0),
              GenericTextField(
                labelText: 'FIR Number',
                controller: firNumberController,
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  String firStatus = 'Accepted';
                  _showStatusPage(firStatus);
                },
                child: const Text('Check'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatusPage(String firStatus) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusResultPage(firStatus: firStatus),
      ),
    );
  }

  Widget _buildDropdown(
      String labelText, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      key: Key(labelText),
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding: const EdgeInsets.all(16.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.black, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
      value: labelText == 'District' ? selectedDistrict : selectedPoliceStation,
    );
  }
}
