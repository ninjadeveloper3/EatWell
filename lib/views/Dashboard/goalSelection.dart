import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Calories_Calculator/caloriesCalculatorController.dart';
import 'package:eat_well/views/Calories_Calculator/caloriescalculator.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class GoalSelectionScreen extends StatefulWidget {
  const GoalSelectionScreen({Key? key}) : super(key: key);

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  void initState() {
    controller.onboardDataList.isEmpty
        ? controller.getOnBoardDataForSelectionSecreen()
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Appbar(
            context: context,
            title: 'Goal',
            lighttitle: "Selection",
          ),
          preferredSize: const Size.fromHeight(150)),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Assets.BgDashBoard_Image,
              ),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Col.ksidePadding),
          child: Column(
            children: [
              Obx((() => controller.onboardDataList.isEmpty
                  ? const Expanded(child: LoadingWidget())
                  : Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.onboardDataList.length,
                          itemBuilder: ((context, index) {
                            return FadeInRight(
                              child: Column(
                                children: [
                                  index == 0
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Find Your Goal".tr(),
                                                  style: TextStyle(
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Bold
                                                        : Assets.TheSans_Bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                    fontWeight: FontWeight.bold,
                                                    color: Col.blue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "We have healthy diet plans and much"
                                                      .tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Regular
                                                        : Assets.TheSans_plain,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                    color: Col.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "more for you.".tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Regular
                                                        : Assets.TheSans_plain,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                    color: Col.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        )
                                      : Container(),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .23,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller.userGoal(controller
                                                .onboardDataList[index].id
                                                .toString());
                                            controller
                                                .userselectedgoalDiscription(
                                                    (controller
                                                        .onboardDataList[index]
                                                        .description
                                                        .toString()));

                                            Get.put(
                                                CaloriesCalculatorController(
                                                    Get.find()));
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen:
                                                  const CaloriesCalculator(),
                                              withNavBar:
                                                  true, // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );

                                            // Get.toNamed('/DietCategory');
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .32,
                                            // color: Colors.black12,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.locale.toString() ==
                                                          'en'
                                                      ? 20
                                                      : 0,
                                                  right:
                                                      Get.locale.toString() ==
                                                              'ar'
                                                          ? 10
                                                          : 0,
                                                  top: 20),
                                              child: Column(
                                                children: [
                                                  Wrap(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 22,
                                                                bottom: 12),
                                                        child: Text(
                                                          controller
                                                              .onboardDataList[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontFamily: Get
                                                                        .locale
                                                                        .toString() ==
                                                                    'en'
                                                                ? Assets
                                                                    .Product_Sans_Bold
                                                                : Assets
                                                                    .TheSans_Bold,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.022, //23.3,
                                                            color: Col.blue,
                                                          ),
                                                          maxLines: 3,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        child: SizedBox(
                                                          // color: Colors.amber,
                                                          child: Image.asset(
                                                            Assets
                                                                .Nextarrow_Image,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.027,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          // color: Colors.red,
                                          // height: 0,

                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .45,
                                          // color: Colors.limeAccent,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 33),
                                            child: CachedNetworkImage(
                                              imageUrl: EnvironmentConstants
                                                      .baseUrl +
                                                  '/' +
                                                  controller
                                                      .onboardDataList[index]
                                                      .image
                                                      .toString(),
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fitWidth,
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
                                              fit: BoxFit.cover,
                                              // height: MediaQuery.of(context).size.width * 0.38,
                                              // height:
                                              //     100,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  index == controller.onboardDataList.length - 1
                                      ? const SizedBox(
                                          height: 50,
                                        )
                                      : const SizedBox(
                                          height: 20,
                                        ),
                                ],
                              ),
                            );
                          })),
                    ))),
            ],
          ),
        ),
      ),
    );
  }
}
