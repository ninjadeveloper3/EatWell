import 'package:eat_well/views/UserCartFlow/Diet_Days_Plan/dietdaysPlanController.dart';
import 'package:get/get.dart';

class DietDaysBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DaysPlanController>(DaysPlanController(Get.find()));
  }
}
