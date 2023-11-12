import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/admin/view/view_admin_barrel.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';
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
        child: FirebaseAnimatedList(query: FirebaseDatabase.instance.ref('Firs'), itemBuilder: (context, snapshot, animation, index) {
          return GestureDetector(
            onTap: () {
              Get.to(FIRDetailPage(snapshot: snapshot));
            },
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: 70,
              child: ListTile(
                leading: CachedNetworkImage(imageUrl: snapshot.child('profileImage').value.toString(),
                imageBuilder: (context, imageProvider) {
                 return CircleAvatar(
                    radius: 25,
                   backgroundImage: imageProvider,
                  );
                },
                  placeholder: (context, url) {
                    return Center(
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  },

                ),
                title: Text('FIR Number ${Random().nextInt(500)}',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                subtitle: Text('Submitted at ${snapshot.child('incidentDateTime').value.toString().substring(0,snapshot.child('incidentDateTime').value.toString().indexOf(' -'))}'),
              ),
            ),
          );
        },)
      ),
    );
  }
}

