// ignore_for_file: file_names, unnecessary_overrides

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/dietdaysPlan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';

import '../DietCategory/dietcategory_controller.dart';

class DaysPlanController extends GetxController {
  ApiRepository apiRepository;
  DaysPlanController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();
  var daysPlan = List<DaysPlan>.empty(growable: true).obs;
  var selectedindex = ''.obs;

  @override
  void onInit() {
    selectedindex(categoryController.selectedIndex.toString());
    super.onInit();
    getPlans();
  }

  void getPlans() async {
    apiRepository
        .getDietplans(
            initialcon.loginToken.toString(), initialcon.dietcategoryID.value)
        .getResponse<Response<String>>((response) {
      debugPrint('get Diet Plans data is $response');

      if (response.data['code'].toString() == '200') {
        List listData = response.data['data'];

        for (var i = 0; i < listData.length; i++) {
          var plans = DaysPlan(
              id: response.data['data'][i]['id'],
              name: response.data['data'][i]['name'],
              price: response.data['data'][i]['price'],
              duration: response.data['data'][i]['duration'],
              dietCategoryId: response.data['data'][i]['dietCategoryId']);

          daysPlan.add(plans);
        }
        // var parsingList = listData.map((m) => DaysPlan.fromJson(m)).toList();
        // daysPlan.addAll(parsingList);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
