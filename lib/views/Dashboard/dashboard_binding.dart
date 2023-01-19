import 'package:eat_well/views/Dashboard/dashboard_Controller.dart';
import 'package:get/get.dart';

// import '../Diet CAtegory/dietcategory_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardController>(DashboardController(Get.find()));
  }
}
