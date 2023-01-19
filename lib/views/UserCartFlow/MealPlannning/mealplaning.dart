import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/caloriess.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplanningController.dart';
import 'package:eat_well/views/animations/slide_animation.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:eat_well/widgets/infoDailog.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:animate_do/animate_do.dart';
import '../../../api-handler/env_constants.dart';
import '../DietCategory/dietcategory_controller.dart';

class MealPlanning extends StatefulWidget {
  @override
  _MealPlanningState createState() => _MealPlanningState();
}

class _MealPlanningState extends State<MealPlanning> {
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();

  final UniqueKey _abcKey = UniqueKey();
  MealPlanningController controller = Get.find<MealPlanningController>();
  InitialStatusController initialCon = Get.find();
  int tag = -1;
  int indexofcalories = -1;
  int grouval = -1;
  // List<String> options = [];
  List<Caloriess> options = [];
  List<String> optionsStrings = [];

  @override
  void dispose() {
    initialCon.userExsists.toString() == 'Yes'
        ? Get.delete<MealPlanningController>()
        : null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Appbar(
            context: context,
            title: 'Meal',
            lighttitle: 'Selection',
          ),
          preferredSize: const Size.fromHeight(150)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            color: Col.WHITE,
            child: SlideAnimation(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          Assets.BgKito_Image,
                        ),
                        fit: BoxFit.cover,
                      ),
                      color: HexColor(categoryController
                              .dietCategory[int.parse(
                                  controller.selectedindex.toString())]
                              .headingColor)
                          .withOpacity(.0),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    height: 240.h,
                    child: Stack(fit: StackFit.expand, children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Wrap(
                                runSpacing: 0,
                                children: [
                                  Text(
                                    categoryController
                                        .dietCategory[int.parse(controller
                                            .selectedindex
                                            .toString())]
                                        .name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(.2),
                                            offset: const Offset(0.2, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.053,
                                        color: HexColor(categoryController
                                            .dietCategory[int.parse(controller
                                                .selectedindex
                                                .toString())]
                                            .headingColor),
                                        fontFamily:
                                            Get.locale.toString() == 'en'
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
                                width: MediaQuery.of(context).size.width * .80,
                                child: ZoomIn(
                                  delay: const Duration(milliseconds: 500),
                                  child: CachedNetworkImage(
                                    imageUrl: EnvironmentConstants.baseUrl +
                                        '/' +
                                        categoryController
                                            .dietCategory[int.parse(controller
                                                .selectedindex
                                                .toString())]
                                            .image
                                            .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height:
                                          MediaQuery.of(context).size.width *
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
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Col.blue,
                                    ),
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.width *
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                categoryController
                                        .dietCategory[int.parse(controller
                                            .selectedindex
                                            .toString())]
                                        .name +
                                    ' ' +
                                    'Plans'.tr(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Get.locale.toString() == 'en'
                                      ? Assets.Poppins_Bold
                                      : Assets.TheSans_Bold,
                                  color: Col.blue,
                                  fontSize: MediaQuery.of(context).size.height *
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
                                  right: Get.locale.toString() == 'en' ? 20 : 0,
                                  left: Get.locale.toString() == 'ar' ? 20 : 0,
                                  top: 4),
                              child: Text(
                                categoryController
                                    .dietCategory[int.parse(
                                        controller.selectedindex.toString())]
                                    .description,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
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
                          height: MediaQuery.of(context).size.height * 0.014,
                        ),
                        Wrap(
                          children: [
                            Align(
                              alignment: Get.locale.toString() == 'en'
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                              child: Text(
                                Get.locale.toString() == 'ar'
                                    ? 'كيف ستخطط وجبتك؟'
                                    : 'How\'s you gonna plan your meal?',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: Get.locale.toString() == 'en'
                                      ? Assets.Poppins_Bold
                                      : Assets.TheSans_Bold,
                                  color: Col.blue,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.025,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.014,
                        ),
                        Obx((() => controller.mealperday.isEmpty
                            ? const SizedBox(
                                height: 500,
                                child: Center(child: LoadingWidget()))
                            : Column(
                                children: [
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.mealperday.length,
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) {
                                        return MealSelectionListView(
                                            context, index);
                                      })),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       controller.mealperday[1].name,
                                  //       style: TextStyle(
                                  //         fontFamily: Assets.Poppins_Medium,
                                  //         fontSize:
                                  //             MediaQuery.of(context).size.height *
                                  //                 0.019,
                                  //         color: Col.blue,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // SizedBox(
                                  //     // color: Colors.amber,
                                  //     height: 60.h,
                                  //     width: double.infinity,
                                  //     child: Stack(
                                  //       children: [
                                  //         FadeIn(
                                  //           child: ListView.builder(
                                  //               physics:
                                  //                   const BouncingScrollPhysics(),
                                  //               scrollDirection: Axis.horizontal,
                                  //               itemCount: controller
                                  //                   .mealperday[1]
                                  //                   .categories
                                  //                   .length,
                                  //               shrinkWrap: true,
                                  //               itemBuilder: ((context, index) {
                                  //                 return Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     InkWell(
                                  //                       onTap: () {
                                  //                         grouval = 2;
                                  //                         controller.saveIndex(
                                  //                             controller
                                  //                                 .mealperday[1]
                                  //                                 .categories[
                                  //                                     index]
                                  //                                 .id,
                                  //                             controller
                                  //                                 .mealperday[1]
                                  //                                 .selection,
                                  //                             1);
                                  //                         options.clear();
                                  //                         optionsStrings.clear();
                                  //                         indexofcalories = -1;

                                  //                         tag = -1;

                                  //                         for (var i = 0;
                                  //                             i <
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         1]
                                  //                                     .calories
                                  //                                     .length;
                                  //                             i++) {
                                  //                           optionsStrings.add(
                                  //                               controller
                                  //                                       .mealperday[
                                  //                                           1]
                                  //                                       .calories[
                                  //                                           i]
                                  //                                       .calories
                                  //                                       .toString() +
                                  //                                   ' kcal');
                                  //                           options.add(Caloriess(
                                  //                               id: controller
                                  //                                   .mealperday[1]
                                  //                                   .calories[i]
                                  //                                   .id,
                                  //                               value: controller
                                  //                                   .mealperday[1]
                                  //                                   .calories[i]
                                  //                                   .calories
                                  //                                   .toString()));
                                  //                         }
                                  //                         setState(() {});
                                  //                       },
                                  //                       child: selectMeal(
                                  //                         type: 'Svg',
                                  //                         color: controller
                                  //                                     .safeindex1
                                  //                                     .contains(controller
                                  //                                         .mealperday[
                                  //                                             1]
                                  //                                         .categories[
                                  //                                             index]
                                  //                                         .id) &&
                                  //                                 grouval == 2
                                  //                             ? Col.dullyellow
                                  //                             : Col.lightgrey,
                                  //                         text: controller
                                  //                             .mealperday[1]
                                  //                             .categories[index]
                                  //                             .name
                                  //                             .toString(),
                                  //                         iconPath: controller
                                  //                                     .safeindex1
                                  //                                     .contains(controller
                                  //                                         .mealperday[
                                  //                                             1]
                                  //                                         .categories[
                                  //                                             index]
                                  //                                         .id) &&
                                  //                                 grouval == 2
                                  //                             ? EnvironmentConstants
                                  //                                     .baseUrl +
                                  //                                 '/' +
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         1]
                                  //                                     .categories[
                                  //                                         index]
                                  //                                     .selectedimage
                                  //                                     .toString()
                                  //                             : EnvironmentConstants
                                  //                                     .baseUrl +
                                  //                                 '/' +
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         1]
                                  //                                     .categories[
                                  //                                         index]
                                  //                                     .image
                                  //                                     .toString(),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 );
                                  //               })),
                                  //         ),
                                  //         Positioned(
                                  //             top: 10,
                                  //             right: 0,
                                  //             child: Radio(
                                  //                 value: 2,
                                  //                 groupValue: grouval,
                                  //                 onChanged: (val) {
                                  //                   grouval = 2;
                                  //                   controller
                                  //                       .clearSelectedList();

                                  //                   InfoDailog(
                                  //                       'Please Select ${controller.mealperday[1].selection} Meals');

                                  //                   options.clear();
                                  //                   optionsStrings.clear();
                                  //                   indexofcalories = -1;

                                  //                   tag = -1;

                                  //                   for (var i = 0;
                                  //                       i <
                                  //                           controller
                                  //                               .mealperday[1]
                                  //                               .calories
                                  //                               .length;
                                  //                       i++) {
                                  //                     optionsStrings.add(
                                  //                         controller
                                  //                                 .mealperday[1]
                                  //                                 .calories[i]
                                  //                                 .calories
                                  //                                 .toString() +
                                  //                             ' kcal');
                                  //                     options.add(Caloriess(
                                  //                         id: controller
                                  //                             .mealperday[1]
                                  //                             .calories[i]
                                  //                             .id,
                                  //                         value: controller
                                  //                             .mealperday[1]
                                  //                             .calories[i]
                                  //                             .calories
                                  //                             .toString()));
                                  //                   }
                                  //                   setState(() {});
                                  //                 }))
                                  //       ],
                                  //     )),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // const Divider(
                                  //   height: 1,
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       controller.mealperday[2].name,
                                  //       style: TextStyle(
                                  //         fontFamily: Assets.Poppins_Medium,
                                  //         fontSize:
                                  //             MediaQuery.of(context).size.height *
                                  //                 0.019,
                                  //         color: Col.blue,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // SizedBox(
                                  //     height: 60.h,
                                  //     width: double.infinity,
                                  //     child: Stack(
                                  //       children: [
                                  //         FadeIn(
                                  //           child: ListView.builder(
                                  //               physics:
                                  //                   const BouncingScrollPhysics(),
                                  //               scrollDirection: Axis.horizontal,
                                  //               itemCount: controller
                                  //                   .mealperday[2]
                                  //                   .categories
                                  //                   .length,
                                  //               shrinkWrap: true,
                                  //               itemBuilder: ((context, index) {
                                  //                 return Row(
                                  //                   mainAxisAlignment:
                                  //                       MainAxisAlignment
                                  //                           .spaceBetween,
                                  //                   children: [
                                  //                     InkWell(
                                  //                       onTap: () {
                                  //                         grouval = 3;

                                  //                         controller.saveIndex(
                                  //                             controller
                                  //                                 .mealperday[2]
                                  //                                 .categories[
                                  //                                     index]
                                  //                                 .id,
                                  //                             controller
                                  //                                 .mealperday[2]
                                  //                                 .selection,
                                  //                             2);

                                  //                         options.clear();
                                  //                         optionsStrings.clear();
                                  //                         indexofcalories = -1;

                                  //                         tag = -1;

                                  //                         for (var i = 0;
                                  //                             i <
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         2]
                                  //                                     .calories
                                  //                                     .length;
                                  //                             i++) {
                                  //                           optionsStrings.add(
                                  //                               controller
                                  //                                       .mealperday[
                                  //                                           2]
                                  //                                       .calories[
                                  //                                           i]
                                  //                                       .calories
                                  //                                       .toString() +
                                  //                                   ' kcal');
                                  //                           options.add(Caloriess(
                                  //                               id: controller
                                  //                                   .mealperday[2]
                                  //                                   .calories[i]
                                  //                                   .id,
                                  //                               value: controller
                                  //                                   .mealperday[2]
                                  //                                   .calories[i]
                                  //                                   .calories
                                  //                                   .toString()));
                                  //                         }
                                  //                         setState(() {});
                                  //                       },
                                  //                       child: selectMeal(
                                  //                         type: 'Svg',
                                  //                         color: controller
                                  //                                     .safeindex2
                                  //                                     .contains(controller
                                  //                                         .mealperday[
                                  //                                             2]
                                  //                                         .categories[
                                  //                                             index]
                                  //                                         .id) &&
                                  //                                 grouval == 3
                                  //                             ? Col.dullyellow
                                  //                             : Col.lightgrey,
                                  //                         text: controller
                                  //                             .mealperday[2]
                                  //                             .categories[index]
                                  //                             .name
                                  //                             .toString(),
                                  //                         iconPath: controller
                                  //                                     .safeindex2
                                  //                                     .contains(controller
                                  //                                         .mealperday[
                                  //                                             2]
                                  //                                         .categories[
                                  //                                             index]
                                  //                                         .id) &&
                                  //                                 grouval == 3
                                  //                             ? EnvironmentConstants
                                  //                                     .baseUrl +
                                  //                                 '/' +
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         2]
                                  //                                     .categories[
                                  //                                         index]
                                  //                                     .selectedimage
                                  //                                     .toString()
                                  //                             : EnvironmentConstants
                                  //                                     .baseUrl +
                                  //                                 '/' +
                                  //                                 controller
                                  //                                     .mealperday[
                                  //                                         2]
                                  //                                     .categories[
                                  //                                         index]
                                  //                                     .image
                                  //                                     .toString(),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 );
                                  //               })),
                                  //         ),
                                  //         Positioned(
                                  //             top: 10,
                                  //             right: 0,
                                  //             child: Radio(
                                  //                 value: 3,
                                  //                 groupValue: grouval,
                                  //                 onChanged: (val) {
                                  //                   controller
                                  //                       .clearSelectedList();
                                  //                   InfoDailog(
                                  //                       'Please Select ${controller.mealperday[2].selection} Meals');
                                  //                   grouval = 3;

                                  //                   options.clear();
                                  //                   optionsStrings.clear();
                                  //                   indexofcalories = -1;

                                  //                   tag = -1;

                                  //                   for (var i = 0;
                                  //                       i <
                                  //                           controller
                                  //                               .mealperday[2]
                                  //                               .calories
                                  //                               .length;
                                  //                       i++) {
                                  //                     optionsStrings.add(
                                  //                         controller
                                  //                                 .mealperday[2]
                                  //                                 .calories[i]
                                  //                                 .calories
                                  //                                 .toString() +
                                  //                             ' kcal');
                                  //                     options.add(Caloriess(
                                  //                         id: controller
                                  //                             .mealperday[2]
                                  //                             .calories[i]
                                  //                             .id,
                                  //                         value: controller
                                  //                             .mealperday[2]
                                  //                             .calories[i]
                                  //                             .calories
                                  //                             .toString()));
                                  //                   }
                                  //                   setState(() {});
                                  //                 }))
                                  //       ],
                                  //     )),
                                  // const SizedBox(
                                  //   height: 8,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       'Select Calories',
                                  //       style: TextStyle(
                                  //         fontFamily: Assets.Poppins_Medium,
                                  //         fontSize: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             0.019,
                                  //         color: Col.blue,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // optionsStrings.isEmpty
                                  //     ? Container()
                                  //     : SizedBox(
                                  //         height: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             .072,
                                  //         child: ListView(
                                  //           children: [
                                  //             ElasticIn(
                                  //               child: ChipsChoice<int>.single(
                                  //                 key: _abcKey,
                                  //                 spacing: 12,
                                  //                 runSpacing: 12,
                                  //                 // mainAxisAlignment: MainAxisAlignment.start,
                                  //                 // wrapped: true,
                                  //                 choiceCheckmark: true,
                                  //                 choiceStyle: C2ChipStyle.filled(
                                  //                     color: Col.lightgrey,
                                  //                     selectedStyle:
                                  //                         const C2ChipStyle(
                                  //                             foregroundColor:
                                  //                                 Col.WHITE,
                                  //                             backgroundColor: Col
                                  //                                 .dullyellow)),
                                  //                 value: indexofcalories,
                                  //                 onChanged: (val) {
                                  //                   setState(() {
                                  //                     indexofcalories = val;
                                  //                     print(indexofcalories);
                                  //                   });
                                  //                 },
                                  //                 choiceItems: C2Choice
                                  //                     .listFrom<int, String>(
                                  //                   source: optionsStrings,
                                  //                   value: (i, v) => i,
                                  //                   label: (i, v) => v,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),

                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  submitButton(
                                      onPress: () {
                                        controller.validationCheck(
                                            grouval,
                                            int.parse(
                                                indexofcalories.toString()),
                                            options,
                                            context);
                                      },
                                      title: 'Continue'.tr(),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.064,
                                      width: double.infinity),
                                  SizedBox(
                                    height: 20.h,
                                  )
                                ],
                              )))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column MealSelectionListView(BuildContext context, int ind) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              controller.mealperday[ind].name,
              style: TextStyle(
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Poppins_Regular
                    : Assets.TheSans_plain,
                fontSize: MediaQuery.of(context).size.height * 0.019,
                color: Col.blue,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
            // color: Colors.amber,
            height: 60.h,
            width: double.infinity,
            child: Stack(
              children: [
                FadeIn(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.mealperday[ind].categories.length,
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        return SizedBox(
                          // width: 320.w,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  grouval = ind + 1;

                                  controller.saveIndex(
                                      controller
                                          .mealperday[ind].categories[index].id,
                                      controller.mealperday[ind].selection,
                                      ind,
                                      context);

                                  options.clear();
                                  optionsStrings.clear();
                                  tag = -1;
                                  indexofcalories = -1;

                                  for (var i = 0;
                                      i <
                                          controller
                                              .mealperday[ind].calories.length;
                                      i++) {
                                    optionsStrings.add(controller
                                            .mealperday[ind]
                                            .calories[i]
                                            .calorieValue
                                            .toString() +
                                        ' kcal');

                                    options.add(Caloriess(
                                        id: controller
                                            .mealperday[ind].calories[i].id,
                                        value: controller.mealperday[ind]
                                            .calories[i].calorieValue
                                            .toString()));
                                  }
                                  setState(() {});
                                },
                                child: selectMeal(
                                    type: 'Svg',
                                    color: ind == 0
                                        ? controller.safeindex0.contains(
                                                    controller
                                                        .mealperday[ind]
                                                        .categories[index]
                                                        .id) &&
                                                grouval == ind + 1
                                            ? Col.dullyellow
                                            : Col.lightgrey
                                        : ind == 1
                                            ? controller.safeindex1.contains(
                                                        controller
                                                            .mealperday[ind]
                                                            .categories[index]
                                                            .id) &&
                                                    grouval == ind + 1
                                                ? Col.dullyellow
                                                : Col.lightgrey
                                            : ind == 2
                                                ? controller.safeindex2.contains(controller
                                                            .mealperday[ind]
                                                            .categories[index]
                                                            .id) &&
                                                        grouval == ind + 1
                                                    ? Col.dullyellow
                                                    : Col.lightgrey
                                                : ind == 3
                                                    ? controller.safeindex3.contains(controller.mealperday[ind].categories[index].id) &&
                                                            grouval == ind + 1
                                                        ? Col.dullyellow
                                                        : Col.lightgrey
                                                    : ind == 4
                                                        ? controller.safeindex4
                                                                    .contains(controller
                                                                        .mealperday[ind]
                                                                        .categories[index]
                                                                        .id) &&
                                                                grouval == ind + 1
                                                            ? Col.dullyellow
                                                            : Col.lightgrey
                                                        : ind == 5
                                                            ? controller.safeindex5.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                                ? Col.dullyellow
                                                                : Col.lightgrey
                                                            : controller.safeindex6.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                                ? Col.dullyellow
                                                                : Col.lightgrey,
                                    text: controller.mealperday[ind].categories[index].name.toString(),
                                    iconcolor: ind == 0
                                        ? controller.safeindex0.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                            ? Col.WHITE
                                            : Col.black
                                        : ind == 1
                                            ? controller.safeindex1.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                ? Col.WHITE
                                                : Col.black
                                            : ind == 2
                                                ? controller.safeindex2.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                    ? Col.WHITE
                                                    : Col.black
                                                : ind == 3
                                                    ? controller.safeindex3.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                        ? Col.WHITE
                                                        : Col.black
                                                    : ind == 4
                                                        ? controller.safeindex4.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                            ? Col.WHITE
                                                            : Col.black
                                                        : ind == 5
                                                            ? controller.safeindex5.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                                ? Col.WHITE
                                                                : Col.black
                                                            : controller.safeindex6.contains(controller.mealperday[ind].categories[index].id) && grouval == ind + 1
                                                                ? Col.WHITE
                                                                : Col.black,
                                    iconPath: EnvironmentConstants.baseUrl + '/' + controller.mealperday[ind].categories[index].image.toString()),
                              ),
                            ],
                          ),
                        );
                      })),
                ),
                Get.locale.toString() == 'en'
                    ? Positioned(
                        right: 0,
                        top: 10,
                        child: Radio(
                            value: ind + 1,
                            groupValue: grouval,
                            onChanged: (val) {
                              controller.clearSelectedList();
                              grouval = ind + 1;
                              controller.mealperday[ind].selection.toString() ==
                                      '1'
                                  ? Get.locale.toString() == 'en'
                                      ? InfoDailog(context,
                                          'Please Select ${controller.mealperday[ind].selection} Meal')
                                      : InfoDailog(context,
                                          'الرجاء تحديد ${controller.mealperday[ind].selection} وجبة')
                                  : Get.locale.toString() == 'en'
                                      ? InfoDailog(context,
                                          'Please Select ${controller.mealperday[ind].selection} Meals')
                                      : InfoDailog(context,
                                          'الرجاء تحديد ${controller.mealperday[ind].selection} وجبة');

                              options.clear();
                              optionsStrings.clear();
                              tag = -1;
                              indexofcalories = -1;

                              for (var i = 0;
                                  i <
                                      controller
                                          .mealperday[ind].calories.length;
                                  i++) {
                                optionsStrings.add(controller.mealperday[ind]
                                        .calories[i].calorieValue
                                        .toString() +
                                    ' kcal');

                                options.add(Caloriess(
                                    id: controller
                                        .mealperday[ind].calories[i].id,
                                    value: controller.mealperday[ind]
                                        .calories[i].calorieValue
                                        .toString()));
                              }
                              setState(() {});
                            }),
                      )
                    : Positioned(
                        left: 0,
                        top: 10,
                        child: Radio(
                            value: ind + 1,
                            groupValue: grouval,
                            onChanged: (val) {
                              controller.clearSelectedList();
                              grouval = ind + 1;
                              controller.mealperday[ind].selection.toString() ==
                                      '1'
                                  ? Get.locale.toString() == 'en'
                                      ? InfoDailog(context,
                                          'Please Select ${controller.mealperday[ind].selection} Meal')
                                      : InfoDailog(context,
                                          'الرجاء تحديد ${controller.mealperday[ind].selection} وجبة')
                                  : Get.locale.toString() == 'en'
                                      ? InfoDailog(context,
                                          'Please Select ${controller.mealperday[ind].selection} Meals')
                                      : InfoDailog(context,
                                          'الرجاء تحديد ${controller.mealperday[ind].selection} وجبة');

                              options.clear();
                              optionsStrings.clear();
                              tag = -1;
                              indexofcalories = -1;

                              for (var i = 0;
                                  i <
                                      controller
                                          .mealperday[ind].calories.length;
                                  i++) {
                                optionsStrings.add(controller.mealperday[ind]
                                        .calories[i].calorieValue
                                        .toString() +
                                    ' kcal');

                                options.add(Caloriess(
                                    id: controller
                                        .mealperday[ind].calories[i].id,
                                    value: controller.mealperday[ind]
                                        .calories[i].calorieValue
                                        .toString()));
                              }
                              setState(() {});
                            }),
                      )
              ],
            )),
        grouval == ind + 1
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Calories'.tr(),
                    style: TextStyle(
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Poppins_Regular
                          : Assets.TheSans_plain,
                      fontSize: MediaQuery.of(context).size.height * 0.019,
                      color: Col.blue,
                    ),
                  ),
                ],
              )
            : Container(),
        grouval == ind + 1
            ? optionsStrings.isEmpty
                ? Container()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .072,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ElasticIn(
                          child: ChipsChoice<int>.single(
                            key: _abcKey,
                            spacing: 12,
                            runSpacing: 12,

                            scrollPhysics: const BouncingScrollPhysics(),
                            scrollToSelectedOnChanged: true,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // wrapped: true,
                            choiceCheckmark: true,
                            choiceStyle: C2ChipStyle.filled(
                                color: Col.lightgrey,
                                selectedStyle: const C2ChipStyle(
                                    foregroundColor: Col.WHITE,
                                    backgroundColor: Col.dullyellow)),
                            value: indexofcalories,
                            onChanged: (val) {
                              setState(() {
                                indexofcalories = val;
                                print(indexofcalories);
                              });
                            },
                            choiceItems: C2Choice.listFrom<int, String>(
                              source: optionsStrings,
                              value: (i, v) => i,
                              label: (i, v) => v,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : Container(),

        // Row(
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: [
        //         selectMeal(
        //           color: Col.lightgrey,
        //           text: 'Lunch',
        //           iconPath: Assets.Lunch_icon_Image,
        //         ),
        //       ],
        //     ),
        //     Radio(
        //         value: 1,
        //         groupValue: grouval,
        //         onChanged: (val) {
        //           setState(() {
        //             grouval = val as int;
        //           });
        //         }),
        //   ],
        // ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          height: 1,
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  AwesomeDialog Infodailog() {
    return AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.info,

      borderSide: const BorderSide(
        color: Col.darkgreen,
        width: 2,
      ),
      width: 400.w,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: 'Message',
      desc: 'Please Select 2 Meals',
      showCloseIcon: false,
      btnCancelText: 'CANCEL',
      btnOkText: 'Ok',
      btnOkColor: Col.darkgreen,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {},
    );
  }
}

class selectMeal extends StatelessWidget {
  String iconPath;
  Color color;
  Color iconcolor;
  String? type;
  String text;
  selectMeal(
      {Key? key,
      required this.color,
      this.type,
      required this.iconcolor,
      required this.iconPath,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Container(
                    color: color,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: type.toString() == 'Svg'
                          ? SvgPicture.network(
                              iconPath,
                              height: 25.w,
                              width: 25.w,
                              color: iconcolor,
                              placeholderBuilder: (context) => SizedBox(
                                  height: 25.w,
                                  width: 25.w,
                                  child: const LoadingWidget(
                                    isImage: true,
                                  )),
                            )
                          : Image.asset(
                              iconPath,
                              height: 25.0.w,
                              width: 25.0.w,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: Get.locale.toString() == 'en'
                            ? MediaQuery.of(context).size.width * .03
                            : 0,
                        left: Get.locale.toString() == 'ar'
                            ? MediaQuery.of(context).size.width * .03
                            : 0),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Poppins_Regular
                            : Assets.TheSans_plain,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

class DietCardPlan1 extends StatefulWidget {
  String? days;
  String? rupees;
  DietCardPlan1({this.days, this.rupees});

  @override
  _DietCardPlan1State createState() => _DietCardPlan1State();
}

class _DietCardPlan1State extends State<DietCardPlan1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en' ? 20 : 0,
                  right: Get.locale.toString() == 'ar' ? 20 : 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Keto",
                    style: TextStyle(
                      color: Col.WHITE,
                      fontSize: MediaQuery.of(context).size.height * 0.06,
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Poppins_Bold
                          : Assets.TheSans_Bold,
                    ),
                  ),
                  Text(
                    "Full  Day",
                    style: TextStyle(
                      color: Col.WHITE.withOpacity(0.5),
                      letterSpacing: 4.0,
                      fontSize: MediaQuery.of(context).size.height * 0.019,
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Poppins_Bold
                          : Assets.TheSans_Bold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        Assets.Calendar_Image,
                        height: MediaQuery.of(context).size.height * 0.028,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.days.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Col.WHITE,
                          fontSize: MediaQuery.of(context).size.height * 0.032,
                          fontFamily: Assets.Product_Sans_Bold,
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
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.rupees.toString(),
                  style: TextStyle(
                    color: Col.dullyellow,
                    fontSize: MediaQuery.of(context).size.height * 0.068,
                    fontWeight: FontWeight.bold,
                    fontFamily: Get.locale.toString() == 'en'
                        ? Assets.Poppins_Bold
                        : Assets.TheSans_Bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.06),
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Positioned(
                        top: -(MediaQuery.of(context).size.height * 0.023),
                        child: Text(
                          "SAR",
                          style: TextStyle(
                            color: Col.WHITE,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Poppins_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DietCardPlan2 extends StatefulWidget {
  String? days;
  String? rupees;
  DietCardPlan2({this.days, this.rupees});

  @override
  _DietCardPlan2State createState() => _DietCardPlan2State();
}

class _DietCardPlan2State extends State<DietCardPlan2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          image: DecorationImage(
            image: AssetImage(
              Assets.ChoosePlan_Image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(left: 20,top:20),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Keto",
        //             style: TextStyle(
        //               color: Col.WHITE,
        //               fontSize:MediaQuery.of(context).size.height * 0.15,
        //               fontFamily:Assets.Poppins_Bold,
        //             ),
        //           ),
        //           Stack(
        //                                fit: StackFit.passthrough,

        //             children: [
        //               Positioned(
        //                 top:-(MediaQuery.of(context).size.height * 0.06),
        //                 child: Text(
        //                   "Full  Day",
        //                   style: TextStyle(
        //                     color: Col.WHITE.withOpacity(0.5),
        //                     letterSpacing: 4.0,
        //                     fontSize: MediaQuery.of(context).size.height * 0.04,
        //                     fontFamily: Assets.Poppins_Bold,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //               Row(
        //                 children: [
        //                   Image.asset(
        //                     Assets.Calendar_Image,
        //                     height:  MediaQuery.of(context).size.height * 0.1,
        //                     fit: BoxFit.fill,
        //                   ),
        //                   Text(
        //                     " ${widget.days} Days",
        //                     textAlign: TextAlign.start,
        //                     style: TextStyle(
        //                       color: Col.WHITE,
        //                       fontSize: MediaQuery.of(context).size.height * 0.1,
        //                       fontFamily: Assets.Poppins_Bold,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment:CrossAxisAlignment.end,
        //         children:[
        //           Text(
        //             "${widget.rupees}",
        //             style: TextStyle(
        //               color: Col.green,
        //               fontSize: MediaQuery.of(context).size.height * 0.2,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
        //             child: Stack(
        //                                  fit: StackFit.passthrough,

        //               children: [
        //                 Positioned(
        //                   top:-(MediaQuery.of(context).size.height * 0.04),
        //                   child: Text(
        //                     "SAR",
        //                     style: TextStyle(
        //                       color: Col.WHITE,
        //                       fontSize: MediaQuery.of(context).size.height * 0.06,
        //                       fontFamily: Assets.Poppins_Bold,
        //                     ),
        //                   ),
        //                 ),
        //                 Container(),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
