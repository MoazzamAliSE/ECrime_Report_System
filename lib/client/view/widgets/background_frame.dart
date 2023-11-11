import 'package:ecrime/client/view/widgets/widgets_barrel.dart';

class BackgroundFrame extends StatelessWidget {
  BackgroundFrame({super.key, required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: foregrounBoxDecoration,
              child: child,
            ),
          )
        ],
      ),
    );
  }
}
