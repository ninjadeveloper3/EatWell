import 'dart:ui';

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Login&SignIn/loginSignp_Controller.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animate_do/animate_do.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool timeoutReached = false;
  LoginSignUpController controller = Get.find<LoginSignUpController>();

  TextEditingController otp = TextEditingController();
  // CountDownTimeController timercontroller = CountDownTimeController();
  final CountdownController timercontroller =
      CountdownController(autoStart: true);

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      print(Environment.values);
      return OtpDailog();

      // Prints after 1 second.
    });
    timeoutReached = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                                  children: const [
                                    Text(
                                      "Verification",
                                      style: TextStyle(
                                        fontFamily: Assets.Product_Sans_Bold,
                                        color: Col.blue,
                                        fontSize: 33,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 21,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Wrap(
                                    children: const [
                                      Text(
                                        "Enter the Verification Code we sent to your email",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                Assets.Product_Sans_Regular),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 70,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.77,
                                      child: PinCodeTextField(
                                        // controller: passwordTextEditingController,
                                        cursorColor: Colors.black,
                                        animationType: AnimationType.fade,
                                        animationDuration:
                                            const Duration(milliseconds: 100),
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
                                          print(value);
                                          setState(() {
                                            otp.text = value;
                                          });
                                        },
                                        pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                      if (otp.text == '') {
                                        flutterToast('Please enter otp');
                                      } else if (otp.text.length == 4) {
                                        controller.verifyOtp(otp.text);
                                      } else {
                                        flutterToast(
                                            'Please enter complete otp');
                                      }
                                    },
                                    child: const Text(
                                      "Verify",
                                      style: TextStyle(
                                        color: Col.WHITE,
                                        fontFamily: Assets.Product_Sans_Regular,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 37,
                                ),
                                Countdown(
                                  controller: timercontroller,
                                  seconds: int.parse(
                                      controller.expiryTime.toString()),
                                  build: (_, double time) => timeoutReached
                                      ? const Text('')
                                      : Text(
                                          'expires in : $time',
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                  interval: const Duration(seconds: 1),
                                  onFinished: () {
                                    setState(() {
                                      timeoutReached = true;
                                    });
                                  },
                                ),
                                Visibility(
                                  visible: timeoutReached,
                                  child: InkWell(
                                    onTap: () {
                                      controller.resendOtp().then((value) {
                                        if (value) {
                                          setState(() {
                                            otp.clear();
                                            timeoutReached = false;
                                            timercontroller.restart();

                                            OtpDailog();
                                          });
                                        }
                                      });
                                    },
                                    child: const Text(
                                      "Resend Code",
                                      style: TextStyle(
                                        color: Col.blue,
                                        fontFamily: Assets.Product_Sans_Bold,
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

  Future<dynamic> OtpDailog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .32,
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
                      height: MediaQuery.of(context).size.height * .45,
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
                          const Text(
                            "This is Dev Environment Please Copy the Otp",
                            style: TextStyle(
                              fontFamily: Assets.Product_Sans_Bold,
                              fontSize: 25,
                              color: Col.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
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
                                    onPressed: () {},
                                    child: Obx(
                                      (() => Text(
                                            controller.otp.value,
                                            style: const TextStyle(
                                              color: Col.WHITE,
                                              fontFamily:
                                                  Assets.Product_Sans_Regular,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Col.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              controller.otp.value.toString()));
                                      Fluttertoast.showToast(msg: "Otp Copied");
                                    },
                                    child: const Text(
                                      "Copy Code",
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
}
