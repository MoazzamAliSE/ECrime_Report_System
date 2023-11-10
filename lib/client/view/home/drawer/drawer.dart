import 'package:ecrime/client/View/widgets/widgets_barrel.dart';

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
        const Divider(), // Divider after the first ListTile
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
        const Divider(), // Divider after the second ListTile
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
        const Divider(), // Divider after the third ListTile
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
            // backgroundImage: AssetImage('assets/profile_pic.jpg'),
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