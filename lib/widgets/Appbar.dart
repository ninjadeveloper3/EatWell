// ignore_for_file: depend_on_referenced_packages, library_prefixes

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:eat_well/widgets/infoDailog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'dart:ui' as UI;

class Appbar extends StatelessWidget {
  BuildContext context;
  String title;
  String? lighttitle;
  Appbar(
      {Key? key, this.lighttitle, required this.title, required this.context})
      : super(key: key);
  InitialStatusController controller = Get.find<InitialStatusController>();
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.amber,
        image: DecorationImage(
          image: AssetImage(
            Assets.BgKito_Image,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height * .08,
          decoration: const BoxDecoration(
            // color: Colors.amber,
            image: DecorationImage(
              image: AssetImage(
                Assets.BgKito_Image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                // top: Platform.isIOS
                //     ? MediaQuery.of(context).size.width * 0.13
                //     : MediaQuery.of(context).size.width * 0.10,
                // bottom: MediaQuery.of(context).size.width * 0.035,
                // left: MediaQuery.of(context).size.width * 0.06,
                // right: MediaQuery.of(context).size.width * 0.06,
                ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    lighttitle != null && lighttitle != 'hideCart'
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: title.toUpperCase().tr(),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.048,
                                        color: Colors.black,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold)),
                                TextSpan(
                                    text:
                                        ' ${lighttitle.toString().toUpperCase().tr()}',
                                    style: TextStyle(
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Regular
                                          : Assets.TheSans_plain,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.048,
                                      color: Col.black.withOpacity(0.7),
                                    )),
                              ],
                            ),
                          )
                        : Text(title.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.048,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Bold
                                  : Assets.TheSans_Bold,
                              color: Col.black,
                            )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        if (title.toString().toUpperCase() == 'DAILY' ||
                            title.toString().toUpperCase() == 'CART') {
                          if (controller.userExsists.value.toString() ==
                              'Yes') {
                            Get.offAllNamed('/HomeDashboard');
                          } else if (controller.userExsists.value.toString() ==
                              'No') {
                            Get.offAndToNamed('/GuestDashboard');
                            Get.back();
                          }
                        } else {
                          title.toString() == 'DASHBOARD' ||
                                  title.toString().toUpperCase() ==
                                      'SETTINGS' ||
                                  title.toString().toUpperCase() ==
                                      'ORDER HISTORY'
                              ? null
                              : Navigator.of(context).pop();
                        }
                        // title.toString().toUpperCase() == 'DAILY' ||
                        //         title.toString().toUpperCase() == 'CART'
                        //     ? Get.offAllNamed('/HomeDashboard')
                        //     : Navigator.of(context).pop();s
                      },
                      child: title.toString() == 'DASHBOARD'
                          ? const SizedBox(
                              width: 40,
                              height: 40,
                              // color: Colors.amber,
                            )
                          : SizedBox(
                              width: 40,
                              height: 40,
                              // color: Colors.amber,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        Get.locale.toString() == 'en' ? 12 : 0,
                                    right:
                                        Get.locale.toString() == 'ar' ? 12 : 0),
                                child: Row(
                                  children: [
                                    title.toString().toUpperCase() ==
                                                'SETTINGS' ||
                                            title.toString().toUpperCase() ==
                                                'ORDER HISTORY'
                                        ? Container()
                                        : Get.locale.toString() == 'en'
                                            ? const Icon(
                                                Icons.arrow_back_ios_new)
                                            : const Directionality(
                                                textDirection:
                                                    UI.TextDirection.ltr,
                                                child: Icon(Icons
                                                    .arrow_forward_ios_outlined),
                                              ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    title.toString().toUpperCase() == 'SETTINGS' ||
                            title.toString().toUpperCase() ==
                                "CHANGE LANGUAGE" ||
                            lighttitle.toString() == 'hideCart'
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                          )
                        : Obx(
                            () => InkWell(
                              onTap: () {
                                if (controller.userCartEmpty.value == '1') {
                                  if (controller.userExsists.value.toString() ==
                                      'Yes') {
                                    Get.put(
                                        DailyMealSelectController(Get.find()));
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: SelectDailyMealScreen(),
                                      withNavBar:
                                          true, // OPTIONAL VALUE. True by default.
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.cupertino,
                                    );
                                  } else {
                                    Get.toNamed('/dailymealSelection');
                                  }
                                } else {
                                  InfoDailog(context, 'Your cart is empty');
                                }
                              },
                              child: controller.userCartEmpty.value == '1'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Badge(
                                        position: BadgePosition.bottomEnd(
                                            end: 20, bottom: 10),
                                        animationDuration:
                                            const Duration(milliseconds: 300),
                                        animationType: BadgeAnimationType.slide,
                                        badgeContent: const Text(''),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 22),
                                          child: Image.asset(
                                            Assets.Cart_Image,
                                            height: 25,
                                            color: Col.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22),
                                      child: Image.asset(
                                        Assets.Cart_Image,
                                        height: 25,
                                        color: Col.black,
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
      ),
    );
  }
}
