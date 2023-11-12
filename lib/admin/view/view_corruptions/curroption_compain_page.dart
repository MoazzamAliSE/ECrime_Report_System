import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecrime/admin/view/view_corruptions/view_corruptions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:get/get.dart';

import '../../../client/View/widgets/widgets_barrel.dart';
import 'complain_list.dart';

class CorruptionComplainPage extends StatelessWidget {
  final String type;

  const CorruptionComplainPage({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Corruption Complaints'),
          ),
          body: FirebaseAnimatedList(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            query: FirebaseDatabase.instance.ref('Complains').child(type),
            itemBuilder: (context, snapshot, animation, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () => Get.to(ComplainList(
                      type: type, email: snapshot.child('email').value.toString())),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                          snapshot.child('profilePicture').value.toString(),
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
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${snapshot.child('email').value.toString()}',
                              style:
                              TextStyle(fontWeight: FontWeight.bold, height: 0),
                            ),
                            Text(
                              '${snapshot.child('name').value.toString()}',
                              style: TextStyle(height: 0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}