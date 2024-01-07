import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ViewCorruptionController extends GetxController{
  RxBool hasData=false.obs;

  int totalComplains=0;
  int corruptionComplain=0;
  int serviceComplain=0;


  ViewCorruptionController(){
    if(totalComplains==0){
      getData();
    }
  }

  getData() async {


    await FirebaseDatabase.instance.ref('Complains').child('corruption').once().then((corruption) {
      corruption.snapshot.children.forEach((element) async {
        String email=element.child('email').value.toString();
       await FirebaseDatabase.instance.ref('Complains').child('corruption').child(email.substring(0,email.indexOf('@'))).child('Complains').once().then((value) {
          corruptionComplain+=value.snapshot.children.length;
        });
      });
    });
    await FirebaseDatabase.instance.ref('Complains').child('service').once().then((service) {
      service.snapshot.children.forEach((element) async {
        String email=element.child('email').value.toString();
        await FirebaseDatabase.instance.ref('Complains').child('service').child(email.substring(0,email.indexOf('@'))).child('Complains').once().then((value) {
          serviceComplain+=value.snapshot.children.length;
        });
      });
    });









    Timer(Duration(seconds: 3), (){
      totalComplains=serviceComplain+corruptionComplain;

      if(totalComplains==0){
        hasData.value=false;

        getData();

      }else{
        hasData.value=true;
      }

      print(totalComplains);
    });



  }



}