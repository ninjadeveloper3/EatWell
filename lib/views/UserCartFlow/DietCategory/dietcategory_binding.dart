import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory_controller.dart';
import 'package:get/get.dart';

// import '../Diet CAtegory/dietcategory_controller.dart';

class DietCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DietCategoryController>(DietCategoryController(Get.find()));
  }
}
