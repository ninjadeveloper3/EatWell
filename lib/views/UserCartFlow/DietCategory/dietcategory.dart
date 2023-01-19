import 'dart:ui';

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory_controller.dart';
import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietDaysPlan.dart';
import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietdaysPlanController.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:lottie/lottie.dart';

class DietCategory extends StatefulWidget {
  const DietCategory({Key? key}) : super(key: key);

  @override
  State<DietCategory> createState() => _DietCategoryState();
}

class _DietCategoryState extends State<DietCategory> {
  InitialStatusController initialCon = Get.find<InitialStatusController>();

  DietCategoryController controller = Get.find<DietCategoryController>();

  @override
  void dispose() {
    initialCon.userExsists.toString() == 'Yes'
        ? Get.delete<DietCategoryController>()
        : null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
      appBar: PreferredSize(
          child: Appbar(
            context: context,
            title: 'DIET',
            lighttitle: 'CATEGORY',
          ),
          preferredSize: const Size.fromHeight(150)),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 0.w),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () => Column(
                  children: [
                    controller.dietCategory.isEmpty &&
                            controller.dietcategoryisEmpty.value == 'false'
                        ? const SizedBox(
                            height: 500, child: Center(child: LoadingWidget()))
                        : controller.dietCategory.isEmpty &&
                                controller.dietcategoryisEmpty.value == 'true'
                            ? Center(
                                child: SizedBox(
                                  height: 400.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset(
                                        'assets/lottie/nodata.json',
                                        // width: 200,
                                        height: 200,
                                        fit: BoxFit.fill,
                                      ),
                                      Text('No diet category found'.tr())
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.dietCategory.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SlideInRight(
                                    child: Column(
                                      children: [
                                        index == 0
                                            ? Column(
                                                children: [
                                                  const SizedBox(
                                                      height:
                                                          30 //MediaQuery.of(context).size.height *0.03,
                                                      ),
                                                  const SizedBox(height: 12),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal:
                                                            Col.ksidePadding +
                                                                2),
                                                    child: Wrap(
                                                      children: [
                                                        Align(
                                                          alignment: Get.locale
                                                                      .toString() ==
                                                                  'en'
                                                              ? Alignment
                                                                  .bottomLeft
                                                              : Alignment
                                                                  .bottomRight,
                                                          child: Text(
                                                            initialCon
                                                                .userselectedgoalDiscription
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.015,
                                                              color: Col.black,
                                                              fontFamily: Get
                                                                          .locale
                                                                          .toString() ==
                                                                      'en'
                                                                  ? Assets
                                                                      .Product_Sans_Regular
                                                                  : Assets
                                                                      .TheSans_plain,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        const SizedBox(
                                            height:
                                                10 //MediaQuery.of(context).size.height *0.03,
                                            ),
                                        InkWell(
                                            highlightColor: HexColor(controller
                                                    .dietCategory[index]
                                                    .headingColor)
                                                .withOpacity(.2),
                                            focusColor: HexColor(controller
                                                    .dietCategory[index]
                                                    .headingColor)
                                                .withOpacity(.2),
                                            hoverColor: HexColor(controller
                                                    .dietCategory[index]
                                                    .headingColor)
                                                .withOpacity(.2),
                                            splashColor: HexColor(controller
                                                    .dietCategory[index]
                                                    .headingColor)
                                                .withOpacity(.2),
                                            onTap: () {
                                              if (initialCon
                                                          .dietcategoryIDforCartMeal
                                                          .toString() ==
                                                      controller
                                                          .selectedCategory(
                                                              controller
                                                                  .dietCategory[
                                                                      index]
                                                                  .id
                                                                  .toString()) &&
                                                  initialCon.userCartEmpty
                                                          .value ==
                                                      '1') {
                                                if (initialCon.userExsists.value
                                                        .toString() ==
                                                    'Yes') {
                                                  Get.put(
                                                      DailyMealSelectController(
                                                          Get.find()));
                                                  PersistentNavBarNavigator
                                                      .pushNewScreen(
                                                    context,
                                                    screen:
                                                        SelectDailyMealScreen(),
                                                    withNavBar:
                                                        true, // OPTIONAL VALUE. True by default.
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino,
                                                  );
                                                } else {
                                                  Get.toNamed(
                                                      '/dailymealSelection');
                                                }
                                              } else if (initialCon
                                                      .userCartEmpty.value ==
                                                  '1') {
                                                AssesmentDailog(context);
                                              } else {
                                                controller.selectedIndex(
                                                    index.toString());
                                                controller.selectedCategory(
                                                    controller
                                                        .dietCategory[index].id
                                                        .toString());
                                                initialCon.dietcategoryID(
                                                    controller.selectedCategory(
                                                        controller
                                                            .dietCategory[index]
                                                            .id
                                                            .toString()));
                                                if (initialCon.userExsists.value
                                                        .toString() ==
                                                    'Yes') {
                                                  Get.put(DaysPlanController(
                                                      Get.find()));
                                                  PersistentNavBarNavigator
                                                      .pushNewScreen(
                                                    context,
                                                    screen: DietDayPlan(),
                                                    withNavBar:
                                                        true, // OPTIONAL VALUE. True by default.
                                                    pageTransitionAnimation:
                                                        PageTransitionAnimation
                                                            .cupertino,
                                                  );
                                                } else {
                                                  Get.toNamed('/dietdaysplan');
                                                }
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal:
                                                          Col.ksidePadding),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                      ),
                                                      elevation: 2,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HexColor(controller
                                                                  .dietCategory[
                                                                      index]
                                                                  .headingColor)
                                                              .withOpacity(.2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        height: 170.h,
                                                        child: Stack(
                                                            fit:
                                                                StackFit.expand,
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        22,
                                                                    vertical:
                                                                        15),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Wrap(
                                                                        runSpacing:
                                                                            0,
                                                                        children: [
                                                                          Text(
                                                                            controller.dietCategory[index].name,
                                                                            style:
                                                                                TextStyle(shadows: [
                                                                              Shadow(
                                                                                color: Colors.black.withOpacity(.2),
                                                                                offset: const Offset(0.2, 2.0),
                                                                                blurRadius: 6.0,
                                                                              ),
                                                                            ], fontSize: MediaQuery.of(context).size.height * 0.053, color: HexColor(controller.dietCategory[index].headingColor), fontFamily: Assets.Poppins_Bold),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            130,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20),
                                                                child: Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      child: SvgPicture.network(EnvironmentConstants
                                                                              .baseUrl +
                                                                          '/' +
                                                                          controller
                                                                              .dietCategory[index]
                                                                              .bgImage),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Get.locale.toString() == 'ar'
                                                    ? Positioned(
                                                        top: 40.h,
                                                        left: 0,
                                                        child: ZoomIn(
                                                          delay: const Duration(
                                                              milliseconds:
                                                                  200),
                                                          child: SizedBox(
                                                            // color: Colors.amber,
                                                            // height: 100.h,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .52,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .43,
                                                            // width: 270,
                                                            // height: 160,
                                                            child: Transform
                                                                .rotate(
                                                              angle:
                                                                  -math.pi / 50,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: Get.locale.toString() ==
                                                                            'en'
                                                                        ? 22
                                                                        : 0,
                                                                    right: Get.locale.toString() ==
                                                                            'ar'
                                                                        ? 22
                                                                        : 0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: EnvironmentConstants
                                                                          .baseUrl +
                                                                      '/' +
                                                                      controller
                                                                          .dietCategory[
                                                                              index]
                                                                          .image
                                                                          .toString(),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.38,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .contain,

                                                                        // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                                                                        // )
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const LoadingWidget(
                                                                    isImage:
                                                                        true,
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                    Icons.error,
                                                                    color: Col
                                                                        .blue,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.38,
                                                                  // height:
                                                                  //     100,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Positioned(
                                                        top: 50.h,
                                                        right: 0,
                                                        child: ZoomIn(
                                                          delay: const Duration(
                                                              milliseconds:
                                                                  200),
                                                          child: SizedBox(
                                                            // color: Colors.amber,
                                                            // height: 100.h,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .42,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .33,
                                                            // width: 270,
                                                            // height: 160,
                                                            child: Transform
                                                                .rotate(
                                                              angle:
                                                                  -math.pi / 50,
                                                              child: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: Get.locale.toString() ==
                                                                            'en'
                                                                        ? 22
                                                                        : 0,
                                                                    right: Get.locale.toString() ==
                                                                            'ar'
                                                                        ? 22
                                                                        : 0),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  imageUrl: EnvironmentConstants
                                                                          .baseUrl +
                                                                      '/' +
                                                                      controller
                                                                          .dietCategory[
                                                                              index]
                                                                          .image
                                                                          .toString(),
                                                                  imageBuilder:
                                                                      (context,
                                                                              imageProvider) =>
                                                                          Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.38,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image:
                                                                            imageProvider,
                                                                        fit: BoxFit
                                                                            .contain,

                                                                        // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                                                                        // )
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      const LoadingWidget(
                                                                    isImage:
                                                                        true,
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      const Icon(
                                                                    Icons.error,
                                                                    color: Col
                                                                        .blue,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.38,
                                                                  // height:
                                                                  //     100,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  );
                                })
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  Future<dynamic> AssesmentDailog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                    height: 280.0,
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
                          "Alert Message!".tr(),
                          style: TextStyle(
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Regular
                                : Assets.TheSans_plain,
                            fontSize: 25,
                            color: Col.blue,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "There is already cart in progress do you want to discard it?"
                                  .tr(),
                              style: TextStyle(
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Regular
                                    : Assets.TheSans_plain,
                                fontSize: 12,
                                color: Col.black,
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
                                decoration: const BoxDecoration(
                                  color: Col.darkgreen,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    String params = '?cartId=';

                                    initialCon.deleteCart(params);
                                  },
                                  child: Text(
                                    "Yes Discard it".tr(),
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.normal,
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
                                decoration: const BoxDecoration(
                                  color: Col.lightgrey,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/dailymealSelection');
                                  },
                                  child: Text(
                                    "Go to Cart".tr(),
                                    style: TextStyle(
                                      color: Col.black,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.normal,
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
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
