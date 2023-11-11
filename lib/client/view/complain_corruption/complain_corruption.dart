import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  String selectedInstitute = 'Police'; 
  String selectedProvince = 'Punjab'; 
  List<String> pakistanProvinces = [
    'Punjab',
    'Sindh',
    'Khyber Pakhtunkhwa',
    'Balochistan',
    'Gilgit-Baltistan',
    'Azad Jammu and Kashmir'
  ];

  List<String> institutesList = ['Police', 'Education', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint for Corruption'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report Corruption',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Submit your complaint below:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              const Text('Select Institute:'),
              const SizedBox(height: 10),
              _buildDropdown(
                'Select Institute',
                institutesList,
                (value) => selectedInstitute = value!,
              ),
              const SizedBox(height: 20),
              const Text('Region'),
              const SizedBox(height: 10),
              _buildDropdown(
                'Region',
                pakistanProvinces,
                (value) => selectedInstitute = value!,
              ),
              const SizedBox(height: 10),
              const Text('Enter Details:'),
              const SizedBox(height: 10),
              GenericTextField(
                hintText: 'Enter details about corruption...',
                maxLines: 4,
                minLines: 4,
                controller: null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  
                  print('Upload Document/Picture/Video');
                },
                child: const Text('Upload Document/Picture/Video'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  
                  print('Complaint Submitted!');
                },
                child: const Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String labelText, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select $labelText';
        }
        return null;
      },
    );
  }
}
