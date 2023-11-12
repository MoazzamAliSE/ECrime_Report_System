import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:intl/intl.dart';

class ViewFIRsPage extends StatefulWidget {
  const ViewFIRsPage({super.key});

  @override
  State<ViewFIRsPage> createState() => _ViewFIRsPageState();
}

class _ViewFIRsPageState extends State<ViewFIRsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View FIRs'),
      ),
      body: BackgroundFrame(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('firs').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<QueryDocumentSnapshot> firs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: firs.length,
              itemBuilder: (context, index) {
                return FIRListItem(firSnapshot: firs[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

//dummy data

void addDummyFIRs() async {
  CollectionReference firs = FirebaseFirestore.instance.collection('firs');

  QuerySnapshot querySnapshot =
      await firs.where('firNumber', isEqualTo: '456').get();

  if (querySnapshot.docs.isNotEmpty) {
    QueryDocumentSnapshot existingFIR = querySnapshot.docs.first;
    String formattedTimestamp =
        DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());

    await existingFIR.reference.update({
      'timestamp': formattedTimestamp,
    });

    print('Existing FIR updated');
  } else {
    Map<String, dynamic> firData2 = {
      'userImage':
          'https://firebasestorage.googleapis.com/v0/b/ecrime-16037.appspot.com/o/Firs%2Frh6768%2F423284122905777efb3a4618a2536a4855ecb5a.png?alt=media&token=8f9576f4-cfe0-4132-8c14-8608a75d1ee9',
      'firNumber': '456',
      'timestamp': DateTime.now(),
      'description': 'Another FIR description goes here.',
      'videoUrls': [
        'https://firebasestorage.googleapis.com/v0/b/ecrime-16037.appspot.com/o/Firs%2Fmoazzamali0304%2F%D9%86%D8%B5%DB%8C%D8%A8%2B%D9%88%D8%A7%D9%84%D9%88%DA%BA%2B%D9%85%DB%8C%DA%BA%2B%D9%85%DB%8C%D8%B1%D8%A7%2B%D9%86%D8%A7%D9%85%2B%DB%81%D9%88%2B%D8%AC%D8%A7%D8%A6%DB%92Viral%2BVideo%2B1%2Bmillion%2Bviews%2B%2B%2BSand%2BStars%2Bfour%2Bsupport%2Bus%2B-%E2%9D%A4%2B%2B%2B%EF%B8%8F%2B%2B%2B............%23DawateIslamYT%23reels%2BInstagram%2B%23reels2023%23reelsvideo%2B%23reelsviral%2B%23reelschallenge%2B%23islamicquotes%2B%23naat%23naa.mp4?alt=media&token=0315e387-eaf4-40aa-b3bc-aae0077880ba',
      ],
      'pictureUrls': [
        'https://firebasestorage.googleapis.com/v0/b/ecrime-16037.appspot.com/o/Firs%2Frh6768%2F423284122905777efb3a4618a2536a4855ecb5a.png?alt=media&token=8f9576f4-cfe0-4132-8c14-8608a75d1ee9',
      ],
      'pdfUrls': [
        'https://firebasestorage.googleapis.com/v0/b/ecrime-16037.appspot.com/o/Firs%2Fmoazzamali0304%2F1699742695827735%2F2387193Devotion%20Product%20Specification.pdf?alt=media&token=4a5e93c1-6dcb-47c7-a4b8-a3550b518519',
      ],
    };

    String formattedTimestamp =
        DateFormat('kk:mm dd/MM/yyyy').format(DateTime.now());

    await firs.add({
      ...firData2,
      'timestamp': formattedTimestamp,
    });
    print("data added");
  }
}
