import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color(0xff3E4F89);
  static Color backgroundColor = const Color(0xffF5F5F5);
  static Color whiteColor = Colors.white;
}

BoxDecoration foregrounBoxDecoration = BoxDecoration(
  color: AppColor.backgroundColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(backgroundRadius),
    topRight: Radius.circular(backgroundRadius),
  ),
);
TextStyle appBarTextStyle = TextStyle(
    fontFamily: interExtraBold,
    color: AppColor.backgroundColor,
    letterSpacing: 1,
    fontSize: 22,
    wordSpacing: 10);

TextStyle smallHeadingTextStyle =
    TextStyle(fontSize: 14, fontFamily: interBold);
//fontFamily
String interBold = "InterB";
String interRegular = "InterR";
String interExtraBold = "InterEB";
String interSemiBold = "InterSB";
String interMedium = "InterM";

//icons
String firUpdate = "assets/icons/fir_updates.svg";
String generatePdf = "assets/icons/generate_pdf.svg";
String policeStation = "assets/icons/police_station.svg";
String progress = "assets/icons/progress.svg";
String regComplain = "assets/icons/reg_complain.svg";
String regFir = "assets/icons/reg_fir.svg";

//radius
double backgroundRadius = 40;

// void showNoImplementationDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('No Implementation'),
//         content: const Text('This feature is not yet implemented.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       );
//     },
//   );
// }
