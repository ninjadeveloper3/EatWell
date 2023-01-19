import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eat_well/theme/color_codes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

showProgressBar() {
  Get.dialog(
      const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      )),
      barrierDismissible: false);
}

showSnackBarTwo(String title, String message, Color? backgroundColor) {
  Get.isSnackbarOpen
      ? null
      :
      // Get.snackbar(title, message,
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: backgroundColor,
      //     colorText: textColor);
      Get.rawSnackbar(
          duration: const Duration(seconds: 3),
          dismissDirection: DismissDirection.horizontal,
          messageText: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/info-circle.svg",
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        title ?? "error",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ),
                    Text(
                      message ?? "Something went wrong",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: title == 'Success' ? Colors.green : Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 16),
          borderRadius: 8,
          snackPosition: SnackPosition.TOP,
        );
  EasyLoading.dismiss();
}

showSnackBar(String title, String message, Color backgroundColor,
    bool iconIsVisible, String iconType) {
  Get.snackbar(title, message,
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      titleText: const Text(
        "",
        style: TextStyle(fontSize: 0),
      ),
      icon: Padding(
        padding: const EdgeInsets.all(0.0),
        child: CircleAvatar(
          backgroundColor: iconType == "error"
              ? Colors.red
              : iconType == "warning"
                  ? Colors.red
                  : Colors.green,
          radius: 20,
          child: Icon(
            iconType == "error"
                ? Icons.close
                : iconType == "warning"
                    ? Icons.info_outline
                    : Icons.done,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 350),
      padding: const EdgeInsets.all(20),
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.transparent,
      boxShadows: [
        BoxShadow(
          color: Colors.transparent.withOpacity(0.4),
          spreadRadius: 0,
          blurRadius: 5,
          offset: const Offset(1, 1), // changes position of shadow
        ),
      ],
      colorText: iconType == "warning" ? Colors.white : Colors.white);
}
