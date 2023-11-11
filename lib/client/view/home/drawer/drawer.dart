import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/view/home/drawer/edit_profile/edit_profile.dart';
import 'package:ecrime/client/view/home/drawer/helpLine_contacts/helpLine_contacts.dart';
import 'package:ecrime/client/view/home/drawer/suggestion_page/suggestion_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

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
              await FirebaseAuth.instance.signOut();
              Navigator.pop(context);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPageClient()),
              );
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.red,
            
          ),
          SizedBox(height: 10),
          Text(
            'User Name',
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
