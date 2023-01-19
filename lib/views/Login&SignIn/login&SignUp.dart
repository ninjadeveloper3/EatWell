import 'package:eat_well/views/Login&SignIn/loginSignp_Controller.dart';
import 'package:eat_well/widgets/countrypicker.dart';
import 'package:flutter/material.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:get/get.dart' hide Trans;
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginSignUp extends StatefulWidget {
  @override
  _SigUpState createState() => _SigUpState();
}

List<String> userRoles = [
  'Customer',
  'Admin',
  'Delivery',
  'Nutritionist',
  'Kitchen'
];
var selectedRole = 'Customer';
late bool isSignin;

class _SigUpState extends State<LoginSignUp> {
  LoginSignUpController controller = Get.find<LoginSignUpController>();

  Country? _selectedCountry;
  bool showpass = true;
  late bool guestpopup;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCountry();

    isSignin = Get.arguments[0]['isSignin'];
    guestpopup = Get.arguments[0]['guestpopup'];
  }

  void initCountry() async {
    // final country = await getDefaultCountry(context);
    final country = await getCountryByCountryCode(context, 'SA');
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
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
                            child: SlideInUp(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Authorization".tr(),
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
                                        height: 43,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 35, right: 35),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // DropdownButton<String>(
                                            //   value: selectedRole,
                                            //   onChanged: (String? newValue) =>
                                            //       setState(() =>
                                            //           selectedRole = newValue!),
                                            //   items: userRoles
                                            //       .map<DropdownMenuItem<String>>(
                                            //           (String value) =>
                                            //               DropdownMenuItem<
                                            //                   String>(
                                            //                 value: value,
                                            //                 child: Text(value),
                                            //               ))
                                            //       .toList(),

                                            //   // add extra sugar..
                                            //   icon: Container(
                                            //     height:
                                            //         16.3, // MediaQuery.of(context).size.height * 0.024,
                                            //     width: 16.3,
                                            //     decoration: const BoxDecoration(
                                            //       image: DecorationImage(
                                            //         image: AssetImage(
                                            //           Assets.DropDown_icon,
                                            //         ),
                                            //         fit: BoxFit.cover,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   iconSize: 42,
                                            //   underline: const SizedBox(),
                                            // ),

                                            Container(
                                              height: 37,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: isSignin
                                                    ? Col.darkgreen
                                                    : Col.lightgrey,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  _formKey.currentState!
                                                      .reset();
                                                  FocusScope.of(context)
                                                      .requestFocus(focusNode);
                                                  setState(() {
                                                    controller.emailController
                                                        .clear();
                                                    controller
                                                        .passwordController
                                                        .clear();
                                                    controller
                                                        .phoneNumberController
                                                        .clear();
                                                    controller.emailController
                                                        .clear();
                                                    isSignin = true;
                                                  });
                                                },
                                                child: Text(
                                                  "Sign in".tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: isSignin
                                                        ? Col.WHITE
                                                        : Col.black,
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Regular
                                                        : Assets.TheSans_plain,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize:
                                                        Get.locale.toString() ==
                                                                'en'
                                                            ? 16.7
                                                            : 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 37,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: isSignin
                                                    ? Col.lightgrey
                                                    : Col.darkgreen,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  _formKey.currentState!
                                                      .reset();
                                                  FocusScope.of(context)
                                                      .requestFocus(focusNode);

                                                  setState(() {
                                                    controller.emailController
                                                        .clear();
                                                    controller
                                                        .passwordController
                                                        .clear();
                                                    controller
                                                        .phoneNumberController
                                                        .clear();
                                                    isSignin = false;
                                                  });
                                                },
                                                child: Text(
                                                  "Sign up".tr(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: isSignin
                                                        ? Col.black
                                                        : Col.WHITE,
                                                    fontFamily: Get.locale
                                                                .toString() ==
                                                            'en'
                                                        ? Assets
                                                            .Product_Sans_Regular
                                                        : Assets.TheSans_plain,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize:
                                                        Get.locale.toString() ==
                                                                'en'
                                                            ? 16.7
                                                            : 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      Form(key: _formKey, child: FormUi()),
                                      const SizedBox(height: 45),
                                      Container(
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: const BoxDecoration(
                                          color: Col.darkgreen,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              print('object');

                                              if (isSignin == true) {
                                                controller.login(
                                                    controller
                                                        .emailController.text,
                                                    controller
                                                        .passwordController
                                                        .text,
                                                    guestpopup);
                                              } else {
                                                if (isSignin == false) {
                                                  controller.signUp(
                                                      controller
                                                          .emailController.text,
                                                      controller
                                                          .passwordController
                                                          .text,
                                                      _selectedCountry
                                                          ?.callingCode,
                                                      controller
                                                          .phoneNumberController
                                                          .text,
                                                      guestpopup);
                                                }
                                              }
                                            }
                                            // Get.toNamed('/verficationScreen');
                                          },
                                          child: Text(
                                            isSignin
                                                ? 'Login'.tr()
                                                : "Create Account".tr(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Col.WHITE,
                                              fontFamily:
                                                  Get.locale.toString() == 'en'
                                                      ? Assets
                                                          .Product_Sans_Regular
                                                      : Assets.TheSans_plain,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 37,
                                      ),
                                      Text(
                                        isSignin
                                            ? "Do not have account?".tr()
                                            : 'Already have account?'.tr(),
                                        style: TextStyle(
                                          color: Col.black,
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Product_Sans_Regular
                                                  : Assets.TheSans_plain,
                                          // fontSize:
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          isSignin = !isSignin;

                                          if (isSignin) {
                                            _formKey.currentState!.reset();
                                            FocusScope.of(context)
                                                .requestFocus(focusNode);
                                            setState(() {
                                              controller.emailController
                                                  .clear();
                                              controller.passwordController
                                                  .clear();
                                              controller.phoneNumberController
                                                  .clear();
                                              controller.emailController
                                                  .clear();
                                              isSignin = true;
                                            });
                                          } else {
                                            _formKey.currentState!.reset();
                                            FocusScope.of(context)
                                                .requestFocus(focusNode);

                                            setState(() {
                                              controller.emailController
                                                  .clear();
                                              controller.passwordController
                                                  .clear();
                                              controller.phoneNumberController
                                                  .clear();
                                              isSignin = false;
                                            });
                                          }
                                        },
                                        child: Text(
                                          isSignin
                                              ? "Sign up".tr()
                                              : 'Sign In Now'.tr(),
                                          style: TextStyle(
                                            color: Col.blue,
                                            fontFamily:
                                                Get.locale.toString() == 'en'
                                                    ? Assets.Product_Sans_Bold
                                                    : Assets.TheSans_Bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  )));
        },
      ),
    );
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
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: TextFormField(
            autofocus: true,
            focusNode: focusNode,
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (val) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern.toString());

              if (val == null || val.toString() == '') {
                return 'Please enter email'.tr();
              } else if (!regex.hasMatch(val)) {
                return "Enter valid email".tr();
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
        const SizedBox(
          height: 12,
        ),
        Visibility(
            visible: !isSignin,
            child: Column(
              children: [
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 35),
                      child: Text(
                        "Enter mob number".tr(),
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
                    keyboardType: TextInputType.number,
                    controller: controller.phoneNumberController,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                    validator: (val) {
                      if (isSignin) {
                      } else {
                        final n = num.tryParse(val!);

                        if (val.toString() == '') {
                          return 'Please enter mobile number'.tr();
                        } else if (n == null) {
                          return 'Please enter valid number';
                        } else if (val.length < 9) {
                          return 'Number must be atleast 9 characters'.tr();
                        } else if (val.length > 9) {
                          return 'Number should not exceed 9 characters'.tr();
                        } else {
                          return null;
                        }
                      }
                      return null;
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
                      prefixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 12, 10, 15.7),
                          child: Text(
                            _selectedCountry?.callingCode ?? '',
                            style: TextStyle(
                              fontSize: 16.7,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Regular
                                  : Assets.TheSans_plain,
                            ),
                          )),
                      prefixStyle: const TextStyle(color: Colors.black),
                      suffixIcon: _selectedCountry == null
                          ? Container()
                          : InkWell(
                              onTap: () {
                                // _onPressed();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: 22,
                                  child: _selectedCountry?.flag == null
                                      ? Container()
                                      : Image.asset(
                                          _selectedCountry?.flag ?? '',
                                          package:
                                              'country_calling_code_picker',
                                          // height: 7,
                                        ),
                                ),
                              ),
                            ),
                      // enabledBorder: InputBorder.none,
                      hintText: "77987877",
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
                        fontSize: 16.7,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
              ],
            )),
        SizedBox(
          height: isSignin ? 12 : 0,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Get.locale.toString() == 'en' ? 35 : 20,
                  right: Get.locale.toString() == 'ar' ? 35 : 20),
              child: Text(
                isSignin ? 'Enter Password'.tr() : "Set Password".tr(),
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
            obscureText: showpass,
            controller: controller.passwordController,
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
                  showpass = !showpass;
                  setState(() {});
                },
                icon: !showpass
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
        isSignin
            ? InkWell(
                onTap: () {
                  Get.toNamed('/resetpassword');
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password'.tr(),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Regular
                              : Assets.TheSans_plain,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  void _onPressed() async {
    final country =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PickerPage();
    }));
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}
