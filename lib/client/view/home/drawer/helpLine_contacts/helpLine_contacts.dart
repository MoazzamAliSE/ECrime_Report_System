import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class HelplineContactPage extends StatelessWidget {
  const HelplineContactPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpline Contact'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeading('Police Helplines'),
              _buildHelplineItem('Punjab Police', '15'),
              _buildHelplineItem(
                  'IGP Complaint Helpline', '8787, 042-99212609'),
              _buildHelplineItem(
                  'Counter Terrorism Department (CTD)', '0800-111-11'),
              _buildHelplineItem(
                  'Lahore Police Complaint', '8300, UAN: 0304-1110911'),
              _buildSectionHeading('Inquiries'),
              _buildHelplineItem('Railway Enquiry', '117'),
              _buildHelplineItem('PIA Enquiry', '114'),
              _buildHelplineItem('Railway Police Helpline (City code)', '1333'),
              _buildSectionHeading('Emergencies'),
              _buildHelplineItem('Rescue Service', '1122'),
              _buildHelplineItem('Fire Brigade', '16'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        heading,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationStyle: TextDecorationStyle.double),
      ),
    );
  }

  Widget _buildHelplineItem(String title, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: number,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
