import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/view%20model/controller/editProfile_controller/editProfileController.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final controller = Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: BackgroundFrame(
        child: SingleChildScrollView(
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
                                  onPressed: () {},
                                  child: const Text('Gallery'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Camera'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Obx(() => controller.profileImage.value.isEmpty
                          ? const Center(
                              child: Icon(Icons.camera_alt_outlined),
                            )
                          : CachedNetworkImage(
                              imageUrl: controller.profileImage.value,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: imageProvider,
                                  ),
                              placeholder: (context, url) => Obx(
                                    () => controller.profileImage.isEmpty
                                        ? CircleAvatar(
                                            radius: 50,
                                            child: Center(
                                              child: SizedBox(
                                                height: 15,
                                                width: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColor.primaryColor,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  )))),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Edit Email:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => GenericTextField(
                    controller: controller.emailController.value,
                    hintText: 'Enter your new email',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Edit Full Name:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GenericTextField(
                  controller: controller.fullNameController.value,
                  hintText: 'Enter your new full name',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Edit Username:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GenericTextField(
                  controller: controller.usernameController.value,
                  hintText: 'Enter your new username',
                ),
                const SizedBox(height: 20),
                // const Text(
                //   'Edit Phone Number:',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // GenericTextField(
                //   controller: controller.phoneNoController.value,
                //   keyboardType: TextInputType.phone,
                //   hintText: 'Enter your new phone number',
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.upDateData();
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
