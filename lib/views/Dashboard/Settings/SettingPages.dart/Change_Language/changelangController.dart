// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageSettingController extends GetxController {
  var currentlanguage = 'en'.obs;
  var selectedlang = ''.obs;
  // Map<String, bool> Languages = {
  //   'Arabic': false,
  //   'English': false,
  //   'Urdu': false,
  //   'Bangla': false,
  //   'Hindi': false,
  // }.obs;
  Map<String, bool> Languages = {
    'Arabic': false,
    'English': false,
  }.obs;

  @override
  void onInit() {
    Get.context?.locale.toString() == 'en'
        ? currentlanguage('English')
        : Get.context?.locale.toString() == 'ur'
            ? currentlanguage('Urdu')
            : Get.context?.locale.toString() == 'bn'
                ? currentlanguage('Bangla')
                : Get.context?.locale.toString() == 'ar'
                    ? currentlanguage('Arabic')
                    : Get.context?.locale.toString() == 'hi'
                        ? currentlanguage('Hindi')
                        : currentlanguage('en');

    print(currentlanguage);
    Languages.update(currentlanguage.toString(), (value) => true);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
