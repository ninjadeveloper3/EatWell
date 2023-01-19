// ignore_for_file: depend_on_referenced_packages, must_be_immutable, non_constant_identifier_names, unused_field

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/onGoingPlanController.dart';
import 'package:eat_well/views/animations/fade_animation.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eat_well/widgets/datepick.dart';
import 'package:get/get.dart' hide Trans;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class OngoingPlanDashboardSreen extends StatefulWidget {
  bool showEdit;
  int Id;
  OngoingPlanDashboardSreen(
      {Key? key, required this.showEdit, required this.Id})
      : super(key: key);

  @override
  State<OngoingPlanDashboardSreen> createState() =>
      _OngoingPlanDashboardSreenState();
}

class _OngoingPlanDashboardSreenState extends State<OngoingPlanDashboardSreen> {
  final ScrollController _controllerOne = ScrollController();
  final DatePickerController _controller = DatePickerController();
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  OngoingPlanController controller = Get.find<OngoingPlanController>();
  ScrollController scrollcontroller = ScrollController();

  bool showLoading = true;
  late DateTime selectedDate;

  // late DateTime _selectedValue;

  @override
  void initState() {
    selectedDate = DateTime.now();
    controller.getOngoingPlanDetail(id: widget.Id).then((value) {
      if (value) {
        showLoading = false;
        setState(() {});
      }
    });

    // _selectedValue = DateTime.parse('7');

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<OngoingPlanController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(context: context, title: "DASHBOARD")),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.BgDashBoard_Image,
                ),
                fit: BoxFit.cover),
          ),
          child: showLoading
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .70,
                  child: const Center(child: LoadingWidget()))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Col.ksidePadding),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      widget.showEdit
                          ? Column(
                              children: [
                                Container(
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Col.blue,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .06,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6,
                                              decoration: BoxDecoration(
                                                  color: Col.dullyellow,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Text(
                                                        '- - - - - - - - - - - - '),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 7),
                                                    child: SvgPicture.asset(
                                                      Assets.dashboardprogress,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Text('78 %',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.048,
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Bold
                                                        : Assets.TheSans_Bold,
                                                    color: Col.WHITE,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Your Meals Plan Used',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Product_Sans_Regular
                                                  : Assets.TheSans_plain,
                                          color: Col.black,
                                        )),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              '${controller.ongoing!.details[0].planDuration.toString()} Days Meals Plan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.065,
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold,
                                color: Col.blue,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RawScrollbar(
                        controller: scrollcontroller,
                        thumbVisibility: true,
                        thumbColor:
                            initialcon.reviewStatus.value.toString() == '1'
                                ? Col.darkgreen
                                : Col.dullyellow,
                        radius: const Radius.circular(20),
                        thickness: 3,
                        child: Column(
                          children: [
                            FadeAnimation(
                              child: DatePicker(
                                DateTime.parse(
                                    controller.ongoing!.startDate.toString()),
                                locale:
                                    Get.locale.toString() == 'en' ? 'en' : 'ar',
                                width: 60,
                                // showRedColorondates: controller.unselecteddate,
                                height: 100,
                                // selecteddateColor: showselecteddateColor,
                                controller: _controller,
                                initialSelectedDate: selectedDate,
                                selectionColor:
                                    initialcon.reviewStatus.toString() == '1'
                                        ? Col.darkgreen
                                        : Col.dullyellow,
                                selectedTextColor: Colors.white,
                                // daysCount: 7,
                                daysCount: int.parse(controller
                                    .ongoing!.details[0].planDuration
                                    .toString()),

                                scrolcontroller: scrollcontroller,

                                onDateChange: (date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.ongoing?.details.length,
                          itemBuilder: ((context, index) {
                            print(
                                'the matching cal is : ${DateFormat.yMMMMd().format(DateTime.parse(controller.ongoing!.details[index].oliOrderDate.toString()))} and ${DateFormat.yMMMMd().format(DateTime.parse(selectedDate.toString()))}');
                            if (DateFormat.yMMMMd().format(DateTime.parse(
                                    controller
                                        .ongoing!.details[index].oliOrderDate
                                        .toString())) ==
                                DateFormat.yMMMMd().format(
                                    DateTime.parse(selectedDate.toString()))) {
                              return Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .20,
                                    decoration: BoxDecoration(
                                      color: Color((math.Random().nextDouble() *
                                                  0xFFFFFF)
                                              .toInt())
                                          .withOpacity(.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .10,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.10,
                                                child: SvgPicture.network(
                                                  '${EnvironmentConstants.baseUrl}/${controller.ongoing!.details[index].mcImage}',
                                                  height: 35.w,
                                                  width: 35.w,
                                                  color: Col.black,
                                                  placeholderBuilder:
                                                      (context) => SizedBox(
                                                          height: 25.w,
                                                          width: 25.w,
                                                          child:
                                                              const LoadingWidget(
                                                            isImage: true,
                                                          )),
                                                ),
                                              ),
                                              // SvgPicture.asset(
                                              //   Assets.salad_icon,
                                              //   height: MediaQuery.of(context)
                                              //           .size
                                              //           .width *
                                              //       0.12,
                                              //   color: Col.blue,
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .60,
                                          decoration: BoxDecoration(
                                            // color: Colors.pink,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(controller.ongoing!
                                                    .details[index].mcName),
                                                Expanded(
                                                  child: Text(
                                                    'Your meal for ${controller.ongoing!.details[index].mcName} is ${controller.ongoing!.details[index].mealName} for the day ${DateFormat.yMMMMd().format(selectedDate)}',
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis, // new
                                                  ),
                                                ),
                                                const Text('Common Alergies'),
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                        .ongoing!
                                                        .details[index]
                                                        .mealDescription
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 10),
                                                    softWrap: false,
                                                    maxLines: 2,
                                                    overflow: TextOverflow
                                                        .ellipsis, // new
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          }))

                      // Container(
                      //   height: MediaQuery.of(context).size.height * .20,
                      //   decoration: BoxDecoration(
                      //     color: Colors.blue.withOpacity(.2),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   width: double.infinity,
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           // color: Colors.black,
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         width: MediaQuery.of(context).size.height * .10,
                      //         child: Column(
                      //           children: [
                      //             const SizedBox(
                      //               height: 30,
                      //             ),
                      //             SvgPicture.asset(
                      //               Assets.salad_icon,
                      //               height:
                      //                   MediaQuery.of(context).size.width * 0.12,
                      //               color: Col.blue,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         width: MediaQuery.of(context).size.width * .60,
                      //         decoration: BoxDecoration(
                      //           // color: Colors.pink,
                      //           borderRadius: BorderRadius.circular(20),
                      //         ),
                      //         child: Padding(
                      //           padding:
                      //               const EdgeInsets.symmetric(horizontal: 12),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: const [
                      //               SizedBox(
                      //                 height: 20,
                      //               ),
                      //               Text('Breakfast'),
                      //               Expanded(
                      //                 child: Text(
                      //                   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      //                   style: TextStyle(fontSize: 10),
                      //                   softWrap: false,
                      //                   maxLines: 2,
                      //                   overflow: TextOverflow.ellipsis, // new
                      //                 ),
                      //               ),
                      //               Text('Breakfast'),
                      //               Expanded(
                      //                 child: Text(
                      //                   'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                      //                   style: TextStyle(fontSize: 10),
                      //                   softWrap: false,
                      //                   maxLines: 2,
                      //                   overflow: TextOverflow.ellipsis, // new
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
