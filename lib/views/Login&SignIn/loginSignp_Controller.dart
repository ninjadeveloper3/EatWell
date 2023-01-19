// ignore_for_file: file_names, unnecessary_overrides, avoid_print

import 'dart:ui';

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

class LoginSignUpController extends GetxController {
  ApiRepository apiRepository;
  LoginSignUpController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  var expiryTime = ''.obs;
  var expiryTimeOfResetPassword = ''.obs;
  var otp = ''.obs;
  final box = GetStorage();
  var guestpopupvalue = 'no'.obs;
  // var mealData = List<MealItem>.empty(growable: true).obs;

  @override
  void onInit() {
    // getMealItems();
    super.onInit();
  }

  void login(String email, String password, bool guestpopup) async {
    if (guestpopup) {
      guestpopupvalue('yes');
    }
    EasyLoading.show();
    Map<String, dynamic> param = {
      'email': email.toString(),
      'password': password.toString(),
    };
    apiRepository.login(param).getResponse<Response<String>>((response) {
      debugPrint('login data is $response');

      if (response.data['code'].toString() == '200') {
        cLearEvertyThing();

        initialcon.userID(response.data['data']['id'].toString());
        box.write(
            'AccessToken', response.data['data']['accessToken'].toString());
        box.write('GuestID', response.data['data']['accessToken'].toString());
        box.write('UserID', response.data['data']['id'].toString());
        box.write('roleID', response.data['data']['role']['id'].toString());
        box.write('roleName', response.data['data']['role']['name'].toString());
        box.write('fullname', response.data['data']['firstName'].toString());
        box.write('email', response.data['data']['email'].toString());
        box.write(
            'phonenumber', response.data['data']['phoneNumber'].toString());
        initialcon.userExsists('Yes');

        initialcon.initialcheckUserCartData().then((value) {
          if (value) {
            EasyLoading.dismiss();

            if (guestpopup) {
              Get.back();
              Get.back();
            } else {
              Get.offAllNamed('/HomeDashboard');
            }

            Fluttertoast.showToast(msg: "Success");
          }
        });
      } else if (response.data['code'].toString() == 'ERROR_OTP01') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: (response.data['message']));
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  void signUp(String email, String password, String? callingcode, String number,
      bool guestpopup) async {
    if (guestpopup) {
      guestpopupvalue('yes');
    }
    EasyLoading.show();

    Map<String, dynamic> param = {
      "firstName": "",
      "lastName": "",
      "middleName": "",
      "displayName": "",
      "prefix": ".",
      "dob": "",
      'email': email.toString(),
      'password': password.toString(),
      'phoneNumber': callingcode! + number.toString(),
      "guestDeviceId": guestpopup ? initialcon.deviceId : ''
    };
    debugPrint('signUp param is $param');

    apiRepository.signUp(param).getResponse<Response<String>>((response) {
      debugPrint('signUp data is $response');

      if (response.data['code'].toString() == '200') {
        expiryTime(response.data['data']['expiry'].toString());
        otp(response.data['data']['otp'].toString());

        EasyLoading.dismiss();
        Get.toNamed('/verficationScreen');

        Fluttertoast.showToast(msg: "Success");
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future<bool> resendOtp() async {
    bool complete = false;
    EasyLoading.show();
    Map<String, dynamic> param = {'email': emailController.text};
    print('resend otp param: $param');

    print(param);
    await apiRepository
        .resendotp(param)
        .getResponse<Response<String>>((response) {
      debugPrint('login data is $response');

      if (response.data['code'].toString() == '200') {
        otp(response.data['data']['otp'].toString());
        EasyLoading.dismiss();

        complete = true;
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");

        complete = false;
      }
    });
    return complete;
  }

  void verifyOtp(String otp) async {
    EasyLoading.show();
    Map<String, dynamic> param = {
      'email': emailController.text.toString(),
      'otp': int.parse(otp),
    };

    print('param for verify otp is :$param ');
    apiRepository
        .verifyOtp(param)
        .getResponse<Response<String>>((response) async {
      debugPrint('login data is $response');

      if (response.data['code'].toString() == '200') {
        cLearEvertyThing();
        initialcon.userID(response.data['data']['id'].toString());

        box.write(
            'AccessToken', response.data['data']['accessToken'].toString());
        box.write('GuestID', response.data['data']['accessToken'].toString());
        box.write('UserID', response.data['data']['id'].toString());
        box.write('roleID', response.data['data']['role']['id'].toString());

        box.write('roleName', response.data['data']['role']['name'].toString());
        box.write('fullname', response.data['data']['firstName'].toString());
        box.write('email', response.data['data']['email'].toString());
        box.write(
            'phonenumber', response.data['data']['phoneNumber'].toString());

        initialcon.userExsists('Yes');

        initialcon.initialcheckUserCartData().then((value) {
          print('the value of intial cont check is $value');

          if (value == true) {
            EasyLoading.dismiss();

            if (guestpopupvalue.value.toString() == 'yes') {
              Get.back();
              Get.back();
            } else {
              Get.offAllNamed('/HomeDashboard');
            }

            Fluttertoast.showToast(msg: "Success");
          }
        });
      } else if (response.data['code'].toString() == 'ERROR_OTP01') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: (response.data['message']));
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future<bool> requestotp(BuildContext context, String email) async {
    bool complete = false;
    EasyLoading.show();
    Map<String, dynamic> param = {'email': email};
    print('resend otp param: $param');

    print(param);
    await apiRepository
        .requestotp(param)
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        expiryTimeOfResetPassword(response.data['data']['expiry'].toString());
        OtpDailog(context, response.data['data']['otp'].toString());
        // otp(response.data['data']['otp'].toString());
        EasyLoading.dismiss();

        complete = true;
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");

        complete = false;
      }
    });
    return complete;
  }

  Future<bool> resetpassword(Map<String, dynamic> param) async {
    bool complete = false;
    EasyLoading.show();
    print('resend otp param: $param');

    print(param);
    await apiRepository
        .resettpassword(param)
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        EasyLoading.dismiss();

        complete = true;
      } else if (response.data['code'].toString() == 'ERROR_AUTH02') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else if (response.data['code'].toString() == 'ERROR_AUTH03') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else if (response.data['code'].toString() == 'ERROR_OTP01') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");

        complete = false;
      }
    });
    return complete;
  }

  Future<dynamic> OtpDailog(BuildContext context, String otp) {
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
                                    child: Text(
                                      otp,
                                      style: const TextStyle(
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
                                      Clipboard.setData(
                                          ClipboardData(text: otp));
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
