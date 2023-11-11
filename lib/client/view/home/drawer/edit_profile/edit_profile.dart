import 'package:ecrime/client/View/widgets/widgets_barrel.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  File? _profilePic;
  final String _email = '';
  final String _fullName = '';
  final String _userName = '';
  final String _phoneNo = '';
  late User _user;
  @override
  void initState() {
    super.initState();

    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    _emailController.text = _user.email ?? '';
    _fullNameController.text = _user.displayName ?? '';
    _usernameController.text = _user.displayName ?? '';
  }

  Future _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profilePic = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BackgroundFrame(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Select Image Source'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                              child: const Text('Gallery'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                              child: const Text('Camera'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profilePic != null
                        ? FileImage(_profilePic!)
                        : _user.photoURL != null
                            ? NetworkImage(_user.photoURL!)
                            : null as ImageProvider<Object>?,
                    child: _profilePic == null && _user.photoURL == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit Email:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenericTextField(
                controller: _emailController,
                hintText: 'Enter your new email',
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit Full Name:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenericTextField(
                controller: _fullNameController,
                hintText: 'Enter your new full name',
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit Username:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenericTextField(
                controller: _usernameController,
                hintText: 'Enter your new username',
              ),
              const SizedBox(height: 20),
              const Text(
                'Edit Phone Number:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GenericTextField(
                controller: _phoneNoController,
                keyboardType: TextInputType.phone,
                hintText: 'Enter your new phone number',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Changes saved successfully!'),
                  ));
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    try {
      if (_profilePic != null) {}

      await _user.updateDisplayName(_usernameController.text);

      await _user.reload();
      _user = FirebaseAuth.instance.currentUser!;
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
