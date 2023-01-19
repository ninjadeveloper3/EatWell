import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Login&SignIn/loginSignp_Controller.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool timeoutReached = false;
  bool showpass1 = true;
  bool showpass2 = true;
  bool isemailvalidate = false;
  late int timeout;
  bool showtimer = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginSignUpController controller = Get.find<LoginSignUpController>();

  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController newpassward = TextEditingController();
  TextEditingController confirmpassward = TextEditingController();
  final CountdownController timercontroller =
      CountdownController(autoStart: true);

  // CountDownTimeController timercontroller = CountDownTimeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.Sign_Bg_image,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Col.WHITE,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55),
                          topLeft: Radius.circular(55),
                        ),
                      ),
                      child: FadeInUp(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(55),
                            topLeft: Radius.circular(55),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 41,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Forgot Password".tr(),
                                      style: TextStyle(
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold,
                                        color: Col.blue,
                                        fontSize: 33,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 22),
                                //   child: Wrap(
                                //     children: const [
                                //       Text(
                                //         "Enter the Verification Code we sent to your email",
                                //         textAlign: TextAlign.center,
                                //         style: TextStyle(
                                //             fontSize: 20,
                                //             fontFamily:
                                //                 Assets.Product_Sans_Regular),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 70,
                                // ),
                                FormUi(),
                                const SizedBox(
                                  height: 70,
                                ),
                                Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  decoration: const BoxDecoration(
                                    color: Col.darkgreen,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      checkvalidation();
                                    },
                                    child: Text(
                                      "Submit".tr(),
                                      style: TextStyle(
                                        color: Col.WHITE,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Regular
                                                : Assets.TheSans_plain,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 37,
                                ),
                                Visibility(
                                  visible: timeoutReached,
                                  child: InkWell(
                                    onTap: () {
                                      // controller.resendOtp().then((value) {
                                      //   if (value) {
                                      //     setState(() {
                                      //       otp.clear();
                                      //       timeoutReached = false;
                                      //       timercontroller.startTimer(
                                      //           int.parse(controller.expiryTime
                                      //               .toString()));

                                      //       OtpDailog();
                                      //     });
                                      //   }
                                      // });
                                    },
                                    child: Text(
                                      "Resend Code".tr(),
                                      style: TextStyle(
                                        color: Col.blue,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            )));
  }

  Column FormUi() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.locale.toString() == 'en' ? 35 : 0,
              right: Get.locale.toString() == 'ar' ? 35 : 0),
          child: Row(
            children: [
              Text(
                "Email Address".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 13.3,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: TextFormField(
              autofocus: true,
              // focusNode: focusNode,
              controller: email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (val) {
                Pattern pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = RegExp(pattern.toString());

                if (val == null || val.toString() == '') {
                  isemailvalidate = false;
                  return 'Please enter email'.tr();
                } else if (!regex.hasMatch(val)) {
                  isemailvalidate = false;

                  return "Enter valid email".tr();
                } else {
                  isemailvalidate = true;

                  return null;
                }
              },
              onChanged: (value) {
                _formKey.currentState!.validate();
                setState(() {});
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                fillColor: Col.lightgrey,
                filled: true,

                suffixIcon: controller.emailController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          controller.emailController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      )
                    : null,

                // enabledBorder: InputBorder.none,
                // border: InputBorder.none,
                hintText: "info@eatwell.com",
                contentPadding: EdgeInsets.fromLTRB(
                    Get.locale.toString() == 'ar' ? 0 : 18,
                    12,
                    Get.locale.toString() == 'en' ? 0 : 18,
                    15.7),
                hintStyle: TextStyle(
                  color: Col.grey,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Regular
                      : Assets.TheSans_plain,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        isemailvalidate
            ? Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        showtimer
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  controller
                                      .requestotp(context, email.text)
                                      .then((value) {
                                    if (value) {
                                      setState(() {
                                        showtimer = true;

                                        timeout = int.parse(controller
                                            .expiryTimeOfResetPassword
                                            .toString());

                                        timercontroller.restart();
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Request Otp'.tr(),
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Regular
                                                : Assets.TheSans_plain,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Icon(
                                      Icons.arrow_circle_right_outlined,
                                      color: Col.blue,
                                    )
                                  ],
                                ),
                              ),
                        showtimer
                            ? Countdown(
                                controller: timercontroller,
                                seconds: timeout,
                                build: (_, double time) => Text(
                                  'expires in : $time',
                                  style: const TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  setState(() {
                                    showtimer = false;
                                  });
                                },
                              )
                            // CountDownTime(
                            //     controller: timercontroller,
                            //     textStyle: const TextStyle(fontSize: 18),
                            //     timeStartInSeconds: timeout,
                            //     onChangeTime: (time) {},
                            //     onTimeOut: () {
                            //       setState(() {
                            //         showtimer = false;
                            //         timeoutReached = true;
                            //       });
                            //     },
                            //   )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              )
            : const Text(''),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en' ? 35 : 20,
                  right: Get.locale.toString() == 'ar' ? 35 : 20),
              child: Text(
                "Enter Otp".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 13.3,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.82,
              child: PinCodeTextField(
                // controller: passwordTextEditingController,
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                animationType: AnimationType.fade,

                enableActiveFill: true,
                keyboardType: TextInputType.number,
                textStyle: const TextStyle(
                  color: Col.black,
                ),
                pastedTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 0,
                  ),
                ],
                appContext: context,
                length: 4,
                onChanged: (value) {
                  otp.text = value;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 60,
                  selectedColor: Colors.transparent,
                  activeColor: Colors.transparent,
                  disabledColor: Colors.transparent,
                  inactiveFillColor: Col.lightgrey,
                  activeFillColor: Col.lightgrey,
                  inactiveColor: Col.lightgrey,
                  selectedFillColor: Col.lightgrey,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en' ? 35 : 20,
                  right: Get.locale.toString() == 'ar' ? 35 : 20),
              child: Text(
                "Enter New Password".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 13.3,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: showpass1,
            controller: newpassward,
            validator: (val) {
              if (val == null || val.toString() == '') {
                return 'Please enter password'.tr();
              } else if (val.length < 5) {
                return 'Password must be more than 4 characters'.tr();
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Col.lightgrey,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  showpass1 = !showpass1;
                  setState(() {});
                },
                icon: !showpass1
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              hintText: "............",
              contentPadding: EdgeInsets.fromLTRB(
                  Get.locale.toString() == 'ar' ? 0 : 18,
                  12,
                  Get.locale.toString() == 'en' ? 0 : 18,
                  15.7),
              hintStyle: TextStyle(
                color: Col.grey,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en' ? 35 : 20,
                  right: Get.locale.toString() == 'ar' ? 35 : 20),
              child: Text(
                "Confirm Password".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 13.3,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: showpass2,
            controller: confirmpassward,
            validator: (val) {
              if (val == null || val.toString() == '') {
                return 'Please enter password'.tr();
              } else if (val.length < 5) {
                return 'Password must be more than 4 characters'.tr();
              } else {
                return null;
              }
            },
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: Col.lightgrey,
              filled: true,
              suffixIcon: IconButton(
                onPressed: () {
                  showpass2 = !showpass2;
                  setState(() {});
                },
                icon: !showpass2
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              ),
              hintText: "............",
              contentPadding: EdgeInsets.fromLTRB(
                  Get.locale.toString() == 'ar' ? 0 : 18,
                  12,
                  Get.locale.toString() == 'en' ? 0 : 18,
                  15.7),
              hintStyle: TextStyle(
                color: Col.grey,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void checkvalidation() {
    if (otp.text.toString() == '') {
      flutterToast('please enter otp'.tr());
    } else if (otp.text.length < 4) {
      flutterToast('please enter complete otp'.tr());
    } else if (newpassward.text == '') {
      flutterToast('please enter password'.tr());
    } else if (newpassward.text.length < 4) {
      flutterToast('password must be atleast 4 characters'.tr());
    } else if (newpassward.text.toString() != confirmpassward.text.toString()) {
      flutterToast('confirm password must be same as new password'.tr());
    } else {
      Map<String, dynamic> params = {
        "email": email.text,
        "otp": otp.text,
        "password": newpassward.text
      };
      controller.resetpassword(params).then((value) {
        if (value) {
          flutterToast('password changed successfully'.tr());
          Get.back();
        }
      });
    }
  }
}
