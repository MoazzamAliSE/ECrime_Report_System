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
  File? _profilePic; // Store the selected profile picture File
  final String _email = ''; // User's email fetched from Firebase
  final String _fullName = ''; // User's full name fetched from Firebase
  final String _userName = ''; // User's full name fetched from Firebase
  final String _phoneNo = ''; // User's phone number fetched from Firebase
  late User _user; // Store the current user
  @override
  void initState() {
    super.initState();
    // Fetch user details from Firebase and set them in the state variables
    // You need to replace 'yourUserId' with the actual user ID or use FirebaseAuth to get the current user
    // Example: FirebaseAuth.instance.currentUser?.uid
    // Fetch the user details and set them in the state variables
    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    // Example: Replace the following lines with Firebase Firestore or Realtime Database queries
    // Fetch the user details and set them in the state variables
    _emailController.text = _user.email ?? '';
    _fullNameController.text = _user.displayName ?? '';
    _usernameController.text = _user.displayName ?? '';
    // _phoneNoController.text = ?; // Fetch phone number from Firebase
  }

  // Function to handle image picking
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  // Open the image picker dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Image Source'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                              _pickImage(ImageSource.gallery);
                            },
                            child: const Text('Gallery'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
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
                      ? FileImage(
                          _profilePic!) // Display selected image if available
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
                // Save changes logic goes here
                // You can access the entered data using _profilePicController.text and _usernameController.text
                // Update the user's profile data accordingly
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Changes saved successfully!'),
                ));
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveChanges() async {
    // Update user details in Firebase (Firestore or Realtime Database)
    try {
      if (_profilePic != null) {
        // Update profile picture
        // await _user.updatePhoto(FileImage(_profilePic!) as ImageProvider<Object>);
      }

      // Update username
      await _user.updateDisplayName(_usernameController.text);

      // Reload the user to get the updated information
      await _user.reload();
      _user = FirebaseAuth.instance.currentUser!;
    } catch (e) {
      print('Error updating user details: $e');
    }
  }
}
