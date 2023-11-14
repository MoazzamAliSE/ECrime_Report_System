import 'dart:math';
import 'package:ecrime/admin/view%20model/controller/signIn_admin_controller.dart';
import 'package:ecrime/admin/view%20model/controller/signup_controller.dart';
import 'package:ecrime/admin/view/admin_home/admin_home.dart';
import 'package:ecrime/client/View/widgets/widgets_barrel.dart';
import 'package:ecrime/client/data/user%20pref/user_pref.dart';
import 'package:ecrime/client/res/routes/routes_name.dart';
import 'package:ecrime/client/utils/utils.dart';
import 'package:ecrime/client/view%20model/controller/authentication_controller/signUp_controller.dart';
import 'package:ecrime/client/view%20model/controller/complain_controller/complain_controller.dart';
import 'package:ecrime/client/view%20model/controller/editProfile_controller/editProfileController.dart';
import 'package:ecrime/client/view%20model/controller/register%20fir/register_fir_controller.dart';
import 'package:ecrime/client/view/investigation_update/investigation_update.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

import '../../view model/controller/authentication_controller/signIn_controller.dart';

class FirebaseServices {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  // Create New Account Store User Data locally and Live
  static Future<void> createAccount(String type) async {
    final signUpController = Get.put(SignUpController());
    signUpController.loading.value = true;
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
          final String email = signUpController.email.value.text.toString();
          FirebaseDatabase.instance
              .ref('Accounts')
              .child('ClientAccounts')
              .child(email.substring(0, email.indexOf('@')))
              .set({
            'email': email,
            'phoneNumber': signUpController.phoneNumber.value.text.toString(),
            'profilePicture': url,
            'userName': signUpController.userName.value.text.toString(),
            'fullName': signUpController.fullName.value.text.toString(),
            'token': value.user!.uid,
            'type' : type,
          }).then((v) {
            UserPref.saveUser({
              'email': email,
              'phoneNumber': signUpController.phoneNumber.value.text.toString(),
              'profilePicture': url,
              'userName': signUpController.userName.value.text.toString(),
              'fullName': signUpController.fullName.value.text.toString(),
              'token': value.user!.uid,
              'type': type
            });

            Get.offAllNamed(RoutesName.home);
            Utils.showSnackBar('Success', 'Account is successfully Created',
                const Icon(Icons.done_all));
            signUpController.loading.value = false;
          }).onError((error, stackTrace) {
            signUpController.loading.value = false;
            Utils.showSnackBar(
                'Error',
                Utils.extractFirebaseError(error.toString()),
                const Icon(Icons.warning_amber));
          });
        }).onError((error, stackTrace) {
          signUpController.loading.value = false;
          Utils.showSnackBar(
              'Error',
              Utils.extractFirebaseError(error.toString()),
              const Icon(Icons.warning_amber));
        });
      }).onError((error, stackTrace) {
        signUpController.loading.value = false;
        Utils.showSnackBar(
            'Error',
            Utils.extractFirebaseError(error.toString()),
            const Icon(Icons.warning_amber));
      });
    }).onError((error, stackTrace) {
      signUpController.loading.value = false;
      Utils.showSnackBar('Error', Utils.extractFirebaseError(error.toString()),
          const Icon(Icons.warning_amber));
    });
  }
  // Login Account and get data from live db and store it in shared pref
  static Future<void> signInAccount() async {
    final signInController = Get.put(SignInController());
    signInController.loading.value = true;

    String email = signInController.userEmail.value.text.toString();
    String password = signInController.userPassword.value.text.toString();

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      final String email = value.user!.email!;
      FirebaseDatabase.instance
          .ref('Accounts')
          .child('ClientAccounts')
          .child(email.substring(0, email.indexOf('@')))
          .once()
          .then((value) {

            if(value.snapshot.child('type').value.toString()=='client'){
              final userSnapshot = value.snapshot;
              UserPref.saveUser({
                'userName': userSnapshot.child('userName').value.toString(),
                'fullName': userSnapshot.child('fullName').value.toString(),
                'email': userSnapshot.child('email').value.toString(),
                'phoneNumber': userSnapshot.child('phoneNumber').value.toString(),
                'profilePicture':
                userSnapshot.child('profilePicture').value.toString(),
                'token': userSnapshot.child('token').value.toString(),
                'type': userSnapshot.child('type').value.toString(),
              });
              Get.offAllNamed(RoutesName.home);
              Utils.showSnackBar('Success', 'Successfully Login to your account',
                  const Icon(Icons.done_all));
              signInController.loading.value = false;
            }else{
              FirebaseAuth.instance.signOut();
              signInController.loading.value = false;
              Utils.showSnackBar('Error', 'Something went wrong try again',
                  const Icon(Icons.warning_amber));
            }


      }).onError((error, stackTrace) {
        signInController.loading.value = false;
        Utils.showSnackBar('Error', 'Something went wrong try again',
            const Icon(Icons.warning_amber));
      });
    }).onError((error, stackTrace) {
      signInController.loading.value = false;
      Utils.showSnackBar('Error', 'Invalid Email or Password',
          const Icon(Icons.warning_amber));
    });
  }
  // Create Fir in Db with both evidence or just data
  static Future<void> uploadFireData(String key, String evidenceUrl) async {
    final registerFirController = Get.put(RegisterFirController());
    registerFirController.loading.value = true;
    String email = (await UserPref.getUser())['email']!;

    // FirebaseDatabase.instance
    //     .ref('Firs')
    //     .child(email.substring(0, email.indexOf('@'))).set({
    //   'email' : email,
    //   'name' : (await UserPref.getUser())['userName'],
    //   'profilePicture' : (await UserPref.getUser())['profilePicture'],
    // });

    FirebaseDatabase.instance
        .ref('Firs')
        .child(key)
        .set({
      'key': key,
      'status' : 'Pending',
      'email' : email,
      'evidenceUrl': evidenceUrl,
      'profileImage' : (await UserPref.getUser())['profilePicture'],
      'victimType': registerFirController.fireType.value,
      'fireType': registerFirController.model.value.firType,
      'cinc': registerFirController.model.value.cnic,
      'name': registerFirController.model.value.name,
      'firNumber' : Random().nextInt(300).toString(),
      'assignTo' : 'No One',
      'progress' : 0.0,
      'phoneNumber': registerFirController.model.value.phoneNumber,
      'address': registerFirController.model.value.address,
      'fatherName': registerFirController.model.value.fathersName,
      'incidentAddress': registerFirController.model.value.incidentAddress,
      'incidentDateTime': DateFormat('MMMM d, y - hh:mm a')
          .format(registerFirController.model.value.incidentDateTime),
      'incidentDetails': registerFirController.model.value.incidentDetails,
      'incidentDistrict': registerFirController.model.value.incidentDistrict,
      'nearestPoliceStation':
          registerFirController.model.value.nearestPoliceStation,
    }).then((value) {
      Utils.showSnackBar(
          'Success', 'Your fir is registered', const Icon(Icons.done_all));
      registerFirController.loading.value = false;
      registerFirController.stepper.value=0;
      registerFirController.fileName.value='';
      registerFirController.evidenceType.value='';
      Get.offAllNamed(RoutesName.home);
    }).onError((error, stackTrace) {
      Utils.showSnackBar('Error', 'Something went wrong try again',
          const Icon(Icons.warning_amber));
      registerFirController.loading.value = false;
    });
  }


  static Future<void> registerFir() async {
    final registerFirController = Get.put(RegisterFirController());
    registerFirController.loading.value = true;
    FirebaseStorage storage = FirebaseStorage.instance;
    String email = (await UserPref.getUser())['email']!;
    String key = DateTime.now().microsecondsSinceEpoch.toString();
    if (registerFirController.evidenceType.isEmpty) {
      uploadFireData(key, '');
      return;
    }
    var sRef = storage.ref(
        'Firs/${email.substring(0, email.indexOf('@'))}/$key/${Random().nextInt(10000000).toString() + registerFirController.fileName.value}');
    var uploadTask = sRef.putFile(File(registerFirController.evidence.value));
    await Future.value(uploadTask)
        .then((v) async {
          sRef.getDownloadURL().then((url) {
            uploadFireData(key, url);
          });
        })
        .then((value) {})
        .onError((error, stackTrace) {
          Utils.showSnackBar('Error', 'Something went wrong try again',
              const Icon(Icons.warning_amber));
          registerFirController.loading.value = false;
        });
  }

  static Future<void> registerComplain(String type)async {
    final controlller=Get.put(ComplainController());
    controlller.loading.value=true;
    FirebaseStorage storage = FirebaseStorage.instance;
    String email = (await UserPref.getUser())['email']!;
    String key = DateTime.now().microsecondsSinceEpoch.toString();
    var sRef = storage.ref(
        'Complains/${email.substring(0, email.indexOf('@'))}/$type/$key/${Random().nextInt(10000000).toString() + controlller.evidenceName.value}');
    var uploadTask = sRef.putFile(File(controlller.evidence.value));
    await Future.value(uploadTask)
        .then((v) async {
      sRef.getDownloadURL().then((url) async {
        String email = (await UserPref.getUser())['email']!;

        FirebaseDatabase.instance
            .ref('Complains').child(type)
            .child(email.substring(0, email.indexOf('@'))).set({
          'email' : email,
          'name' : (await UserPref.getUser())['userName'],
          'profilePicture' : (await UserPref.getUser())['profilePicture'],
        });




        FirebaseDatabase.instance
            .ref('Complains').child(type)
            .child(email.substring(0, email.indexOf('@'))).child('Complains')
            .child(key)
            .set({
        'key': key,
          'complainerEmail' : email,
          'complainerName':  (await UserPref.getUser())['userName'],
        'evidenceUrl': url,
          'status' : 'Pending',
          'institute':controlller.institute.value,
          'region' : controlller.region.value,
          'details' : controlller.detail.value.text.toString(),
        'incidentDateTime': DateFormat('MMMM d, y - hh:mm a')
            .format(DateTime.now()),
        }).then((value) {
        Utils.showSnackBar(
        'Success', 'Your complain is registered', const Icon(Icons.done_all));
        controlller.loading.value = false;
        controlller.detail.clear();
        controlller.evidenceName.value='';
        controlller.evidence.value='';
        }).onError((error, stackTrace) {
        Utils.showSnackBar('Error', 'Something went wrong try again',
        const Icon(Icons.warning_amber));
        controlller.loading.value = false;
        });
      });
    })
        .then((value) {})
        .onError((error, stackTrace) {
      Utils.showSnackBar('Error', 'Something went wrong try again',
          const Icon(Icons.warning_amber));
      controlller.loading.value = false;
    });
  }


  static Future<void> updateProfile(String node,String url)async{
    final controller=Get.put(EditProfileController());
    FirebaseDatabase.instance.ref('Accounts').child('ClientAccounts').child(node).set({
      'email': controller.emailController.value.value.text.toString(),
      'phoneNumber': controller.phoneNoController.value.value.text.toString(),
      'profilePicture': url,
      'userName': controller.usernameController.value.value.text.toString(),
      'fullName': controller.fullNameController.value.value.text.toString(),
      'token': controller.userDate['token'],
    }).then((value) {

      UserPref.saveUser({
        'email': controller.emailController.value.value.text.toString(),
        'phoneNumber': controller.phoneNoController.value.value.text.toString(),
        'profilePicture': url,
        'userName': controller.usernameController.value.value.text.toString(),
        'fullName': controller.fullNameController.value.value.text.toString(),
        'token': controller.userDate['token']!,
        'type': 'client'
      });



      controller.loading.value=false;
      Get.toNamed(RoutesName.home);
      Utils.showSnackBar('Success', 'Successfully Updates', Icon(Icons.done_all));
    }).onError((error, stackTrace){
      Utils.showSnackBar('Warning', 'Something went wrong try again', Icon(Icons.warning_amber));
      controller.loading.value=false;
    });

  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // admin account 
  static Future<void> signInAdminAccount() async {
    final signInController = Get.put(SigninAdminController());
    signInController.loading.value = true;
    String email = signInController.userEmail.value.text.toString();
    String password = signInController.userPassword.value.text.toString();

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      final String email = value.user!.email!;
      FirebaseDatabase.instance
          .ref('Accounts')
          .child('AdminAccounts')
          .child(email.substring(0, email.indexOf('@')))
          .once()
          .then((value) {


            if(value.snapshot.child('type').value.toString() == 'admin'){
              final userSnapshot = value.snapshot;
              UserPref.saveUser({


                'phoneNumber': '_',
                'profilePicture': '_',
                'fullName': '_',


                'userName': userSnapshot.child('userName').value.toString(),
                'email': userSnapshot.child('email').value.toString(),
                'token': userSnapshot.child('token').value.toString(),
                'type': userSnapshot.child('type').value.toString(),
              });
              Get.offAll(AdminHomePage());
              Utils.showSnackBar('Success', 'Successfully Login to your account',
                  const Icon(Icons.done_all));
              signInController.loading.value = false;
            }else{
              FirebaseAuth.instance.signOut();
              signInController.loading.value = false;
              Utils.showSnackBar('Error', 'Something went wrong try again',
                  const Icon(Icons.warning_amber));
            }



      }).onError((error, stackTrace) {
        signInController.loading.value = false;
        Utils.showSnackBar('Error', 'Something went wrong try again',
            const Icon(Icons.warning_amber));
      });
    }).onError((error, stackTrace) {
      signInController.loading.value = false;
      Utils.showSnackBar('Error', 'Invalid Email or Password',
          const Icon(Icons.warning_amber));
    });
  }

  static Future<void> createAdminAccount(String type) async {
    final signUpAdminController =Get.put(SignUpAdminController());
    signUpAdminController.loading.value=true;
    auth
        .createUserWithEmailAndPassword(
        email: signUpAdminController.email.value.text.toString(),
        password: signUpAdminController.password.value.text.toString())
        .then((value) {
      final String email = signUpAdminController.email.value.text.toString();
      FirebaseDatabase.instance
          .ref('Accounts')
          .child('AdminAccounts')
          .child(email.substring(0, email.indexOf('@')))
          .set({
        'email': email,
        'userName': signUpAdminController.userName.value.text.toString(),
        'token': value.user!.uid,
        'type': type,
      }).then((v) {
        UserPref.saveUser({
          'phoneNumber': '_',
          'profilePicture': '_',
          'fullName': '_',
          'email': email,
          'userName': signUpAdminController.userName.value.text.toString(),
          'token': value.user!.uid,
          'type': type
        });

        Get.offAll(const AdminHomePage());
        Utils.showSnackBar('Success', 'Account is successfully Created',
            const Icon(Icons.done_all));
        signUpAdminController.loading.value = false;
      }).onError((error, stackTrace) {
        signUpAdminController.loading.value = false;
        Utils.showSnackBar(
            'Error',
            Utils.extractFirebaseError(error.toString()),
            const Icon(Icons.warning_amber));
      });
    }).onError((error, stackTrace){
      signUpAdminController.loading.value = false;
      Utils.showSnackBar(
          'Error',
          Utils.extractFirebaseError(error.toString()),
          const Icon(Icons.warning_amber));
    });
    
    
  }
  
  
  
  
  
  
  
  


}
