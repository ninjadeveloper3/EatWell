import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Dashboard/Settings/SettingPages.dart/Change_Language/changelangController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({Key? key}) : super(key: key);

  @override
  State<LanguageSetting> createState() => _LanguageSettingState();
}

class _LanguageSettingState extends State<LanguageSetting> {
  LanguageSettingController controller = Get.find<LanguageSettingController>();
  InitialStatusController homcon = Get.find<InitialStatusController>();
  var box = GetStorage();

  @override
  void dispose() {
    Get.delete<LanguageSettingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Appbar(
              context: context,
              title: 'CHANGE LANGUAGE',
            )),
        body: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Stack(
              children: [
                ListView(
                  children: controller.Languages.keys.map((String key) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          // tristate: true,
                          //  checkboxShape: OutlinedBorder,
                          title: Text(
                            key == 'Arabic' ? 'العربيه' : key,
                            style: TextStyle(
                                fontSize: 11.h,
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold),
                          ),
                          value: controller.Languages[key],
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0))), // Rounded Checkbox

                          activeColor: Col.darkgreen,
                          onChanged: (value) {
                            controller.Languages.updateAll(
                                (name, value) => value = false);
                            controller.Languages[key] = value!;
                            controller.selectedlang(key);
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                ),
                Positioned(
                  bottom: 100.h,
                  right: 20,
                  left: 20,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // backgroundColor: Col.darkgreen,
                          side: const BorderSide(
                        color: Col.darkgreen,
                        width: 1.0,
                      )),
                      onPressed: () {
                        switch (controller.selectedlang.value) {
                          case 'English':
                            {
                              context.setLocale(const Locale('en'));

                              Get.updateLocale(const Locale('en'));
                              controller.currentlanguage('en');
                              homcon.currentlanguage('en');
                              box.write('locale', 'en');
                            }
                            break;

                          case 'Urdu':
                            context.setLocale(const Locale('ur'));
                            {
                              Get.updateLocale(const Locale('ur'));
                              controller.currentlanguage('ur');
                              homcon.currentlanguage('ur');
                            }
                            break;
                          case 'Bangla':
                            {
                              context.setLocale(const Locale('bn'));

                              Get.updateLocale(const Locale('bn'));
                              controller.currentlanguage('bn');
                              homcon.currentlanguage('bn');
                            }
                            break;
                          case 'Hindi':
                            {
                              context.setLocale(const Locale('hi'));

                              Get.updateLocale(const Locale('hi'));
                              controller.currentlanguage('hi');
                              homcon.currentlanguage('hi');
                            }
                            break;
                          case 'Arabic':
                            {
                              context.setLocale(const Locale('ar'));

                              Get.updateLocale(const Locale('ar'));
                              controller.currentlanguage('ar');
                              homcon.currentlanguage('ar');
                              box.write('locale', 'ar');
                            }
                            break;
                          default:
                            context.setLocale(const Locale('en'));
                            {
                              Get.updateLocale(const Locale('en'));
                              controller.currentlanguage('en');
                              homcon.currentlanguage('en');
                            }
                            break;
                        }
                        Navigator.pop(context);
                        //       //
                      },
                      child: SizedBox(
                        height: 35.h,
                        width: 300.w,
                        child: Center(
                          child: Text(
                            'Confirm'.tr(),
                            style: TextStyle(
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ));
    //  Obx(
    //   () => (Column(
    //     children: [
    //       SizedBox(
    //         height: 80.h,
    //       ),

    //       ListView(
    //         children: controller.Languages.keys.map((String key) {
    //           return CheckboxListTile(
    //             title: Text(key),
    //             value: controller.Languages[key],
    //             onChanged: (value) {
    //               controller.Languages[key] = value!;
    //             },
    //             controlAffinity: ListTileControlAffinity.leading,
    //           );
    //         }).toList(),
    //       ),
    //       // Row(
    //       //   mainAxisAlignment: MainAxisAlignment.center,
    //       //   children: const [
    //       //     SizedBox(
    //       //         height: 120,
    //       //         child: FadeAnimation(
    //       //           duration: Duration(milliseconds: 1250),
    //       //           child: ScaleAnimation(
    //       //             intervalStart: 0.4,
    //       //             duration: Duration(milliseconds: 1250),
    //       //             child: Image(
    //       //               image: AssetImage(
    //       //                 'assets/img/languagesetting.png',
    //       //               ),
    //       //             ),
    //       //           ),
    //       //         )),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: 30.h,
    //       // ),
    //       // Text('Language Setting'.tr()),
    //       // SizedBox(
    //       //   height: 30.h,
    //       // ),
    //       // Padding(
    //       //   padding: EdgeInsets.symmetric(horizontal: 15.h),
    //       //   child: Column(
    //       //     children: [
    //       //       Row(
    //       //         children: [
    //       //           Text(
    //       //             'Select App Language'.tr(),
    //       //             style: const TextStyle(
    //       //                 fontSize: 12, color: lighttextColor),
    //       //           ),
    //       //         ],
    //       //       ),
    //       //       SizedBox(
    //       //         height: 10.h,
    //       //       ),
    //       //       ElevatedButton(
    //       //           onPressed: () {
    //       //             context.locale = const Locale('en');
    //       //             Get.updateLocale(const Locale('en'));
    //       //             controller.currentlanguage('en');
    //       //             homcon.currentlanguage('en');
    //       //           },
    //       //           style: ElevatedButton.styleFrom(
    //       //               primary: controller.currentlanguage.value == 'en'
    //       //                   ? primaryColor
    //       //                   : lighttextColor,
    //       //               side: const BorderSide(
    //       //                 color: secondaryColor,
    //       //                 width: 1.0,
    //       //               )),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.center,
    //       //             children: [
    //       //               SizedBox(
    //       //                 height: 30.h,
    //       //                 width: 200.w,
    //       //                 child: Row(
    //       //                   mainAxisAlignment: MainAxisAlignment.center,
    //       //                   children: const [
    //       //                     Image(
    //       //                       image: AssetImage(
    //       //                         'assets/img/us.png',
    //       //                       ),
    //       //                       height: 20,
    //       //                     ),
    //       //                     SizedBox(
    //       //                       width: 10,
    //       //                     ),
    //       //                     Text('English'),
    //       //                   ],
    //       //                 ),
    //       //               ),
    //       //             ],
    //       //           )),
    //       //       SizedBox(
    //       //         height: 10.h,
    //       //       ),
    //       //       ElevatedButton(
    //       //           onPressed: () {
    //       //             context.locale = const Locale('ar');
    //       //             Get.updateLocale(const Locale('ar'));
    //       //             controller.currentlanguage('ar');
    //       //             homcon.currentlanguage('ar');
    //       //           },
    //       //           style: ElevatedButton.styleFrom(
    //       //               primary: controller.currentlanguage.value == 'ar'
    //       //                   ? primaryColor
    //       //                   : lighttextColor,
    //       //               side: const BorderSide(
    //       //                 color: secondaryColor,
    //       //                 width: 1.0,
    //       //               )),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.center,
    //       //             children: [
    //       //               SizedBox(
    //       //                 height: 30.h,
    //       //                 width: 200.w,
    //       //                 child: Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.center,
    //       //                     children: const [
    //       //                       Image(
    //       //                         image: AssetImage(
    //       //                           'assets/img/qatar.png',
    //       //                         ),
    //       //                         height: 20,
    //       //                       ),
    //       //                       SizedBox(
    //       //                         width: 10,
    //       //                       ),
    //       //                       Text('عربي'),
    //       //                     ]),
    //       //               ),
    //       //             ],
    //       //           )),
    //       //       SizedBox(
    //       //         height: 10.h,
    //       //       ),
    //       //       ElevatedButton(
    //       //           onPressed: () {
    //       //             context.locale = const Locale('bn');
    //       //             Get.updateLocale(const Locale('bn'));
    //       //             controller.currentlanguage('bn');
    //       //             homcon.currentlanguage('bn');
    //       //           },
    //       //           style: ElevatedButton.styleFrom(
    //       //               primary: controller.currentlanguage.value == 'bn'
    //       //                   ? primaryColor
    //       //                   : lighttextColor,
    //       //               side: const BorderSide(
    //       //                 color: secondaryColor,
    //       //                 width: 1.0,
    //       //               )),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.center,
    //       //             children: [
    //       //               SizedBox(
    //       //                 height: 30.h,
    //       //                 width: 200.w,
    //       //                 child: Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.center,
    //       //                     children: const [
    //       //                       Image(
    //       //                         image: AssetImage(
    //       //                           'assets/img/bangla.png',
    //       //                         ),
    //       //                         height: 20,
    //       //                       ),
    //       //                       SizedBox(
    //       //                         width: 10,
    //       //                       ),
    //       //                       Text('বাংলা'),
    //       //                     ]),
    //       //               ),
    //       //             ],
    //       //           )),
    //       //       SizedBox(
    //       //         height: 10.h,
    //       //       ),
    //       //       ElevatedButton(
    //       //           onPressed: () {
    //       //             context.locale = const Locale('ur');
    //       //             Get.updateLocale(const Locale('ur'));
    //       //             controller.currentlanguage('ur');
    //       //             homcon.currentlanguage('ur');
    //       //           },
    //       //           style: ElevatedButton.styleFrom(
    //       //               primary: controller.currentlanguage.value == 'ur'
    //       //                   ? primaryColor
    //       //                   : lighttextColor,
    //       //               side: const BorderSide(
    //       //                 color: secondaryColor,
    //       //                 width: 1.0,
    //       //               )),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.center,
    //       //             children: [
    //       //               SizedBox(
    //       //                 height: 30.h,
    //       //                 width: 200.w,
    //       //                 child: Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.center,
    //       //                     children: const [
    //       //                       Image(
    //       //                         image: AssetImage(
    //       //                           'assets/img/pk.png',
    //       //                         ),
    //       //                         height: 20,
    //       //                       ),
    //       //                       SizedBox(
    //       //                         width: 10,
    //       //                       ),
    //       //                       Text('اردو'),
    //       //                     ]),
    //       //               ),
    //       //             ],
    //       //           )),
    //       //       SizedBox(
    //       //         height: 10.h,
    //       //       ),
    //       //       ElevatedButton(
    //       //           onPressed: () {
    //       //             context.locale = const Locale('hi');
    //       //             Get.updateLocale(const Locale('hi'));
    //       //             controller.currentlanguage('hi');
    //       //             homcon.currentlanguage('hi');
    //       //           },
    //       //           style: ElevatedButton.styleFrom(
    //       //               primary: controller.currentlanguage.value == 'hi'
    //       //                   ? primaryColor
    //       //                   : lighttextColor,
    //       //               side: const BorderSide(
    //       //                 color: secondaryColor,
    //       //                 width: 1.0,
    //       //               )),
    //       //           child: Row(
    //       //             mainAxisAlignment: MainAxisAlignment.center,
    //       //             children: [
    //       //               SizedBox(
    //       //                 height: 30.h,
    //       //                 width: 200.w,
    //       //                 child: Row(
    //       //                     mainAxisAlignment: MainAxisAlignment.center,
    //       //                     children: const [
    //       //                       Image(
    //       //                         image: AssetImage(
    //       //                           'assets/img/indian.png',
    //       //                         ),
    //       //                         height: 20,
    //       //                       ),
    //       //                       SizedBox(
    //       //                         width: 10,
    //       //                       ),
    //       //                       Text('हिन्दी'),
    //       //                     ]),
    //       //               ),
    //       //             ],
    //       //           )),
    //       // ],
    //       // ),
    //       // )
    //     ],
    //   )),
    // ));
  }
}
