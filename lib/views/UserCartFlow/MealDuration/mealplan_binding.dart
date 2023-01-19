import 'package:get/get.dart';

import 'mealplandurationController.dart';

class MealdurationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MealdurationController>(MealdurationController(Get.find()));
  }
}
