import 'dart:io';

import 'package:ecrime/client/view/investigation_update/investigation_update.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:ecrime/client/widgets/generic_text_form_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

export 'package:intl/intl.dart';

class InvestigationDetailsPage extends StatefulWidget {
  const InvestigationDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  _InvestigationDetailsPageState createState() =>
      _InvestigationDetailsPageState();
}

class _InvestigationDetailsPageState extends State<InvestigationDetailsPage> {
  File? _uploadedFile;
  DateTime selectedDateTime = DateTime(2023, 8, 22, 21, 0);

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('h:mm a dd/MM/yy').format(dateTime);
  }

  TextEditingController firUpdateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investigation Details'),
      ),
      body: BackgroundFrame(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInvestigationDetail('Case ID', '343294309243'),
                _buildInvestigationDetail('Investigating Officer', 'ABC Name'),
                _buildInvestigationDetail('Date Opened', '22/08/2022'),
                _buildInvestigationDetail('Status', 'Accepted'),
                _buildInvestigationDetail(
                    'Description', 'Any number of lines from Firebase'),
                const Divider(),
                _buildDateTime(context),
                const SizedBox(height: 20),
                const Text(
                  'FIR Update',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GenericTextField(
                  controller: firUpdateController,
                  maxLines: 5,
                  minLines: 5,
                  labelText: "Enter the updated information here",
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showImagePickerDialog(context);
                  },
                  child: const Text('Upload Document or Pic'),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: _uploadedFile != null
                      ? _buildUploadedFile(context)
                      : Container(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildDateTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDateTime(selectedDateTime),
        ),
        ElevatedButton(
          onPressed: () async {
            DateTime? pickedDateTime = await showDatePicker(
              context: context,
              initialDate: selectedDateTime,
              firstDate: DateTime(2023),
              lastDate: DateTime(2025),
            );

            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(selectedDateTime),
            );

            if (pickedTime != null) {
              setState(() {
                selectedDateTime = DateTime(
                  pickedDateTime!.year,
                  pickedDateTime.month,
                  pickedDateTime.day,
                  pickedTime.hour,
                  pickedTime.minute,
                );
              });
            }
          },
          child: const Text('Update Date and Time'),
        ),
      ],
    );
  }

  Widget _buildInvestigationDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$title:'),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildUploadedFile(BuildContext context) {
    return Stack(
      children: [
        _uploadedFile!.path.endsWith('.pdf')
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    _uploadedFile!.uri.pathSegments.last,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              )
            : Image.file(_uploadedFile!,
                fit: BoxFit.cover, width: 200, height: 200),
        Positioned(
          top: 0,
          right: 0,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _uploadedFile = null;
              });
            },
            child: const Text('Delete'),
          ),
        ),
      ],
    );
  }

  Future<void> _showImagePickerDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Upload Type'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Upload Image from Gallery'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text('Capture Image from Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickDocument();
              },
              child: const Text('Upload PDF Document'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _uploadedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _uploadedFile = File(pickedFile.path);
      });
    }
  }
}
