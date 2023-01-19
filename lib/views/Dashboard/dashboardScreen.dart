import 'dart:io';
import 'dart:ui';

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/goalSelection.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/infoDailog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  InitialStatusController initialcon = Get.find<InitialStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Appbar(
              context: context,
              title: 'DASHBOARD',
            )),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            // height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Assets.BgDashBoard_Image,
                  ),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FadeInLeft(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // const Appbar(),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Col.ksidePadding,
                        right: Col.ksidePadding,
                      ),
                      child: InkWell(
                        onTap: () {
                          // Navigator.pushNamed(context, "DeliveryDetails");
                        },
                        child: Text('Healthy Diet Plans for You!'.tr(),
                            style: TextStyle(
                              fontSize: 30,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Bold
                                  : Assets.TheSans_Bold,
                              color: Col.blue,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Col.ksidePadding,
                        right: Col.ksidePadding,
                      ),
                      child: Text('Select your Personalized Plan'.tr(),
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                            color: Col.black,
                          )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: Col.ksidePadding,
                          right: Col.ksidePadding,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                                onTap: () {}, child: PlansCard1());
                          }),
                          itemCount: 1,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: Col.ksidePadding,
                          right: Col.ksidePadding,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                                onTap: () {
                                  if (initialcon.userExsists.value.toString() ==
                                      'Yes') {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: const GoalSelectionScreen(),
                                      withNavBar:
                                          true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  } else {
                                    Get.toNamed('/DietCategory');
                                  }

                                  // Get.toNamed('/goalSelectionPAge');
                                },
                                child: PlansCard2());
                          }),
                          itemCount: 1,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        InfoDailogofContactSupport(
                          context,
                          'Call Us on : ${initialcon.supportCAllphone.value} to contact our support team',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: Col.ksidePadding,
                          right: Col.ksidePadding,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.NeedSupport_image,
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Need Support?".tr(),
                              style: TextStyle(
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold,
                                fontSize: 15.7,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> onWillPop(context) async {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Col.green,
        width: 2,
      ),
      width: 400.w,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Exit',
      desc: 'Are you Sure you want to Quit Application',
      showCloseIcon: true,
      // btnCancelText: 'CANCEL'.tr(),
      btnOkText: 'Ok',
      btnCancelText: 'CANCEL',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        SystemNavigator.pop();

        // Get.back();
        // Get.back();
      },
    ).show();

    return false;
  }
}

Future<void> _makePhoneCall(String url) async {
  url = "tel:$url";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// landscpce
class PlansCard3 extends StatefulWidget {
  @override
  _PlansCard3State createState() => _PlansCard3State();
}

class _PlansCard3State extends State<PlansCard3> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      Container(
        height: 315,
        // width: 220, //MediaQuery.of(context).size.width * 0.56,
        decoration: const BoxDecoration(
          color: Col.lightgreylite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en'
                      ? MediaQuery.of(context).size.width * 0.07
                      : 0,
                  right: Get.locale.toString() == 'ar'
                      ? MediaQuery.of(context).size.width * 0.07
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Dietician Assessment".tr(),
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Bold
                          : Assets.TheSans_Bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "You can select your meal as per nutritionist recommendations"
                        .tr(),
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Regular
                          : Assets.TheSans_plain,
                      fontSize: 12,
                      color: Col.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: 52,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Col.darkgreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    titlePadding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    //this right here
                                    title: SizedBox(
                                      height: 280.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 25,
                                                    color: Col.darkgreen,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "How would you like to Proceed?"
                                                .tr(),
                                            style: TextStyle(
                                              fontFamily:
                                                  Get.locale.toString() == 'en'
                                                      ? Assets.Product_Sans_Bold
                                                      : Assets.TheSans_Bold,
                                              fontSize: 25,
                                              color: Col.blue,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Col.darkgreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Book Through Call Center"
                                                          .tr(),
                                                      style: TextStyle(
                                                        color: Col.WHITE,
                                                        fontFamily: Get.locale
                                                                    .toString() ==
                                                                'en'
                                                            ? Assets
                                                                .Product_Sans_Regular
                                                            : Assets
                                                                .TheSans_plain,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Col.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      _launchDeveloperPage();
                                                    },
                                                    child: Text(
                                                      "Book Through IMC App"
                                                          .tr(),
                                                      style: TextStyle(
                                                        color: Col.WHITE,
                                                        fontFamily: Get.locale
                                                                    .toString() ==
                                                                'en'
                                                            ? Assets
                                                                .Product_Sans_Regular
                                                            : Assets
                                                                .TheSans_plain,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Col.WHITE,
                        size: 20,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: Get.locale.toString() == 'en'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        right: Get.locale.toString() == 'ar'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        top: -15,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              bottomLeft: Get.locale.toString() == 'en'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: Get.locale.toString() == 'ar'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              topRight: const Radius.circular(20),
            ),
            image: const DecorationImage(
              image: AssetImage(
                Assets.DieticianAssessment_image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 220,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "Dietician Assessment",
      //     style: TextStyle(
      //       fontFamily: Assets.Product_Sans_Bold,
      //       fontSize: 23,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   top: 250,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   right:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "You can select your meal as per nutritionist recommendations",
      //     style: TextStyle(
      //       fontFamily: Assets.Poppins_Medium,
      //       fontSize: 11,
      //       color: Col.black,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   left:MediaQuery.of(context).size.width * 0.7,
      //   top: 264,
      //   child: Container(
      //       height: 52,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         color: Col.darkgreen,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20),
      //         ),
      //       ),
      //       child: InkWell(
      //         onTap: () {},
      //         child: Icon(
      //           Icons.arrow_forward_ios_outlined,
      //           color: Col.WHITE,
      //           size: 20,
      //         ),
      //       )),
      // ),
    ]);
  }
}

Future openBrowserUrl({
  required String url,
  bool inApp = false,
}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: inApp,
      forceWebView: inApp,
      enableJavaScript: true,
    );
  }
}

_launchDeveloperPage() async {
  if (Platform.isAndroid) {
    try {
      ///checks if the app is installed on your mobile device
      bool isInstalled = await DeviceApps.isAppInstalled('sa.med.imc.myimc');
      if (isInstalled) {
        await DeviceApps.openApp("sa.med.imc.myimc");
      } else {
        // if the app is not installed it lunches google play store so you can install it from there
        launch(
            "https://play.google.com/store/apps/details?id=sa.med.imc.myimc&hl=en&gl=US");
      }
    } catch (e) {
      print(e);
    }
  } else {
    var url = 'https://apps.apple.com/pk/app/my-imc/id1491751418';
    openBrowserUrl(url: url, inApp: false);
  }
}

class PlansCard4 extends StatefulWidget {
  @override
  _PlansCard4State createState() => _PlansCard4State();
}

class _PlansCard4State extends State<PlansCard4> {
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      Container(
        height: 300,
        // width: 220, //MediaQuery.of(context).size.width * 0.56,
        decoration: const BoxDecoration(
          color: Col.lightgreylite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en'
                      ? MediaQuery.of(context).size.width * 0.07
                      : 0,
                  right: Get.locale.toString() == 'ar'
                      ? MediaQuery.of(context).size.width * 0.07
                      : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Meal Plans".tr(),
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Bold
                          : Assets.TheSans_Bold,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    "You can select your meal as per nutritionist recommendations"
                        .tr(),
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Regular
                          : Assets.TheSans_plain,
                      fontSize: 12,
                      color: Col.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    height: 52,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Col.darkgreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    titlePadding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    //this right here
                                    title: SizedBox(
                                      height: 280.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 25,
                                                    color: Col.darkgreen,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "How would you like to Proceed?"
                                                .tr(),
                                            style: TextStyle(
                                              fontFamily:
                                                  Get.locale.toString() == 'en'
                                                      ? Assets.Product_Sans_Bold
                                                      : Assets.TheSans_Bold,
                                              fontSize: 25,
                                              color: Col.blue,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Col.darkgreen,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      "Book Through Call Center"
                                                          .tr(),
                                                      style: TextStyle(
                                                        color: Col.WHITE,
                                                        fontFamily: Get.locale
                                                                    .toString() ==
                                                                'en'
                                                            ? Assets
                                                                .Product_Sans_Regular
                                                            : Assets
                                                                .TheSans_plain,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  height: 50,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Col.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      _launchDeveloperPage();
                                                    },
                                                    child: Text(
                                                      "Book Through IMC App"
                                                          .tr(),
                                                      style: TextStyle(
                                                        color: Col.WHITE,
                                                        fontFamily: Get.locale
                                                                    .toString() ==
                                                                'en'
                                                            ? Assets
                                                                .Product_Sans_Regular
                                                            : Assets
                                                                .TheSans_plain,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Col.WHITE,
                        size: 20,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        left: Get.locale.toString() == 'en'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        right: Get.locale.toString() == 'ar'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        top: -15,
        child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              bottomLeft: Get.locale.toString() == 'en'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: Get.locale.toString() == 'ar'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              topRight: const Radius.circular(20),
            ),
            image: const DecorationImage(
              image: AssetImage(
                Assets.MealPlans_image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 220,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "Dietician Assessment",
      //     style: TextStyle(
      //       fontFamily: Assets.Product_Sans_Bold,
      //       fontSize: 23,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   top: 250,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   right:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "You can select your meal as per nutritionist recommendations",
      //     style: TextStyle(
      //       fontFamily: Assets.Poppins_Medium,
      //       fontSize: 11,
      //       color: Col.black,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   left:MediaQuery.of(context).size.width * 0.7,
      //   top: 264,
      //   child: Container(
      //       height: 52,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         color: Col.darkgreen,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20),
      //         ),
      //       ),
      //       child: InkWell(
      //         onTap: () {},
      //         child: Icon(
      //           Icons.arrow_forward_ios_outlined,
      //           color: Col.WHITE,
      //           size: 20,
      //         ),
      //       )),
      // ),
    ]);
  }
}

// potrait
class PlansCard1 extends StatefulWidget {
  @override
  _PlansCard1State createState() => _PlansCard1State();
}

class _PlansCard1State extends State<PlansCard1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(fit: StackFit.passthrough, children: [
          Container(
            height: 290,
            // width: 220, //MediaQuery.of(context).size.width * 0.56,
            decoration: const BoxDecoration(
              color: Col.lightgreylite,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.locale.toString() == 'en'
                          ? MediaQuery.of(context).size.width * 0.07
                          : 0,
                      right: Get.locale.toString() == 'ar'
                          ? MediaQuery.of(context).size.width * 0.07
                          : 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Dietician Assessment".tr(),
                        style: TextStyle(
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Bold
                              : Assets.TheSans_Bold,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        "You can select your meal as per \n nutritionist recommendations"
                            .tr(),
                        style: TextStyle(
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Regular
                              : Assets.TheSans_plain,
                          fontSize: 12,
                          color: Col.black,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 52,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Col.darkgreen,
                          borderRadius: BorderRadius.only(
                            topLeft: Get.locale.toString() == 'en'
                                ? const Radius.circular(20)
                                : const Radius.circular(0),
                            topRight: Get.locale.toString() == 'en'
                                ? const Radius.circular(0)
                                : const Radius.circular(20),
                            bottomRight: Get.locale.toString() == 'en'
                                ? const Radius.circular(20)
                                : const Radius.circular(0),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      titlePadding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 10),
                                      //this right here
                                      title: SizedBox(
                                        height: 280.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: const Icon(
                                                      Icons.clear,
                                                      size: 25,
                                                      color: Col.darkgreen,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "How would you like to Proceed?"
                                                  .tr(),
                                              style: TextStyle(
                                                fontFamily: Get.locale
                                                            .toString() ==
                                                        'en'
                                                    ? Assets.Product_Sans_Bold
                                                    : Assets.TheSans_Bold,
                                                fontSize: 25,
                                                color: Col.blue,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Col.darkgreen,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Get.back();

                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return BackdropFilter(
                                                                filter: ImageFilter
                                                                    .blur(
                                                                        sigmaX:
                                                                            5,
                                                                        sigmaY:
                                                                            5),
                                                                child:
                                                                    AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  titlePadding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20,
                                                                          top:
                                                                              10),
                                                                  //this right here
                                                                  title:
                                                                      SizedBox(
                                                                    height:
                                                                        250.0,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                              child: const Padding(
                                                                                padding: EdgeInsets.only(bottom: 10),
                                                                                child: Icon(
                                                                                  Icons.clear,
                                                                                  size: 25,
                                                                                  color: Col.darkgreen,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          "Alert Message!"
                                                                              .tr(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily: Get.locale.toString() == 'en'
                                                                                ? Assets.Product_Sans_Bold
                                                                                : Assets.TheSans_Bold,
                                                                            fontSize:
                                                                                25,
                                                                            color:
                                                                                Col.blue,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          "Your Consultation Fees will be deducted from the Final Order."
                                                                              .tr(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily: Get.locale.toString() == 'en'
                                                                                ? Assets.Product_Sans_Bold
                                                                                : Assets.TheSans_Bold,
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                Col.black,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              30,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                height: 50,
                                                                                decoration: const BoxDecoration(
                                                                                  color: Col.darkgreen,
                                                                                  borderRadius: BorderRadius.all(
                                                                                    Radius.circular(10),
                                                                                  ),
                                                                                ),
                                                                                child: TextButton(
                                                                                  onPressed: () {
                                                                                    InitialStatusController init = Get.find();
                                                                                    _makePhoneCall('${init.dietitionPhoneNum}');
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text(
                                                                                    "Proceed".tr(),
                                                                                    style: TextStyle(
                                                                                      color: Col.WHITE,
                                                                                      fontFamily: Get.locale.toString() == 'en' ? Assets.Product_Sans_Regular : Assets.TheSans_plain,
                                                                                      fontWeight: FontWeight.normal,
                                                                                      fontSize: 14,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ));
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        "Book Through Call Center"
                                                            .tr(),
                                                        style: TextStyle(
                                                          color: Col.WHITE,
                                                          fontFamily: Get.locale
                                                                      .toString() ==
                                                                  'en'
                                                              ? Assets
                                                                  .Product_Sans_Regular
                                                              : Assets
                                                                  .TheSans_plain,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    height: 50,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Col.blue,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        _launchDeveloperPage();
                                                      },
                                                      child: Text(
                                                        "Book Through IMC App"
                                                            .tr(),
                                                        style: TextStyle(
                                                          color: Col.WHITE,
                                                          fontFamily: Get.locale
                                                                      .toString() ==
                                                                  'en'
                                                              ? Assets
                                                                  .Product_Sans_Regular
                                                              : Assets
                                                                  .TheSans_plain,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                              },
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Col.WHITE,
                            size: 20,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: Get.locale.toString() == 'en'
                ? MediaQuery.of(context).size.width * 0.073
                : 0,
            right: Get.locale.toString() == 'ar'
                ? MediaQuery.of(context).size.width * 0.073
                : 0,
            top: -15,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  bottomLeft: Get.locale.toString() == 'en'
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
                  bottomRight: Get.locale.toString() == 'ar'
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
                  topRight: const Radius.circular(20),
                ),
                image: const DecorationImage(
                  image: AssetImage(
                    Assets.DieticianAssessment_image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 220,
          //   left:MediaQuery.of(context).size.width * 0.07,
          //   child: Text(
          //     "Dietician Assessment",
          //     style: TextStyle(
          //       fontFamily: Assets.Product_Sans_Bold,
          //       fontSize: 23,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: 250,
          //   left:MediaQuery.of(context).size.width * 0.07,
          //   right:MediaQuery.of(context).size.width * 0.07,
          //   child: Text(
          //     "You can select your meal as per nutritionist recommendations",
          //     style: TextStyle(
          //       fontFamily: Assets.Poppins_Medium,
          //       fontSize: 11,
          //       color: Col.black,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   left:MediaQuery.of(context).size.width * 0.7,
          //   top: 264,
          //   child: Container(
          //       height: 52,
          //       width: 50,
          //       decoration: BoxDecoration(
          //         color: Col.darkgreen,
          //         borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(20),
          //           bottomRight: Radius.circular(20),
          //         ),
          //       ),
          //       child: InkWell(
          //         onTap: () {},
          //         child: Icon(
          //           Icons.arrow_forward_ios_outlined,
          //           color: Col.WHITE,
          //           size: 20,
          //         ),
          //       )),
          // ),
        ]),
        const SizedBox(
          height: 25,
        )
      ],
    );
  }

  Future<void> _makePhoneCall(String url) async {
    url = "tel:$url";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class PlansCard2 extends StatefulWidget {
  @override
  _PlansCard2State createState() => _PlansCard2State();
}

class _PlansCard2State extends State<PlansCard2> {
  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.passthrough, children: [
      InkWell(
        child: Container(
          height: 300,
          // width: 220, //MediaQuery.of(context).size.width * 0.56,
          decoration: const BoxDecoration(
            color: Col.lightgreylite,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Get.locale.toString() == 'en'
                        ? MediaQuery.of(context).size.width * 0.07
                        : 0,
                    right: Get.locale.toString() == 'ar'
                        ? MediaQuery.of(context).size.width * 0.07
                        : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Meal Plans".tr(),
                      style: TextStyle(
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Bold
                            : Assets.TheSans_Bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      "You can select your meal as per \n nutritionist recommendations"
                          .tr(),
                      style: TextStyle(
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 12,
                        color: Col.black,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 52,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Col.darkgreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Get.locale.toString() == 'en'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          topRight: Get.locale.toString() == 'en'
                              ? const Radius.circular(0)
                              : const Radius.circular(20),
                          bottomRight: Get.locale.toString() == 'en'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          InitialStatusController initialcon =
                              Get.find<InitialStatusController>();

                          if (initialcon.userExsists.value.toString() ==
                              'Yes') {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const GoalSelectionScreen(),
                              withNavBar:
                                  true, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          } else {
                            Get.toNamed('/DietCategory');
                          }
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Col.WHITE,
                          size: 20,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: Get.locale.toString() == 'en'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        right: Get.locale.toString() == 'ar'
            ? MediaQuery.of(context).size.width * 0.073
            : 0,
        top: -15,
        child: Container(
          height: 200,
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              bottomLeft: Get.locale.toString() == 'en'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: Get.locale.toString() == 'ar'
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              topRight: const Radius.circular(20),
            ),
            image: const DecorationImage(
              image: AssetImage(
                Assets.MealPlans_image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      // Positioned(
      //   top: 220,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "Dietician Assessment",
      //     style: TextStyle(
      //       fontFamily: Assets.Product_Sans_Bold,
      //       fontSize: 23,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   top: 250,
      //   left:MediaQuery.of(context).size.width * 0.07,
      //   right:MediaQuery.of(context).size.width * 0.07,
      //   child: Text(
      //     "You can select your meal as per nutritionist recommendations",
      //     style: TextStyle(
      //       fontFamily: Assets.Poppins_Medium,
      //       fontSize: 11,
      //       color: Col.black,
      //     ),
      //   ),
      // ),
      // Positioned(
      //   left:MediaQuery.of(context).size.width * 0.7,
      //   top: 264,
      //   child: Container(
      //       height: 52,
      //       width: 50,
      //       decoration: BoxDecoration(
      //         color: Col.darkgreen,
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20),
      //           bottomRight: Radius.circular(20),
      //         ),
      //       ),
      //       child: InkWell(
      //         onTap: () {},
      //         child: Icon(
      //           Icons.arrow_forward_ios_outlined,
      //           color: Col.WHITE,
      //           size: 20,
      //         ),
      //       )),
      // ),
    ]);
  }
}
