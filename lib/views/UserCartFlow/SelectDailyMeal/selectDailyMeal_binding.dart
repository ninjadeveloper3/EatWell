import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:get/get.dart';

class DailyMealSelectBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DailyMealSelectController>(DailyMealSelectController(Get.find()));
  }
}
