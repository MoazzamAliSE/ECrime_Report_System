


import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class CardButtonReport extends StatelessWidget {
  const CardButtonReport({
    Key? key,
    required this.svgIcon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final String svgIcon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: const Color(0xFF3E4F89),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Center(
                    child: SvgPicture.asset(
                      svgIcon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}