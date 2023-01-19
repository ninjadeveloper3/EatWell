// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'dart:ui';

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietdaysPlanController.dart';
import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplaning.dart';
import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplanningController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory_controller.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DietDayPlan extends StatefulWidget {
  @override
  State<DietDayPlan> createState() => _DietDayPlanState();
}

class _DietDayPlanState extends State<DietDayPlan> {
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();

  InitialStatusController initialCon = Get.find<InitialStatusController>();

  DaysPlanController controller = Get.find<DaysPlanController>();

  @override
  void dispose() {
    initialCon.userExsists.toString() == 'Yes'
        ? Get.delete<DaysPlanController>()
        : null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(
            context: context,
            title: 'Diet',
            lighttitle: 'Plans',
          )),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.daysPlan.isEmpty
            ? const LoadingWidget()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  color: Col.WHITE,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          elevation: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: HexColor(categoryController
                                      .dietCategory[int.parse(
                                          controller.selectedindex.toString())]
                                      .headingColor)
                                  .withOpacity(.0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0)),
                            ),
                            height: 240.h,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    Assets.BgKito_Image,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(fit: StackFit.expand, children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Col.ksidePadding,
                                      vertical: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Wrap(
                                          runSpacing: 0,
                                          children: [
                                            Text(
                                              categoryController
                                                  .dietCategory[int.parse(
                                                      controller.selectedindex
                                                          .toString())]
                                                  .name,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black
                                                          .withOpacity(.2),
                                                      offset: const Offset(
                                                          0.2, 2.0),
                                                      blurRadius: 6.0,
                                                    ),
                                                  ],
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.053,
                                                  color: HexColor(
                                                      categoryController
                                                          .dietCategory[int
                                                              .parse(controller
                                                                  .selectedindex
                                                                  .toString())]
                                                          .headingColor),
                                                  fontFamily: Get.locale
                                                              .toString() ==
                                                          'en'
                                                      ? Assets.Poppins_Bold
                                                      : Assets.TheSans_Bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 90.h,
                                  right: 20,
                                  left: 20,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          // height: 100.h,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .80,
                                          child: ZoomIn(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${EnvironmentConstants.baseUrl}/${categoryController.dietCategory[int.parse(controller.selectedindex.toString())].image}',
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitHeight,

                                                    // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                                                    // )
                                                  ),
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const LoadingWidget(
                                                isImage: true,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Col.blue,
                                              ),
                                              fit: BoxFit.fitHeight,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.38,
                                              // height:
                                              //     100,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: Get.locale.toString() == 'ar' ? 40 : 0,
                            left: Get.locale.toString() == 'en' ? 40 : 0,
                            top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "${categoryController.dietCategory[int.parse(controller.selectedindex.toString())].name} ${'Plans'.tr()}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Poppins_Bold
                                          : Assets.TheSans_Bold,
                                      color: Col.blue,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Get.locale.toString() == 'en'
                                          ? 20
                                          : 0,
                                      left: Get.locale.toString() == 'ar'
                                          ? 20
                                          : 0,
                                      top: 4),
                                  child: Text(
                                    categoryController
                                        .dietCategory[int.parse(controller
                                            .selectedindex
                                            .toString())]
                                        .description,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.014,
                                      color: Col.black,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Poppins_Regular
                                          : Assets.TheSans_plain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.014,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Choose Plan".tr(),
                                  style: TextStyle(
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Poppins_Bold
                                        : Assets.TheSans_Bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.025,
                                    color: Col.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.014,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.daysPlan.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return SlideInLeft(
                              delay: const Duration(milliseconds: 200),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      AssesmentDailog(context);
                                      initialCon.plandays(controller
                                          .daysPlan[index].duration
                                          .toString());
                                      initialCon.planID(controller
                                          .daysPlan[index].id
                                          .toString());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.locale.toString() == 'en'
                                              ? 35
                                              : 20,
                                          right: Get.locale.toString() == 'ar'
                                              ? 20
                                              : 10),
                                      child: DietCardPlan1(
                                        index: index,
                                        controller: controller,
                                        days: '7 days',
                                        rupees: '666',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            );
                          }))
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<dynamic> AssesmentDailog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) {
        return Center(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  titlePadding:
                      const EdgeInsets.only(left: 20, right: 20, top: 10),
                  //this right here
                  title: SizedBox(
                    height: Get.locale.toString() == 'en'
                        ? MediaQuery.of(context).size.height * .38
                        : MediaQuery.of(context).size.height * .42,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Icon(
                                  Icons.clear,
                                  size:
                                      MediaQuery.of(context).size.height * .04,
                                  color: Col.darkgreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Alert Message!".tr(),
                          style: TextStyle(
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                            fontSize: MediaQuery.of(context).size.height * .03,
                            color: Col.blue,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Dietitian consultant is included in the overall price.Are you sure you don't want the dietitian assessment?"
                                  .tr(),
                              style: TextStyle(
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Poppins_Bold
                                    : Assets.TheSans_Bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * .015,
                                color: Col.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
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
                                    _launchDeveloperPage();
                                  },
                                  child: Text(
                                    "Go to Assessment".tr(),
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Poppins_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .015,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Col.lightgrey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    if (initialCon.userExsists.value
                                            .toString() ==
                                        'Yes') {
                                      Get.back();

                                      Get.put(
                                          MealPlanningController(Get.find()));

                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: MealPlanning(),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    } else {
                                      Get.back();

                                      Get.toNamed('/mealplaningScreen');
                                    }
                                  },
                                  child: Text(
                                    "I don't want".tr(),
                                    style: TextStyle(
                                      color: Col.black,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Poppins_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.normal,
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              .015,
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
              )),
        );
      },
    );
  }

  _launchDeveloperPage() async {
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
  }
}

class DietCardPlan1 extends StatefulWidget {
  int index;
  String? days;
  String? rupees;
  DaysPlanController controller;
  DietCardPlan1(
      {this.days, this.rupees, required this.index, required this.controller});

  @override
  _DietCardPlan1State createState() => _DietCardPlan1State();
}

class _DietCardPlan1State extends State<DietCardPlan1> {
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * .18,
        padding: const EdgeInsets.only(top: 10, right: 20, bottom: 10),
        // height: MediaQuery.of(context).size.height * 0.23,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          image: DecorationImage(
            image: AssetImage(
              Assets.ChoosePlan_Image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.locale.toString() == 'en' ? 20 : 0,
                      right: Get.locale.toString() == 'ar' ? 20 : 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .62,
                            child: Text(
                              widget.controller.daysPlan[widget.index].name,
                              style: TextStyle(
                                color: Col.WHITE,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.028,
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Poppins_Bold
                                    : Assets.TheSans_Bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      // Text(
                      //   "Full  Day",
                      //   style: TextStyle(
                      //     color: Col.WHITE.withOpacity(0.5),
                      //     letterSpacing: 4.0,
                      //     fontSize: MediaQuery.of(context).size.height * 0.019,
                      //     fontFamily: Assets.Poppins_Bold,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_rounded,
                            size: 30,
                            color: HexColor(categoryController
                                .dietCategory[int.parse(
                                    widget.controller.selectedindex.toString())]
                                .headingColor),
                          ),
                          // Image.asset(
                          //   Assets.Calendar_Image,
                          //   height: MediaQuery.of(context).size.height * 0.028,
                          //   fit: BoxFit.fill,
                          // ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${widget.controller.daysPlan[widget.index].duration}${'Days'.tr()}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Col.WHITE,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.032,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Poppins_Bold
                                  : Assets.TheSans_Bold,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Stack(
                      //                      fit: StackFit.passthrough,

                      //   children: [
                      //     Positioned(
                      //       top:-(MediaQuery.of(context).size.height* 0.020),
                      //       child: Text(
                      //         "Full  Day",
                      //         style: TextStyle(
                      //           color: Col.WHITE.withOpacity(0.5),
                      //           letterSpacing: 4.0,
                      //           fontSize: MediaQuery.of(context).size.height * 0.019,
                      //           fontFamily: Assets.Poppins_Bold,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //     Row(
                      //       children: [
                      //         Image.asset(
                      //           Assets.Calendar_Image,
                      //           height:  MediaQuery.of(context).size.height * 0.028,
                      //           fit: BoxFit.fill,
                      //         ),
                      //         Text(
                      //           "7 Days",
                      //           textAlign: TextAlign.start,
                      //           style: TextStyle(
                      //             color: Col.WHITE,
                      //             fontSize: MediaQuery.of(context).size.height * 0.032,
                      //             fontFamily: Assets.Product_Sans_Bold,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Get.locale.toString() == 'en'
                ? Positioned(
                    top: MediaQuery.of(context).size.height * .01,
                    right: 0,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.controller.daysPlan[widget.index].price,
                          style: TextStyle(
                            color: HexColor(categoryController
                                .dietCategory[int.parse(
                                    widget.controller.selectedindex.toString())]
                                .headingColor),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.068,
                            fontWeight: FontWeight.bold,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                        Text(
                          "SAR",
                          style: TextStyle(
                            color: Col.WHITE,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                        // Text(
                        //   "SAR",
                        //   style: TextStyle(
                        //     color: Col.WHITE,
                        //     fontSize: MediaQuery.of(context).size.height * 0.02,
                        //     fontFamily: Assets.Poppins_Bold,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: MediaQuery.of(context).size.width * 0.06),
                        //   child: Stack(
                        //     fit: StackFit.passthrough,
                        //     children: [
                        //       Positioned(
                        //         top: -(MediaQuery.of(context).size.height * 0.023),
                        //         child: Text(
                        //           "SAR",
                        //           style: TextStyle(
                        //             color: Col.WHITE,
                        //             fontSize:
                        //                 MediaQuery.of(context).size.height * 0.02,
                        //             fontFamily: Assets.Poppins_Bold,
                        //           ),
                        //         ),
                        //       ),
                        //       Container(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : Positioned(
                    top: MediaQuery.of(context).size.height * .01,
                    left: 20,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          widget.controller.daysPlan[widget.index].price,
                          style: TextStyle(
                            color: HexColor(categoryController
                                .dietCategory[int.parse(
                                    widget.controller.selectedindex.toString())]
                                .headingColor),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.068,
                            fontWeight: FontWeight.bold,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                        Text(
                          "SAR",
                          style: TextStyle(
                            color: Col.WHITE,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                        // Text(
                        //   "SAR",
                        //   style: TextStyle(
                        //     color: Col.WHITE,
                        //     fontSize: MediaQuery.of(context).size.height * 0.02,
                        //     fontFamily: Assets.Poppins_Bold,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: MediaQuery.of(context).size.width * 0.06),
                        //   child: Stack(
                        //     fit: StackFit.passthrough,
                        //     children: [
                        //       Positioned(
                        //         top: -(MediaQuery.of(context).size.height * 0.023),
                        //         child: Text(
                        //           "SAR",
                        //           style: TextStyle(
                        //             color: Col.WHITE,
                        //             fontSize:
                        //                 MediaQuery.of(context).size.height * 0.02,
                        //             fontFamily: Assets.Poppins_Bold,
                        //           ),
                        //         ),
                        //       ),
                        //       Container(),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
