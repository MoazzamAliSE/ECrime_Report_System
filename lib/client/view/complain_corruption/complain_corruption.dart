import 'package:ecrime/client/view%20model/controller/complain_controller/complain_controller.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({super.key, required this.complainType});
  final String complainType;
  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
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
  final controller = Get.put(ComplainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.complainType == complainService
            ? 'Complaint for Service'
            : 'Complaint for Corruption'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.complainType == complainService
                    ? 'Report Service'
                    : 'Report Corruption',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Submit your complaint below:',
                style: TextStyle(
                  fontSize: 18, // You can adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Institute:',
                style: TextStyle(
                  fontSize: 18, // You can adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                'Select Institute',
                institutesList,
                (value) => controller.institute.value = value!,
              ),
              const SizedBox(height: 20),
              const Text(
                'Region',
                style: TextStyle(
                  fontSize: 18, // You can adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildDropdown(
                'Region',
                pakistanProvinces,
                (value) => controller.region.value = value!,
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter Details:',
                style: TextStyle(
                  fontSize: 18, // You can adjust the size as needed
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              GenericTextField(
                hintText: widget.complainType == complainService
                    ? 'Enter details about service...'
                    : 'Enter details about corruption...',
                maxLines: 4,
                minLines: 4,
                controller: controller.detail,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    controller.picEvidence();
                  },
                  child: Obx(() => controller.evidenceName.isEmpty
                      ? const Text('Upload Document/Picture/Video')
                      : Text(controller.evidenceName.value))),
              const SizedBox(height: 20),
              SizedBox(
                width: 120,
                height: 45,
                child: ElevatedButton(
                  onPressed: controller.loading.value
                      ? null
                      : () => controller.registerComplain(widget.complainType),
                  child: Obx(() => controller.loading.value
                      ? Center(
                          child: SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        )
                      : const Text('Submit Complaint')),
                ),
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
