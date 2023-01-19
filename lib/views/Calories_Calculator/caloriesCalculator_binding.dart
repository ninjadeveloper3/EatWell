import 'package:eat_well/views/Calories_Calculator/caloriesCalculatorController.dart';
import 'package:get/get.dart';

class CaloriesCalculatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CaloriesCalculatorController>(
        CaloriesCalculatorController(Get.find()));
  }
}
