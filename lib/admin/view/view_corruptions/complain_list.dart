import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';

import '../../../client/View/widgets/widgets_barrel.dart';
import '../view_fir/fir_detail_page/pdfViewer.dart';

class ComplainList extends StatefulWidget {
  const ComplainList({super.key, required this.type, required this.email});

  final String type;
  final String email;

  @override
  State<ComplainList> createState() => _ComplainListState();
}

class _ComplainListState extends State<ComplainList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Complain List'),
      ),
      body: BackgroundFrame(
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance
              .ref('Complains')
              .child(widget.type)
              .child(widget.email.substring(0, widget.email.indexOf('@')))
              .child('Complains'),
          itemBuilder: (context, snapshot, animation, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Submit at:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${snapshot.child('incidentDateTime').value.toString()}',
                        // style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Region:  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${snapshot.child('region').value.toString()}',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Institute: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '  ${snapshot.child('institute').value.toString()}',
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        'Description: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    snapshot.child('details').value.toString(),
                    style: const TextStyle(),
                  ),
                  const Text(
                    'Evidence:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  if (snapshot
                          .child('evidenceUrl')
                          .value
                          .toString()
                          .contains('png') ||
                      snapshot
                          .child('evidenceUrl')
                          .value
                          .toString()
                          .contains('jpg') ||
                      snapshot
                          .child('evidenceUrl')
                          .value
                          .toString()
                          .contains('jpeg'))
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl:
                            snapshot.child('evidenceUrl').value.toString(),
                        placeholder: (context, url) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (snapshot
                      .child('evidenceUrl')
                      .value
                      .toString()
                      .contains('pdf'))
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 250,
                        color: Colors.red,
                        width: MediaQuery.sizeOf(context).width,
                      ),
                    ),
                  if (snapshot
                      .child('evidenceUrl')
                      .value
                      .toString()
                      .contains('pdf'))
                    TextButton(
                        onPressed: () => Get.to(PDFViewerView(
                            url: snapshot
                                .child('evidenceUrl')
                                .value
                                .toString())),
                        child: const Text('Evidence is document. Tap for view'))
                ],
              ),
            );
          },
        ),
      ),
    ));
  }
}
