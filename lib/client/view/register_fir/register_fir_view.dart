import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:intl/intl.dart';

class FIRModel {
  String victimType = '';
  String firType = '';
  String name = '';
  String fathersName = '';
  String cnic = '';
  String phoneNumber = '';
  String address = '';
  String incidentDistrict = '';
  String incidentAddress = '';
  DateTime incidentDateTime = DateTime.now();
  String nearestPoliceStation = '';
  String incidentSubject = '';
  String incidentDetails = '';
}

class RegisterFIR extends StatefulWidget {
  const RegisterFIR({Key? key}) : super(key: key);

  @override
  _RegisterFIRState createState() => _RegisterFIRState();
}

class _RegisterFIRState extends State<RegisterFIR> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step4Key = GlobalKey<FormState>();

  final FIRModel firModel = FIRModel();
  String simpleSpace = '';
  int currentStep = 0;
  List<String> policeStationList = [
    'Thana A division Sahiwal',
    'Thana B division Lahore',
    'Thana C division Karachi'
  ];
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
  late List<Step> steps;

  @override
  void initState() {
    super.initState();
    steps = _buildSteps();
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text(simpleSpace),
        content: Form(
          key: _step1Key,
          child: Column(
            children: [
              const Text('Victim Details'),
              _buildRadioButtons(
                ['Myself', 'Someone Else', 'Both'],
                (value) {
                  setState(() {
                    firModel.victimType = value!;
                  });
                },
              ),
              _buildDropdown('FIR Type', [
                'General FIR',
                'Accident FIR',
                'Domestic Violence FIR'
              ], (value) {
                setState(() {
                  firModel.firType = value!;
                });
              }),
              _buildTextFormField(
                  'Name',
                  (value) => firModel.name = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Name')),
              _buildTextFormField(
                  'Father\'s Name',
                  (value) => firModel.fathersName = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Father\'s Name')),
              _buildTextFormField(
                  'CNIC',
                  (value) => firModel.cnic = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'CNIC')),
              _buildTextFormField(
                  'Phone Number',
                  (value) => firModel.phoneNumber = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Phone Number')),
              _buildTextFormField(
                  'Address',
                  (value) => firModel.address = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Address')),
            ],
          ),
        ),
        state: StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(simpleSpace),
        content: Form(
          key: _step2Key,
          child: Column(
            children: [
              const Text('Incident Location'),
              _buildDropdown(
                'Incident District',
                districtList,
                (value) => firModel.incidentDistrict = value!,
              ),
              _buildTextFormField(
                  'Incident Address ',
                  (value) => firModel.incidentAddress = value ?? '',
                  _step2Key,
                  (value) => _validateField(value, 'Incident Address')),
              _buildDateTimePicker(),
              _buildDropdown(
                'Nearest Police Station',
                policeStationList,
                (value) => firModel.nearestPoliceStation = value!,
              ),
            ],
          ),
        ),
        state: StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(simpleSpace),
        content: Form(
          key: _step3Key,
          child: Column(
            children: [
              const Text('Incident Details'),
              _buildTextFormField(
                  'Incident Subject',
                  (value) => firModel.incidentSubject = value ?? '',
                  _step3Key,
                  (value) => _validateField(value, 'Incident Subject')),
              _buildTextFormField(
                'Incident Details',
                (value) => firModel.incidentDetails = value ?? '',
                _step3Key,
                (value) => _validateField(value, 'Incident Details'),
                minLines: 5,
                maxLines: 5,
              ),
            ],
          ),
        ),
        state: StepState.indexed,
        isActive: true,
      ),
      Step(
        title: Text(simpleSpace),
        content: Form(
          key: _step4Key,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Evidence',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    print('Upload Videos or Pictures');
                  },
                  child: const Text('Upload Videos/Pictures'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print('Upload Documents');
                  },
                  child: const Text('Upload Documents'),
                ),
              ],
            ),
          ),
        ),
        state: StepState.indexed,
        isActive: true,
      ),
    ];
  }

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  Widget _buildRadioButtons(
    List<String> options,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Victim Type"),
        Row(
          children: options.map((String option) {
            return Row(
              children: [
                Radio<String>(
                  value: option,
                  groupValue: firModel.victimType,
                  onChanged: (value) => onChanged(value),
                ),
                Text(option),
              ],
            );
          }).toList(),
        ),
      ],
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

  Widget _buildTextFormField(String labelText, void Function(String?)? onSaved,
      GlobalKey<FormState> key, String? Function(dynamic value) param2,
      {TextEditingController? controller, int? minLines, int? maxLines}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GenericTextField(
        controller: controller,
        labelText: labelText,
        onSaved: onSaved,
        minLines: minLines,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateTimePicker() {
    String formattedDateTime =
        DateFormat('MMMM d, y - hh:mm a').format(firModel.incidentDateTime);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text('Incident Date and Time:'),
          const SizedBox(width: 8.0),
          InkWell(
            onTap: () => _selectDateAndTime(context),
            child: Text(
              formattedDateTime,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: firModel.incidentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(firModel.incidentDateTime),
      );

      if (pickedTime != null) {
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          firModel.incidentDateTime = pickedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FIR Form'),
      ),
      body: BackgroundFrame(
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepContinue: () {
              GlobalKey<FormState> currentStepKey;
              switch (currentStep) {
                case 0:
                  currentStepKey = _step1Key;
                  break;
                case 1:
                  currentStepKey = _step2Key;
                  break;
                case 2:
                  currentStepKey = _step3Key;
                  break;
                case 3:
                  currentStepKey = _step4Key;
                  break;
                default:
                  return;
              }

              if (currentStepKey.currentState!.validate()) {
                if (currentStep < steps.length - 1) {
                  setState(() {
                    currentStep += 1;
                    print(currentStep);
                  });
                }
              }
            },
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              }
            },
            steps: steps,
          ),
        ),
      ),
    );
  }
}
