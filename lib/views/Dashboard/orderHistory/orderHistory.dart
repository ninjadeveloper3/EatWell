// ignore_for_file: depend_on_referenced_packages

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/OngoindPlanDashboard.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/onGoingPlanController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OrderHIstory extends StatefulWidget {
  const OrderHIstory({Key? key}) : super(key: key);

  @override
  State<OrderHIstory> createState() => _OrderHIstoryState();
}

class _OrderHIstoryState extends State<OrderHIstory> {
  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  void initState() {
    controller.getOrderHistory();
    super.initState();
  }

  @override
  void dispose() {
    controller.orderHistory.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Appbar(
              context: context,
              title: 'ORDER HISTORY',
              lighttitle: 'hideCart',
            )),
        body: Obx(
          (() => controller.orderHistory.isEmpty &&
                  controller.orderHistoryIsEmpty.value == 'false'
              ? const LoadingWidget()
              : controller.orderHistory.isEmpty &&
                      controller.orderHistoryIsEmpty.value == 'true'
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
                            Text('No Order Found'.tr())
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .088,
                          vertical: 10),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Order History".tr(),
                                  style: TextStyle(
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Bold
                                        : Assets.TheSans_Bold,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Col.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Your Complete Order History".tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Regular
                                        : Assets.TheSans_plain,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                    color: Col.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),

                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return settingsContainer(
                                    context, 'assets/svg/eye.svg', index);
                              }),
                              itemCount: controller.orderHistory.length,
                            )

                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                            // settingsContainer(
                            //     context, 'assets/svg/eye.svg', 'Logout'),
                          ],
                        ),
                      ),
                    )),
        ));
  }

  InkWell settingsContainer(
    BuildContext context,
    String svg,
    int index,
  ) {
    return InkWell(
      highlightColor: Colors.transparent,
      onTap: () {
        Get.put(OngoingPlanController(Get.find()));
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: OngoingPlanDashboardSreen(
            showEdit: false,
            Id: controller.orderHistory[index].id,
          ),
          withNavBar: true, // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .01),
        child: Container(
          height: MediaQuery.of(context).size.height * .08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Col.lightgrey,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width * .38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.locale.toString() == 'en' ? 12 : 0,
                          right: Get.locale.toString() == 'ar' ? 12 : 0),
                      child: Text(
                          '${controller.orderHistory[index].plan.duration} Day Meal Plan',
                          style: TextStyle(
                            color: Col.black,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                            fontSize: 15,
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.locale.toString() == 'en' ? 12 : 0,
                          right: Get.locale.toString() == 'ar' ? 12 : 0),
                      child: Text(
                          controller.orderHistory[index].plan.price.toString() +
                              " " +
                              'SAR',
                          style: TextStyle(
                            color: Col.blue,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Regular
                                : Assets.TheSans_plain,
                            fontSize: 12,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // color: Colors.amber,
                width: MediaQuery.of(context).size.width * .42,
                child: Stack(
                  children: [
                    Get.locale.toString() == 'en'
                        ? Positioned(
                            right: 4,
                            top: 14,
                            child: SvgPicture.asset(
                              svg,
                              height: MediaQuery.of(context).size.width * .10,
                            ),
                          )
                        : Positioned(
                            left: 4,
                            top: 14,
                            child: SvgPicture.asset(
                              svg,
                              height: MediaQuery.of(context).size.width * .10,
                            ),
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.date_range_rounded,
                              color: Col.yellow,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                                DateFormat.yMMMMd().format(DateTime.parse(
                                    controller.orderHistory[index].startDate
                                        .toString())),
                                style: const TextStyle(
                                  color: Col.black,
                                  fontFamily: Assets.Product_Sans_Regular,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * .04,
              // ),
              // SvgPicture.asset(
              //   svg,
              //   height: MediaQuery.of(context).size.width * .10,
              // ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * .04,
              // ),
              // Text(
              //   text,
              //   style: const TextStyle(
              //     color: Col.black,
              //     fontFamily: Assets.Product_Sans_Bold,
              //     fontSize: 15,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
