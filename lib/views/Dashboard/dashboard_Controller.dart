// ignore_for_file: file_names, unnecessary_overrides

import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DashboardController extends GetxController {
  ApiRepository apiRepository;
  DashboardController(this.apiRepository);
  PageController? pageController;
  RxInt rxIndex = 0.obs;
  var istrue = true.obs;
  InitialStatusController initalcon = Get.find<InitialStatusController>();

  late PersistentTabController controllerPersistent;

  @override
  void onInit() {
    pageController = PageController();
    controllerPersistent = PersistentTabController(initialIndex: 0);
    controllerPersistent.addListener(() {
      rxIndex(controllerPersistent.index);
    });
    if (initalcon.userExsists.value.toString() == 'No') {
      // initalcon.checkUserCart(false);
    }
    super.onInit();
  }

  // void bottomChange(index) {
  //   index == 0
  //       ? Get.toNamed('/HomeDashboard')
  //       : index == 1
  //           ? Get.to(const OrderHIstory())
  //           : pageController?.jumpToPage(index);
  //   rxIndex(index);
  // }
}
