import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:ecrime/client/res/routes/app_routes.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/view%20model/controller/home%20controller/home_controller.dart';
import 'package:ecrime/client/view/home/drawer/edit_profile/edit_profile.dart';
import 'package:ecrime/client/view/home/drawer/helpLine_contacts/helpLine_contacts.dart';
import 'package:ecrime/client/view/home/drawer/suggestion_page/suggestion_page.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});
   final controller=Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _buildDrawerHeader(),
          _buildDrawersecondSection(context),
        ],
      ),
    );
  }

  Column _buildDrawersecondSection(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Edit Profile'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            );
          },
        ),
        const Divider(), 
        ListTile(
          title: const Text('Enter Suggestions'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SuggestionsPage(),
              ),
            );
          },
        ),
        const Divider(), 
        ListTile(
          title: const Text('Helpline Contact'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HelplineContactPage(),
              ),
            );
          },
        ),
        const Divider(), 
        ListTile(
          title: const Text(
            'Logout',
            style: TextStyle(color: Colors.red),
          ),
          onTap: () async {
            try {
              UserPref.clearUser();
              Get.offAllNamed(RoutesName.login);
            } catch (e) {
              print('Error during logout: $e');
            }
          },
        ),
      ],
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(imageUrl: controller.userData!['profilePicture']!,
          placeholder: (context, url) {
             return CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Center(
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            );
          },
          imageBuilder: (context, imageProvider) {
            return CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
            );
          },

          ),

           Text(
           controller.userData!['userName']!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
