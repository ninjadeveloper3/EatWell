// ignore_for_file: file_names

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:get/get.dart';

class IntialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InitialStatusController>(InitialStatusController(Get.find()));
  }
}
