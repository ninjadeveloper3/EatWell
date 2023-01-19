// ignore_for_file: file_names, unnecessary_overrides, avoid_print

import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;

class CaloriesCalculatorController extends GetxController {
  ApiRepository apiRepository;
  CaloriesCalculatorController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var usercalories = ''.obs;

  TextEditingController heightController = TextEditingController();
  TextEditingController dobDay = TextEditingController();
  TextEditingController dobMonth = TextEditingController();
  TextEditingController dobYear = TextEditingController();
  TextEditingController weight = TextEditingController();
}
