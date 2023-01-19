import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

Widget submitButton({
  double? height,
  String? title,
  double? width,
  Color? col,
  Color? textcol,
  final VoidCallback? onPress,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0),
    child: SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(8),
          backgroundColor: MaterialStateProperty.all<Color>(
              col ?? (title == 'Review Menu'.tr() ? Col.blue : Col.darkgreen)),
          overlayColor: MaterialStateProperty.all<Color>(
            title == 'Review Menu'.tr() ? Col.blue : Col.darkgreen,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        onPressed: onPress,
        child: Text(
          title!,
          textScaleFactor: 1.1,
          style: TextStyle(
            fontFamily: Assets.Product_Sans_Bold,
            color: textcol ?? Colors.white,
          ),
        ),
      ),
    ),
  );
}
