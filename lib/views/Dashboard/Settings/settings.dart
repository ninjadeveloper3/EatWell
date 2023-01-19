// ignore_for_file: must_be_immutable

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/Change_Language/ChangeLanguage.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/Change_Language/changelangController.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/Profilepage.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/privacyPolicy.dart';
import 'package:eat_well/views/Dashboard/Settings/termsAndCondition.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);
  InitialStatusController controller = Get.find<InitialStatusController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Appbar(
              context: context,
              title: 'SETTINGS',
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
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .088,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const ProfilePage(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: settingsContainer(
                          context, 'assets/svg/Profile.svg', 'Profile'.tr()),
                    ),
                    InkWell(
                      onTap: () {
                        Get.put(LanguageSettingController());
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const LanguageSetting(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: settingsContainer(
                          context,
                          'assets/svg/Change Language.svg',
                          'Change Language'.tr()),
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PrivacyPolicyPage(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: settingsContainer(
                          context,
                          'assets/svg/Privacy Policy.svg',
                          'Privacy Policy'.tr()),
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: TermsAndConditionPage(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: settingsContainer(
                          context,
                          'assets/svg/Terms & Conditions.svg',
                          'Terms & Conditions'.tr()),
                    ),
                    InkWell(
                      onTap: () {
                        controller.logout();
                      },
                      child: settingsContainer(
                          context, 'assets/svg/Logout.svg', 'Logout'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Padding settingsContainer(BuildContext context, String svg, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .01),
      child: Container(
        height: MediaQuery.of(context).size.height * .08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Col.lightgrey,
        ),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .04,
            ),
            SvgPicture.asset(
              svg,
              height: MediaQuery.of(context).size.width * .10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .04,
            ),
            Text(
              text,
              style: TextStyle(
                color: Col.black,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
