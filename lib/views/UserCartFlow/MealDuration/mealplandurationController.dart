// ignore_for_file: file_names, unnecessary_overrides, avoid_print

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/mealPerday.dart';
import 'package:eat_well/views/UserCartFlow/DietCategory/dietcategory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MealdurationController extends GetxController {
  ApiRepository apiRepository;
  MealdurationController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var mealperday = List<MealPerDay>.empty(growable: true).obs;
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();
  var selectedCategory = ''.obs;
  var selectedindex = ''.obs;

  @override
  void onInit() {
    super.onInit();
    selectedindex(categoryController.selectedIndex.toString());
  }

  void createCart(String startDate, BuildContext context) async {
    initialcon.userGoalforCartMeal(initialcon.userGoal.value);
    initialcon.dietcategoryIDforCartMeal(initialcon.dietcategoryID.value);
    Map<String, dynamic> params = {
      "startDate": startDate.toString(),
    };
    initialcon.cartparam.addAll(params);
    print(initialcon.cartparam);
    EasyLoading.show();

    apiRepository
        .createCart(initialcon.cartparam)
        .getResponse<Response<String>>((response) {
      debugPrint('cart response data is ${response.data}');

      if (response.data['code'].toString() == '200') {
        initialcon.checkCartData(context);

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
