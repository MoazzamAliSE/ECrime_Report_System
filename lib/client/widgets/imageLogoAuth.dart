import 'package:ecrime/client/res/images.dart';
import 'package:flutter/material.dart';

class ImageLogoAuth extends StatelessWidget {
  const ImageLogoAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ClipOval(
      child: Image(
        image: AssetImage(
          AppImages.logo,
        ),
        height: 200,
        width: 200,
        fit: BoxFit.fitWidth, // Adjust the fit as needed
      ),
    );
  }
}
