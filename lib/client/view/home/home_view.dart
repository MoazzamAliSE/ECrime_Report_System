import 'package:ecrime/client/utils/utils.dart';
import 'package:ecrime/client/view/complain_corruption/complain_corruption.dart';
import 'package:ecrime/client/view/status/status_view.dart';
import 'package:ecrime/client/view/widgets/background_frame.dart';
import 'package:ecrime/client/view/widgets/widgets_barrel.dart';
import 'package:get/get.dart';

import '../../view model/controller/home controller/home_controller.dart';

//to use globally
var complainCorruption = 'corruption';
var complainService = 'service';

class HomeScreenClient extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeScreenClient({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Scaffold(
          drawer: MyDrawer(),
          appBar: _buildAppBar(),
          body: BackgroundFrame(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 36.0, left: 10, right: 10),
                child: Column(
                  children: [
                    _buildHeadingText(),
                    const SizedBox(
                      height: 66,
                    ),
                    _buildUpperButtons(context),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildSubHeadingText(),
                    Divider(
                      thickness: 2,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      height: 150,
                      child: ImageCarouselSlider(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Divider(
                      thickness: 2,
                      color: AppColor.primaryColor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildLowerButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void firUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.all(6),
            width: double.infinity,
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CardButtonReport(
                    svgIcon: regFir,
                    text: 'Investigation Update',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Expanded(
                  child: CardButtonReport(
                    svgIcon: regFir,
                    text: 'Status of FIR',
                    onTap: () {
                      Get.off(const StatusPage()); //test
                    },
                  ),
                ),
                Expanded(
                  child: CardButtonReport(
                    svgIcon: regFir,
                    text: 'Investigator',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void regComplainDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.all(6),
            width: double.infinity,
            height: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardButtonReport(
                  svgIcon: regFir,
                  text: 'Complain for Curruption',
                  onTap: () {
                    Get.off(ComplainPage(complainType: complainCorruption));

                    // Navigator.pop(context);
                  },
                ),
                CardButtonReport(
                  svgIcon: regFir,
                  text: 'Complain for Services',
                  onTap: () {
                    Get.off(ComplainPage(complainType: complainService));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _buildLowerButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CardButtonReportWhite(
          svgIcon: policeStation,
          text: "Find Police Station",
          onTap: () {
            Utils.showSnackBar('Warnind', 'Not Implement yet',
                const Icon((Icons.warning_amber)));
          },
        ),
        CardButtonReportWhite(
          svgIcon: generatePdf,
          text: "Generate Report",
          onTap: () {
            Utils.showSnackBar('Warnind', 'Not Implement yet',
                const Icon((Icons.warning_amber)));
          },
        ),
        CardButtonReportWhite(
          svgIcon: progress,
          text: "Progress",
          onTap: () {
            Utils.showSnackBar('Warnind', 'Not Implement yet',
                const Icon((Icons.warning_amber)));
          },
        ),
      ],
    );
  }

  Align _buildSubHeadingText() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'News & Updates',
        style: TextStyle(
          color: Color(0xFF3E4F89),
          fontSize: 18,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w800,
          height: 0,
        ),
      ),
    );
  }

  Row _buildUpperButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CardButtonReport(
          svgIcon: regFir,
          text: "Reg. FIR",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterFIR(),
                ));
            print("abc");
          },
        ),
        CardButtonReport(
          svgIcon: regFir,
          text: "FIR Updates",
          onTap: () {
            firUpdateDialog(context);
          },
        ),
        CardButtonReport(
          svgIcon: regFir,
          text: "Reg. Complain",
          onTap: () {
            regComplainDialog(context);
          },
        ),
      ],
    );
  }

  Text _buildHeadingText() {
    return Text(
      'How Can We help you',
      style: TextStyle(
        color: AppColor.primaryColor,
        fontSize: 20,
        fontFamily: interExtraBold,
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Home Screen",
        style: TextStyle(
          color: AppColor.whiteColor,
          fontFamily: interExtraBold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
    );
  }
}
