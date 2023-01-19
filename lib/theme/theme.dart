import 'package:eat_well/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:eat_well/theme/color_codes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Themes {
  static final light = ThemeData(
    highlightColor: Col.dullyellow,
    radioTheme: RadioThemeData(
      overlayColor: MaterialStateColor.resolveWith((states) => Col.blue),
      fillColor: MaterialStateColor.resolveWith((states) => Col.green),
      //<-- SEE HERE
    ),
    fontFamily:
        Get.locale.toString() == 'ar' ? 'TheSans-Plain' : 'Poppins-Regular',
    checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    )),
    scaffoldBackgroundColor: Col.WHITE,
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        foregroundColor: Colors.black,
        backgroundColor: appbarColor,
        elevation: 0

        //<-- SEE HERE
        ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      // change the appbar color
      primary: secondaryColor,
    ),
    backgroundColor: primaryColor,
    primaryColor: primaryColor,
    textTheme: TextTheme(
      bodyText1: TextStyle(fontSize: 12.h),
      bodyText2: TextStyle(fontSize: 12.h),
      headline1: TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
        fontFamily:
            Get.locale.toString() == 'ar' ? 'TheSans-Plain' : 'Poppins-Regular',
        color: textColor,
      ),
      headline2: TextStyle(
          fontSize: 20.0.sp,
          fontFamily: Get.locale.toString() == 'ar'
              ? 'TheSans-Plain'
              : 'Poppins-Regular',
          color: Colors.white),
      headline6: TextStyle(
          fontSize: 12.0.sp,
          fontFamily: Get.locale.toString() == 'ar'
              ? 'TheSans-Plain'
              : 'Poppins-Regular',
          color: const Color(0xffb01e28)),
      headline4: TextStyle(
          fontSize: 14.0.sp,
          fontFamily: Get.locale.toString() == 'ar'
              ? 'TheSans-Plain'
              : 'Poppins-Regular',
          color: const Color(0xffadadab),
          fontWeight: FontWeight.w600),
      headline3: TextStyle(
          fontFamily: Get.locale.toString() == 'ar'
              ? 'TheSans-Plain'
              : 'Poppins-Regular',
          fontSize: 20.0.sp,
          color: Colors.black,
          fontWeight: FontWeight.w400),
      headline5: TextStyle(
          fontFamily: Get.locale.toString() == 'ar'
              ? 'TheSans-Plain'
              : 'Poppins-Regular',
          fontSize: 18.0.sp,
          color: const Color(0xff4e4e4e),
          fontWeight: FontWeight.w600),
    ),
  );
  // static final dark = ThemeData.dark().copyWith(
  //   backgroundColor: Colors.black,
  //   buttonColor: Colors.black,
  //   primaryColor: Colors.white,
  //   textTheme: const TextTheme(
  //     headline1: TextStyle(
  //         fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
  //     headline6: TextStyle(fontSize: 12.0, color: Colors.white),
  //     headline4: TextStyle(
  //         fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.w600),
  //     headline5: TextStyle(
  //         fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w600),
  //   ),
  // );
}
