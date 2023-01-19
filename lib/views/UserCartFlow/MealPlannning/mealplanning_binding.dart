import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplanningController.dart';
import 'package:get/get.dart';

class MealPlanningBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MealPlanningController>(MealPlanningController(Get.find()));
  }
}
