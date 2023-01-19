import 'package:eat_well/views/Login&SignIn/loginSignp_Controller.dart';
import 'package:get/get.dart';

class LoginSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginSignUpController>(LoginSignUpController(Get.find()));
  }
}
