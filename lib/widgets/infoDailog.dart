import 'dart:ui';

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

// InfoDailog(String Text) {
//   {
//     return AwesomeDialog(
//       context: Get.context!,
//       dialogType: DialogType.info,

//       borderSide: const BorderSide(
//         color: Col.darkgreen,
//         width: 2,
//       ),
//       width: 400.w,
//       buttonsBorderRadius: const BorderRadius.all(
//         Radius.circular(2),
//       ),
//       dismissOnTouchOutside: true,
//       dismissOnBackKeyPress: true,
//       headerAnimationLoop: false,
//       animType: AnimType.bottomSlide,
//       title: 'Message',
//       desc: Text,
//       showCloseIcon: false,
//       btnCancelText: 'CANCEL',
//       btnOkText: 'Ok',
//       btnOkColor: Col.darkgreen,
//       // btnCancelOnPress: () {},
//       btnOkOnPress: () {},
//     ).show();
//   }
// }

Future<dynamic> InfoDailog(BuildContext context, String Message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ElasticIn(
        child: Center(
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
                    height: 220.0,
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
                          style: const TextStyle(
                            fontFamily: Assets.Product_Sans_Bold,
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
                              Message,
                              style: const TextStyle(
                                fontFamily: Assets.Product_Sans_Bold,
                                fontSize: 14,
                                color: Col.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
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
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Assets.Product_Sans_Regular,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         height: 50,
                        //         decoration: const BoxDecoration(
                        //           color: Col.lightgrey,
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10),
                        //           ),
                        //         ),
                        //         child: TextButton(
                        //           onPressed: () {
                        //             Get.toNamed('/dailymealSelection');
                        //           },
                        //           child: const Text(
                        //             "Go to Cart",
                        //             style: TextStyle(
                        //               color: Col.black,
                        //               fontFamily: Assets.Product_Sans_Regular,
                        //               fontWeight: FontWeight.normal,
                        //               fontSize: 14,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      );
    },
  );
}

Future<dynamic> InfoDailogofContactSupport(
  BuildContext context,
  String Message,
) {
  Future<void> _makePhoneCall(String url) async {
    url = "tel:$url";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return ElasticIn(
        child: Center(
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
                    height: 220.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
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
                          style: const TextStyle(
                            fontFamily: Assets.Product_Sans_Bold,
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
                              Message,
                              style: const TextStyle(
                                fontFamily: Assets.Product_Sans_Bold,
                                fontSize: 14,
                                color: Col.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
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
                                    InitialStatusController controller =
                                        Get.find();

                                    _makePhoneCall(
                                        controller.supportCAllphone.value);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Ok",
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Assets.Product_Sans_Regular,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Container(
                        //         height: 50,
                        //         decoration: const BoxDecoration(
                        //           color: Col.lightgrey,
                        //           borderRadius: BorderRadius.all(
                        //             Radius.circular(10),
                        //           ),
                        //         ),
                        //         child: TextButton(
                        //           onPressed: () {
                        //             Get.toNamed('/dailymealSelection');
                        //           },
                        //           child: const Text(
                        //             "Go to Cart",
                        //             style: TextStyle(
                        //               color: Col.black,
                        //               fontFamily: Assets.Product_Sans_Regular,
                        //               fontWeight: FontWeight.normal,
                        //               fontSize: 14,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                      ],
                    ),
                  ),
                ),
              )),
        ),
      );
    },
  );
}
