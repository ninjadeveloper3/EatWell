import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Calories_Calculator/caloriesCalculatorController.dart';
import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory.dart';
import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory_controller.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:easy_localization/easy_localization.dart';

class CalloriesResultPage extends StatefulWidget {
  const CalloriesResultPage({Key? key}) : super(key: key);

  @override
  State<CalloriesResultPage> createState() => _CalloriesResultPageState();
}

class _CalloriesResultPageState extends State<CalloriesResultPage> {
  InitialStatusController initalcon = Get.find<InitialStatusController>();
  late String totalcallories;
  CaloriesCalculatorController controller =
      Get.find<CaloriesCalculatorController>();

  @override
  void initState() {
    totalcallories =
        double.parse(controller.usercalories.value).toStringAsFixed(2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.Calloriesbackground,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .10),
            child: Padding(
              padding: EdgeInsets.only(
                  top: initalcon.userExsists.value == 'Yes'
                      ? MediaQuery.of(context).size.height * .77
                      : MediaQuery.of(context).size.height * .88),
              child: submitButton(
                  col: Col.WHITE,
                  textcol: Col.blue,
                  onPress: () {
                    if (initalcon.userExsists.value == 'Yes') {
                      Get.put(DietCategoryController(Get.find()));
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const DietCategory(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    } else {
                      Get.back();
                      Get.offNamed('/GuestDashboard');
                    }
                  },
                  title: 'CONTINUE'.tr(),
                  height: MediaQuery.of(context).size.height * 0.060,
                  width: double.infinity),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Hi,'.tr(),
                  style: TextStyle(
                    fontFamily: Get.locale.toString() == 'en'
                        ? Assets.Product_Sans_Bold
                        : Assets.TheSans_Bold,
                    color: Col.WHITE,
                    fontSize: 25,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Wrap(
                children: [
                  Text(
                    Get.locale.toString() == 'ar'
                        ? 'استهلاكك اليومي السعرات الحرارية'
                        : 'Your daily consumed calories are',
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Regular
                          : Assets.TheSans_plain,
                      color: Col.WHITE,
                      fontSize: 15,
                    ),
                  ),
                  // Text('Your daily consumed $totalcallories calories',
                  //     style: const TextStyle(
                  //       fontFamily: Assets.Product_Sans_Regular,
                  //       color: Col.WHITE,
                  //       fontSize: 15,
                  //     )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Text('$totalcallories Cal',
                  style: TextStyle(
                    fontFamily: Get.locale.toString() == 'en'
                        ? Assets.Product_Sans_Bold
                        : Assets.TheSans_Bold,
                    color: Col.WHITE,
                    fontSize: 45,
                  )),
            ],
          )),
        ],
      ),
    ));
  }
}
