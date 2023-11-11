import 'dart:math';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:ecrime/client/view%20model/controller/authentication_controller/signUp_controller.dart';
import 'package:ecrime/client/view%20model/controller/register%20fir/register_fir_controller.dart';
import 'package:ecrime/client/view/investigation_update/investigation_update.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../view model/controller/authentication_controller/signIn_controller.dart';

class FirebaseServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  // Create New Account Store User Data locally and Live
  static Future<void> createAccount() async {
     final signUpController = Get.put(SignUpController());
    signUpController.loading.value=true;
    FirebaseStorage storage = FirebaseStorage.instance;
    var sRef = storage
        .ref('profile_picture/${DateTime.now().microsecondsSinceEpoch}.jpeg');
    var uploadTask = sRef.putFile(File(signUpController.profilePicture.value));
    await Future.value(uploadTask).then((v) async {
      sRef.getDownloadURL().then((url) {
        auth
            .createUserWithEmailAndPassword(
                email: signUpController.email.value.text.toString(),
                password: signUpController.password.value.text.toString())
            .then((value) {
              final String email=signUpController.email.value.text.toString();
              FirebaseDatabase.instance.ref('Accounts').child('ClientAccounts').child(email.substring(0,email.indexOf('@'))).set({
                'email': email,
                'phoneNumber' : signUpController.phoneNumber.value.text.toString(),
                'profilePicture' : url,
                'userName'  : signUpController.userName.value.text.toString(),
                'fullName'  : signUpController.fullName.value.text.toString(),
                'token': value.user!.uid,
              }).then((v) {

                UserPref.saveUser({
                  'email': email,
                  'phoneNumber' : signUpController.phoneNumber.value.text.toString(),
                  'profilePicture' : url,
                  'userName'  : signUpController.userName.value.text.toString(),
                  'fullName'  : signUpController.fullName.value.text.toString(),
                  'token': value.user!.uid,
                  'type' : 'client'
                });

                Get.offAllNamed(RoutesName.home);
                Utils.showSnackBar('Success', 'Account is successfully Created', Icon(Icons.done_all));
                signUpController.loading.value=false;
              }).onError((error, stackTrace) {
                signUpController.loading.value=false;
                Utils.showSnackBar('Error', Utils.extractFirebaseError(error.toString()), Icon(Icons.warning_amber));
              });

        }).onError((error, stackTrace) {
          signUpController.loading.value=false;
          Utils.showSnackBar('Error', Utils.extractFirebaseError(error.toString()), Icon(Icons.warning_amber));
        });
      }).onError((error, stackTrace) {
        signUpController.loading.value=false;
        Utils.showSnackBar('Error', Utils.extractFirebaseError(error.toString()), Icon(Icons.warning_amber));
      });
    }).onError((error, stackTrace) {
      signUpController.loading.value=false;
      Utils.showSnackBar('Error', Utils.extractFirebaseError(error.toString()), Icon(Icons.warning_amber));
    });
  }


  // Login Account and get data from live db and store it in shared pref
  static Future<void> signInAccount()async {
     final signInController = Get.put(SignInController());
    signInController.loading.value=true;

    String email=signInController.userEmail.value.text.toString();
    String password=signInController.userPassword.value.text.toString();




    FirebaseAuth.instance.signInWithEmailAndPassword(email: email,
        password: password).then((value)
    {
      final String email=value.user!.email!;
      FirebaseDatabase.instance.ref('Accounts').child('ClientAccounts').child(email.substring(0,email.indexOf('@'))).once().then((value){
        final userSnapshot=value.snapshot;
        UserPref.saveUser({
          'userName' : userSnapshot.child('userName').value.toString(),
          'fullName' : userSnapshot.child('fullName').value.toString(),
          'email' : userSnapshot.child('email').value.toString(),
          'phoneNumber' : userSnapshot.child('phoneNumber').value.toString(),
          'profilePicture' : userSnapshot.child('profilePicture').value.toString(),
          'token' : userSnapshot.child('token').value.toString(),
          'type' : 'client',
        });
        Get.offAllNamed(RoutesName.home);
        Utils.showSnackBar('Success', 'Successfully Login to your account', Icon(Icons.done_all));
        signInController.loading.value=false;

      }).onError((error, stackTrace) {
        signInController.loading.value=false;
        Utils.showSnackBar('Error', 'Something went wrong try again', Icon(Icons.warning_amber));
      });

    }).onError((error, stackTrace) {
      signInController.loading.value=false;
      Utils.showSnackBar('Error', 'Invalid Email or Password', Icon(Icons.warning_amber));
    });
  }


  // Create Fir in Db with both evidence or just data
  static Future<void> uploadFireData(String key,String evidenceUrl) async {
     final registerFirController=Get.put(RegisterFirController());
    registerFirController.loading.value=true;
    String email=(await UserPref.getUser())['email']!;
    FirebaseDatabase.instance.ref('Firs').child(email.substring(0,email.indexOf('@'))).child(key).set({
      'key': key,
      'evidenceUrl' : evidenceUrl,
      'victimType' : registerFirController.fireType.value,
      'fireType' : registerFirController.model.value.firType,
      'cinc' : registerFirController.model.value.cnic,
      'name' : registerFirController.model.value.name,
      'phoneNumber' : registerFirController.model.value.phoneNumber,
      'address' : registerFirController.model.value.address,
      'fatherName' : registerFirController.model.value.fathersName,
      'incidentAddress' : registerFirController.model.value.incidentAddress,
      'incidentDateTime' : DateFormat('MMMM d, y - hh:mm a').format(registerFirController.model.value.incidentDateTime),
      'incidentDetails' : registerFirController.model.value.incidentDetails,
      'incidentDistrict' : registerFirController.model.value.incidentDistrict,
      'nearestPoliceStation' : registerFirController.model.value.nearestPoliceStation,
    }).then((value){
      Utils.showSnackBar('Success', 'Your fir is registered', Icon(Icons.done_all));
      registerFirController.loading.value=false;
      Get.offAllNamed(RoutesName.home);
    }).onError((error, stackTrace){
      Utils.showSnackBar('Error', 'Something went wrong try again', Icon(Icons.warning_amber));
      registerFirController.loading.value=false;
    });
  }
  static Future<void> registerFir()async{
     final registerFirController=Get.put(RegisterFirController());
    registerFirController.loading.value=true;
    FirebaseStorage storage = FirebaseStorage.instance;
    String email=(await UserPref.getUser())['email']!;
    String key=DateTime.now().microsecondsSinceEpoch.toString();
    if(registerFirController.evidenceType.isEmpty){
      uploadFireData(key,'');
      return;
    }
    var sRef = storage
        .ref('Firs/${email.substring(0,email.indexOf('@'))}/$key/${Random().nextInt(10000000).toString()+registerFirController.fileName.value}');
    var uploadTask = sRef.putFile(File(registerFirController.evidence.value));
    await Future.value(uploadTask).then((v) async {
      sRef.getDownloadURL().then((url) {
        uploadFireData(key,url);
      });}).then((value){

    }).onError((error, stackTrace) {
      Utils.showSnackBar('Error', 'Something went wrong try again', Icon(Icons.warning_amber));
      registerFirController.loading.value=false;
    });



  }





}



