// ignore_for_file: file_names, unnecessary_overrides, avoid_print

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/mealItem.dart';
import 'package:eat_well/widgets/infoDailog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class DailyMealSelectController extends GetxController {
  ApiRepository apiRepository;
  DailyMealSelectController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var mealData = List<MealItem>.empty(growable: true).obs;
  var unselecteddate = List<DateTime>.empty(growable: true).obs;
  var unselecteddateisEmpty = 'false'.obs;
  var totalcalories = ''.obs;

  var mealdataisEmpty = false.obs;

  @override
  void onInit() {
    getMealItems();
    super.onInit();
  }

  void getMealItems() async {
    EasyLoading.show();
    mealData.isEmpty ? null : mealData.clear();
    mealdataisEmpty(false);
    await apiRepository
        .getMealItem(initialcon.userGoalforCartMeal.value,
            initialcon.dietcategoryIDforCartMeal.value)
        .getResponse<Response<String>>((response) {
      debugPrint('refersh meal data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          print('meallll');
          mealdataisEmpty(true);
        }
        List listData = response.data['data'];
        var parsingList = listData.map((m) => MealItem.fromJson(m)).toList();
        mealData.addAll(parsingList);
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  /// UPDATE START DATE

  Future<bool> updateStartdate(String startdate, int cartID) async {
    bool isAPicompleted = false;
    EasyLoading.show();
    Map<String, dynamic> params = {
      "id": cartID,
      "startDate": startdate,
      "autoUpdate": "1",
    };

    await apiRepository
        .updateCArtdate(params)
        .getResponse<Response<String>>((response) async {
      if (response.data['code'].toString() == '200') {
        await initialcon.resetCart(false);
        Get.back();
        isAPicompleted = true;
        EasyLoading.dismiss();
        return isAPicompleted;
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return isAPicompleted;
      }
    });
    return isAPicompleted;
  }

  /// check validation on timeline DATE

  void checkAlldates(int cartID, BuildContext context) async {
    initialcon.rebuilldwidget('rebuild');
    unselecteddate.clear();
    EasyLoading.show();
    Map<String, dynamic> params = {
      "id": cartID,
    };

    apiRepository.checkdates(params).getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        // totalcalories(response.data['data']['totalCalories']);

        EasyLoading.dismiss();
      } else if (response.data['code'].toString() == '409') {
        totalcalories(response.data['data']['totalCalories'].toString());
        for (var i = 0; i < response.data['data']['missingDates'].length; i++) {
          print('yes');
          unselecteddate.add(DateTime.parse(
              response.data['data']['missingDates'][i].toString()));

          print('the unselected dates are $unselecteddate');
        }

        if (unselecteddate.isNotEmpty) {
          print('dailog');
          InfoDailog(context,
              'Please select meal for day ${DateFormat.yMMMEd().format(DateTime.parse(unselecteddate[0].toString()))}');
        }
        initialcon.rebuilldwidget('yes');
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  refershMealitems() {
    mealData.clear();
    getMealItems();
  }

//// meal detail param
  Map<String, dynamic> param1 = {};
  Map<String, dynamic> param2 = {};
}
