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
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('Firs'),
          defaultChild: Center(
            child: SizedBox(height: 15,width: 15,child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),),
          ),
          itemBuilder: (context, snapshot, animation, index) {
           if(snapshot.children.isNotEmpty){
             return SizedBox(
               width: MediaQuery.sizeOf(context).width,
               // width: 300,
               // height: 70,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Card(
                   child: ListTile(
                     onTap: () {
                       Get.to(FIRDetailPage(snapshot: snapshot));
                     },
                     leading: SizedBox(
                       width: 56,
                       child: CachedNetworkImage(
                         imageUrl:
                         snapshot.child('profileImage').value.toString(),
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
                               child: Center(
                                 child: CircularProgressIndicator(
                                   color: AppColor.primaryColor,
                                 ),
                               ),
                             ),
                           );
                         },
                       ),
                     ),
                     title: Text(
                       'FIR Number ${snapshot.child('firNumber').value.toString()}',
                       style: const TextStyle(fontWeight: FontWeight.bold),
                     ),
                     subtitle: Text(
                         'Submitted at ${snapshot.child('incidentDateTime').value.toString().substring(0, snapshot.child('incidentDateTime').value.toString().indexOf(' -'))}'),
                   ),
                 ),
               ),
             );
           }else{
             return SizedBox(height: 15,width: 15,child: CircularProgressIndicator(
               color: AppColor.primaryColor,
             ),);
           }
          },
        ),
      )),
    );
  }
}
