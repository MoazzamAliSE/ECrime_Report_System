import 'package:ecrime/client/view%20model/controller/register%20fir/register_fir_controller.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterFIR extends StatefulWidget {
  const RegisterFIR({Key? key}) : super(key: key);

  @override
  _RegisterFIRState createState() => _RegisterFIRState();
}

class _RegisterFIRState extends State<RegisterFIR> {
  final controller = Get.put(RegisterFirController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step1Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3Key = GlobalKey<FormState>();
  final GlobalKey<FormState> _step4Key = GlobalKey<FormState>();

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
                  controller.model.value.victimType = value;
                  // setState(() {
                  //   firModel.victimType = value!;
                  // });
                },
              ),
              _buildDropdown('FIR Type', [
                'General FIR',
                'Accident FIR',
                'Domestic Violence FIR'
              ], (value) {
                controller.model.value.firType = value!;
              }),
              _buildTextFormField(
                  'Name',
                  (value) => controller.model.value.name = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Name')),
              _buildTextFormField(
                  'Father\'s Name',
                  (value) => controller.model.value.fathersName = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Father\'s Name')),
              _buildTextFormField(
                  'CNIC',
                  (value) => controller.model.value.cnic = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'CNIC'),
                  keyboardType: TextInputType.number),
              _buildTextFormField(
                  'Phone Number',
                  (value) => controller.model.value.phoneNumber = value ?? '',
                  _step1Key,
                  (value) => _validateField(value, 'Phone Number'),
                  keyboardType: TextInputType.number),
              _buildTextFormField(
                  'Address',
                  (value) => controller.model.value.address = value ?? '',
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
                (value) => controller.model.value.incidentDistrict = value!,
              ),
              _buildTextFormField(
                  'Incident Address ',
                  (value) =>
                      controller.model.value.incidentAddress = value ?? '',
                  _step2Key,
                  (value) => _validateField(value, 'Incident Address')),
              _buildDateTimePicker(),
              Obx(() => _buildDropdown(
                'Nearest Police Station',
                controller.stationList,
                    (value) => controller.model.value.nearestPoliceStation = value!,
              ),),
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
                  (value) =>
                      controller.model.value.incidentSubject = value ?? '',
                  _step3Key,
                  (value) => _validateField(value, 'Incident Subject')),
              _buildTextFormField(
                'Incident Details',
                (value) => controller.model.value.incidentDetails = value ?? '',
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
                      controller.picEvidenceImageVideo();
                    },
                    child: Obx(
                      () => controller.evidenceType.value == 'media'
                          ? Text(controller.fileName.value,
                              overflow: TextOverflow.ellipsis)
                          : const Text('Upload Videos/Pictures'),
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      // print('Upload Documents');
                      controller.picEvidenceDoc();
                    },
                    child: Obx(
                      () => controller.evidenceType.value == 'doc'
                          ? Text(
                              controller.fileName.value,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const Text('Upload Documents'),
                    )),
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
        Obx(
          () => Row(
            children: options.map((String option) {
              return Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: controller.fireType.value,
                    onChanged: (value) {
                      controller.fireType.value = value!;
                    },
                  ),
                  Text(option),
                ],
              );
            }).toList(),
          ),
        )
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
      {TextEditingController? controller,
      int? minLines,
      int? maxLines,
      TextInputType? keyboardType}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GenericTextField(
        controller: controller,
        labelText: labelText,
        keyboardType: keyboardType ?? TextInputType.text,
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Text('Incident Date'),
          const Spacer(),
          InkWell(
              onTap: () => _selectDateAndTime(context),
              child: Obx(
                () => Text(
                  DateFormat('MMMM d, y - hh:mm a')
                      .format(controller.date.value),
                  style: const TextStyle(color: Colors.blue),
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: controller.model.value.incidentDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(controller.model.value.incidentDateTime),
      );

      if (pickedTime != null) {
        DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        controller.date.value = pickedDateTime;
        controller.model.value.incidentDateTime = pickedDateTime;
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
            child: Obx(
              () => Stepper(
                type: StepperType.horizontal,
                currentStep: controller.stepper.value,
                steps: steps,
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: controller.loading.value
                              ? null
                              : () {
                                  GlobalKey<FormState> currentStepKey;
                                  switch (controller.stepper.value) {
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
                                    if (controller.stepper.value <
                                        steps.length - 1) {
                                      controller.stepper.value += 1;
                                    } else {
                                      controller.registerFir();
                                    }
                                  }
                                },
                          child: Container(
                              height: 50,
                              width: 110,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Obx(
                                () => controller.loading.value
                                    ? Center(
                                        child: SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        controller.stepper < 3
                                            ? 'Continue'
                                            : 'Submit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .copyWith(color: Colors.white),
                                      ),
                              )),
                        ),
                        GestureDetector(
                          onTap: controller.loading.value
                              ? null
                              : () {
                                  if (controller.stepper.value > 0) {
                                    controller.stepper.value -= 1;
                                  }
                                },
                          child: Container(
                            height: 50,
                            width: 110,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Cancle',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
