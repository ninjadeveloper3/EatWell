import 'dart:ui';

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';

class GettingStartedScreen extends StatefulWidget {
  @override
  _GettingStartedScreenState createState() => _GettingStartedScreenState();
}

class _GettingStartedScreenState extends State<GettingStartedScreen> {
  int _CurrentPage = 0;

  _onPageChanged(int index) {
    setState(() {
      _CurrentPage = index;
    });
  }

  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  void initState() {
    controller.checkUserCartforGuest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Col.WHITE,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(
              () => controller.onboardDataList.isEmpty
                  ? const Expanded(child: Center(child: LoadingWidget()))
                  : Column(
                      children: [
                        SizedBox(
                          height: Get.locale.toString() == 'en'
                              ? MediaQuery.of(context).size.height * 0.07
                              : MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          "Find Your Goal".tr(),
                          style: TextStyle(
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Col.blue,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "We have heathy diet plans and much".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            color: Col.grey,
                          ),
                        ),
                        Text(
                          "more for you.".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            color: Col.grey,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            // color: Colors.amber,
                            width: MediaQuery.of(context).size.height * 0.5,
                            height: MediaQuery.of(context).size.height * 0.5,
                            // color: Colors.grey,
                            child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.onboardDataList.length,
                                onPageChanged: _onPageChanged,
                                itemBuilder: (context, index) {
                                  return SlideItem(index, controller);
                                }),
                          ),
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.03,
                        // ),

                        //Arrow

                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),

                        //dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int i = 0;
                                i < controller.onboardDataList.length;
                                i++)
                              if (i == _CurrentPage)
                                SlideDots(true)
                              else
                                SlideDots(false),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Col.darkgreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed('/SignUp', arguments: [
                                    {'isSignin': true, 'guestpopup': false}
                                  ]);
                                },
                                child: Text(
                                  "SIGN IN".tr(),
                                  style: TextStyle(
                                    color: Col.WHITE.withOpacity(0.8),
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Regular
                                        : Assets.TheSans_plain,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.7,
                                    // MediaQuery.of(context).size.height * 0.025
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 50,
                              width: 150,
                              // width: MediaQuery.of(context).size.width * 0.4,
                              decoration: const BoxDecoration(
                                color: Col.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Get.toNamed('/SignUp', arguments: [
                                    {'isSignin': false, "guestpopup": false}
                                  ]);
                                },
                                child: Text(
                                  "SIGN UP".tr(),
                                  style: TextStyle(
                                    color: Col.WHITE.withOpacity(0.8),
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Regular
                                        : Assets.TheSans_plain,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15.7,
                                    // MediaQuery.of(context).size.height * 0.025
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),

      // OrientationBuilder(
      //   builder: (context, orientation) {
      //     if (orientation == Orientation.portrait) {
      //       return
      //        Scaffold(
      //         body: Container(
      //           color: Col.WHITE,
      //           child: SafeArea(
      //             child: Column(
      //               children: [
      //                 const SizedBox(
      //                   height: 20,
      //                 ),
      //                 Text(
      //                   "Find Your Goal",
      //                   style: TextStyle(
      //                     fontFamily: Assets.Product_Sans_Bold,
      //                     fontSize: MediaQuery.of(context).size.height * 0.04,
      //                     fontWeight: FontWeight.bold,
      //                     color: Col.blue,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: MediaQuery.of(context).size.height * 0.01,
      //                 ),
      //                 Text(
      //                   "We have heathy diet plans and much",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontFamily: Assets.Product_Sans_Bold,
      //                     fontSize: MediaQuery.of(context).size.height * 0.02,
      //                     color: Col.grey,
      //                   ),
      //                 ),
      //                 Text(
      //                   "more for you.",
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontFamily: Assets.Product_Sans_Bold,
      //                     fontSize: MediaQuery.of(context).size.height * 0.02,
      //                     color: Col.grey,
      //                   ),
      //                 ),
      //                 SizedBox(
      //                     height: MediaQuery.of(context).size.height * 0.03),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 20, right: 20),
      //                   child: SizedBox(
      //                     height: MediaQuery.of(context).size.height * 0.5,
      //                     // color: Colors.grey,
      //                     child: PageView.builder(
      //                         itemCount: controller.onboardDataList.length,
      //                         onPageChanged: _onPageChanged,
      //                         itemBuilder: (context, index) {
      //                           return SlideItem(index, controller);
      //                         }),
      //                   ),
      //                 ),
      //                 // SizedBox(
      //                 //   height: MediaQuery.of(context).size.height * 0.03,
      //                 // ),

      //                 //Arrow
      //                 _CurrentPage >= 2
      //                     ? SizedBox(
      //                         height: MediaQuery.of(context).size.height * 0.01,
      //                       )
      //                     : const SizedBox(
      //                         height: 0,
      //                       ),

      //                 SizedBox(
      //                   height: MediaQuery.of(context).size.height * 0.05,
      //                 ),

      //                 //dots
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: <Widget>[
      //                     for (int i = 0; i < 4; i++)
      //                       if (i == _CurrentPage)
      //                         SlideDots(true)
      //                       else
      //                         SlideDots(false),
      //                   ],
      //                 ),
      //                 SizedBox(
      //                   height: MediaQuery.of(context).size.height * 0.08,
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Container(
      //                       height: 50,
      //                       width: 150,
      //                       decoration: const BoxDecoration(
      //                         color: Col.darkgreen,
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(8),
      //                         ),
      //                       ),
      //                       child: TextButton(
      //                         onPressed: () {},
      //                         child: Text(
      //                           "SIGN IN",
      //                           style: TextStyle(
      //                             color: Col.WHITE.withOpacity(0.8),
      //                             fontFamily: Assets.Product_Sans_Regular,
      //                             fontWeight: FontWeight.normal,
      //                             fontSize: 15.7,
      //                             // MediaQuery.of(context).size.height * 0.025
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       width: 10,
      //                     ),
      //                     Container(
      //                       height: 50,
      //                       width: 150,
      //                       // width: MediaQuery.of(context).size.width * 0.4,
      //                       decoration: const BoxDecoration(
      //                         color: Col.blue,
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(8),
      //                         ),
      //                       ),
      //                       child: TextButton(
      //                         onPressed: () {
      //                           Get.toNamed('/SignUp');
      //                         },
      //                         child: Text(
      //                           "SIGN UP",
      //                           style: TextStyle(
      //                             color: Col.WHITE.withOpacity(0.8),
      //                             fontFamily: Assets.Product_Sans_Regular,
      //                             fontWeight: FontWeight.normal,
      //                             fontSize: 15.7,
      //                             // MediaQuery.of(context).size.height * 0.025
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(
      //                   height: 10,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       );

      //     } else {
      //       return Scaffold(
      //         body: Container(
      //           color: Col.WHITE,
      //           child: SafeArea(
      //             child: SingleChildScrollView(
      //               child: Column(
      //                 children: [
      //                   const SizedBox(
      //                     height: 20,
      //                   ),
      //                   Text(
      //                     "Find Your Goal",
      //                     style: TextStyle(
      //                       fontFamily: Assets.Product_Sans_Bold,
      //                       fontSize: MediaQuery.of(context).size.width * 0.04,
      //                       fontWeight: FontWeight.bold,
      //                       color: Col.blue,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     height: MediaQuery.of(context).size.width * 0.01,
      //                   ),
      //                   Text(
      //                     "We have heathy diet plans and much",
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       fontFamily: Assets.Product_Sans_Bold,
      //                       fontSize: MediaQuery.of(context).size.width * 0.02,
      //                       color: Col.grey,
      //                     ),
      //                   ),
      //                   Text(
      //                     "more for you.",
      //                     textAlign: TextAlign.center,
      //                     style: TextStyle(
      //                       fontFamily: Assets.Product_Sans_Bold,
      //                       fontSize: MediaQuery.of(context).size.width * 0.02,
      //                       color: Col.grey,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                       height: MediaQuery.of(context).size.width * 0.03),
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 20, right: 20),
      //                     child: SizedBox(
      //                       height: MediaQuery.of(context).size.width * 0.5,
      //                       // color: Colors.grey,
      //                       child: PageView.builder(
      //                           itemCount: controller.onboardDataList.length,
      //                           onPageChanged: _onPageChanged,
      //                           itemBuilder: (context, index) {
      //                             return SlideItem1(index, controller);
      //                           }),
      //                     ),
      //                   ),

      //                   // SizedBox(
      //                   //   height: MediaQuery.of(context).size.width * 0.05,
      //                   // ),

      //                   //dots
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: <Widget>[
      //                       for (int i = 0; i < 4; i++)
      //                         if (i == _CurrentPage)
      //                           SlideDots1(true)
      //                         else
      //                           SlideDots1(false),
      //                     ],
      //                   ),
      //                   SizedBox(
      //                     height: MediaQuery.of(context).size.width * 0.08,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Container(
      //                         height: 50,
      //                         width: 150,
      //                         decoration: const BoxDecoration(
      //                           color: Col.darkgreen,
      //                           borderRadius: BorderRadius.all(
      //                             Radius.circular(8),
      //                           ),
      //                         ),
      //                         child: TextButton(
      //                           onPressed: () {
      //                             Navigator.pushNamed(context, "SignIn");
      //                           },
      //                           child: Text(
      //                             "SIGN IN",
      //                             style: TextStyle(
      //                               color: Col.WHITE.withOpacity(0.8),
      //                               fontFamily: Assets.Product_Sans_Regular,
      //                               fontWeight: FontWeight.normal,
      //                               fontSize: 15.7,
      //                               // MediaQuery.of(context).size.height * 0.025
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       const SizedBox(
      //                         width: 10,
      //                       ),
      //                       Container(
      //                         height: 50,
      //                         width: 150,
      //                         // width: MediaQuery.of(context).size.width * 0.4,
      //                         decoration: const BoxDecoration(
      //                           color: Col.blue,
      //                           borderRadius: BorderRadius.all(
      //                             Radius.circular(8),
      //                           ),
      //                         ),
      //                         child: TextButton(
      //                           onPressed: () {},
      //                           child: Text(
      //                             "SIGN UP",
      //                             style: TextStyle(
      //                               color: Col.WHITE.withOpacity(0.8),
      //                               fontFamily: Assets.Product_Sans_Regular,
      //                               fontWeight: FontWeight.normal,
      //                               fontSize: 15.7,
      //                               // MediaQuery.of(context).size.height * 0.025
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         ),
      //       );
      //     }
      //   },
      // ),
    );
  }
}

// landscpace mode
class SlideItem1 extends StatelessWidget {
  final int index;
  InitialStatusController controller;
  SlideItem1(this.index, this.controller);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.65,
          child: CachedNetworkImage(
            imageUrl:
                '${EnvironmentConstants.baseUrl}/${controller.onboardDataList[index].image}',
            imageBuilder: (context, imageProvider) => Container(
              height: MediaQuery.of(context).size.width * 0.38,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,

                  // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                  // )
                ),
              ),
            ),
            placeholder: (context, url) => const LoadingWidget(
              isImage: true,
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Col.blue,
            ),
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.width * 0.38,
            // height:
            //     100,
          ),
        ),
        // index <=1?

        const SizedBox(
          height: 20,
        ),
        Text(
          controller.onboardDataList[index].name.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Get.locale.toString() == 'en'
                ? Assets.Product_Sans_Bold
                : Assets.TheSans_Bold,
            fontSize: MediaQuery.of(context).size.width * 0.03, //23.3,
            color: Col.blue,
          ),
        ),
      ],
    );
    // return Column(
    //   children: [
    //     index <=1? Image.asset(
    //       slideList[index].first_image_url,
    //       fit: BoxFit.cover,
    //       height: 242,
    //     ):Image.asset(
    //       slideList[index].first_image_url,
    //       fit: BoxFit.cover,
    //       height: 242,
    //     ),
    //     SizedBox(
    //       height: 38,
    //     ),
    //     Text(
    //       slideList[index].title,
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontFamily: Assets.Product_Sans_Bold,
    //         fontSize: 23.3,
    //         color: Col.blue,
    //       ),
    //     ),
    //     index<= 1?SizedBox(
    //       height: 36,
    //     ):SizedBox(
    //       height: 21,
    //     ),
    //     InkWell(
    //       onTap: () {
    //         // Navigator.pushNamed(context, "FindYourGoalScreen2");
    //       },
    //       child: Image.asset(
    //         slideList[index].second_image_url,
    //         height: MediaQuery.of(context).size.width * 0.027,
    //       ),
    //     ),
    //
    //   ],
    // );
  }
}

// class SlideDots1 extends StatelessWidget {
//   bool isActive;
//   SlideDots1(this.isActive);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 12,
//             width: 12,
//             decoration: BoxDecoration(
//               color: isActive ? Col.darkgreen : Col.lightgrey,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(40),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//     // return  Padding(
//     //   padding: const EdgeInsets.only(right:6),
//     //   child: Row(
//     //     mainAxisAlignment: MainAxisAlignment.center,
//     //     children: [
//     //       Container(
//     //         height: 20,
//     //         width: 20,
//     //         decoration: BoxDecoration(
//     //           color: isActive? Col.green: Col.grey,
//     //           borderRadius: BorderRadius.all(
//     //             Radius.circular(40),
//     //           ),
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
// }

// Potrait mode

class SlideItem extends StatelessWidget {
  final int index;
  InitialStatusController controller;
  SlideItem(this.index, this.controller);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.30,
          child: CachedNetworkImage(
            imageUrl:
                '${EnvironmentConstants.baseUrl}/${controller.onboardDataList[index].image}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                  // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                  // )
                ),
              ),
            ),
            placeholder: (context, url) => const LoadingWidget(
              isImage: true,
            ),
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
              color: Col.blue,
            ),
            fit: BoxFit.cover,
            // height: MediaQuery.of(context).size.width * 0.38,
            // height:
            //     100,
          ),
        ),

        // index <=1?

        const SizedBox(
          height: 20,
        ),
        SizedBox(
          // color: Colors.amber,
          height: MediaQuery.of(context).size.height * .075,
          child: Text(
            controller.onboardDataList[index].name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Get.locale.toString() == 'en'
                  ? Assets.Product_Sans_Bold
                  : Assets.TheSans_Bold,
              fontSize: MediaQuery.of(context).size.height * 0.026, //23.3,
              color: Col.blue,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            if (controller.userGoal.value.toString() !=
                    controller.onboardDataList[index].id.toString() &&
                controller.userCartEmpty.value == '1') {
              deleteCartPopUp(context);
            } else {
              controller
                  .userGoal(controller.onboardDataList[index].id.toString());
              controller.userselectedgoalDiscription(
                  controller.onboardDataList[index].description.toString());
              controller.userExsists.toString() == 'No' &&
                      controller.userCartEmpty.value == '0'
                  ? Get.toNamed('/caloriesCalculator')
                  // ? Get.toNamed('/GuestDashboard')
                  : Get.offNamed('/GuestDashboard');
            }

            // Get.put(DashboardController(Get.find()));
            // PersistentNavBarNavigator.pushNewScreen(context,
            //     screen: DashBoard());
          },
          child: SizedBox(
            width: 200,
            height: 30,
            // color: Colors.amber,
            child: Image.asset(
              Assets.Nextarrow_Image,
              height: MediaQuery.of(context).size.height * 0.027,
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> deleteCartPopUp(BuildContext context) {
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
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
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
                              "There is already cart in progress do you want to discard it ?"
                                  .tr(),
                              style: TextStyle(
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold,
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

                                    controller.deleteCart(params);
                                    controller.userGoal.value == '';
                                  },
                                  child: Text(
                                    "Yes Discard it".tr(),
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Bold
                                          : Assets.TheSans_Bold,
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
                                    Get.back();
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

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: 12,
            decoration: BoxDecoration(
              color: isActive ? Col.darkgreen : Col.lightgrey,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
