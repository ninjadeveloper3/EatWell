// ignore_for_file: file_names, unnecessary_overrides, avoid_print

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/caloriess.dart';
import 'package:eat_well/model/mealPerday.dart';
import 'package:eat_well/views/UserCartFlow/MealDuration/MealplanDuration.dart';
import 'package:eat_well/widgets/infoDailog.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:easy_localization/easy_localization.dart';
import '../DietCategory/dietcategory_controller.dart';
import '../MealDuration/mealplandurationController.dart';

class MealPlanningController extends GetxController {
  ApiRepository apiRepository;
  MealPlanningController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var mealperday = List<MealPerDay>.empty(growable: true).obs;
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();

  var selectedCategory = ''.obs;
  var selectedindex = ''.obs;
  var selectedMealPerDayID = ''.obs;
  var caloriesId = ''.obs;

  ///// safe index for for each list with dynamic selection / these selected ids option will pass through post api
  List<int> safeindex0 = [];
  List<int> safeindex1 = [];
  List<int> safeindex2 = [];
  List<int> safeindex3 = [];
  List<int> safeindex4 = [];
  List<int> safeindex5 = [];
  List<int> safeindex6 = [];

  clearSelectedList() {
    safeindex0.clear();
    safeindex1.clear();
    safeindex2.clear();
    safeindex3.clear();
    safeindex4.clear();
    safeindex5.clear();
    safeindex6.clear();
  }

  saveIndex(index, limit, selectedoption, context) {
    if (selectedoption == 0) {
      safeindex1.clear();
      safeindex2.clear();
      safeindex3.clear();
      safeindex4.clear();
      safeindex5.clear();
      safeindex6.clear();

      print('yes');
      safeindex0.contains(index)
          ? safeindex0.remove(index)
          : safeindex0.length < limit + 1
              ? safeindex0.add(index)
              : null;

      if (safeindex0.length > limit) {
        safeindex0.remove(index);

        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex0);
    } else if (selectedoption == 1) {
      safeindex0.clear();
      safeindex2.clear();
      safeindex3.clear();
      safeindex4.clear();
      safeindex5.clear();
      safeindex6.clear();
      print('yes');
      safeindex1.contains(index)
          ? safeindex1.remove(index)
          : safeindex1.length < limit + 1
              ? safeindex1.add(index)
              : null;

      if (safeindex1.length > limit) {
        safeindex1.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
        print(safeindex1);
      }
    } else if (selectedoption == 2) {
      safeindex1.clear();
      safeindex0.clear();
      safeindex3.clear();
      safeindex4.clear();
      safeindex5.clear();
      safeindex6.clear();
      print('yes');
      safeindex2.contains(index)
          ? safeindex2.remove(index)
          : safeindex2.length < limit + 1
              ? safeindex2.add(index)
              : null;

      if (safeindex2.length > limit) {
        safeindex2.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex2);
    } else if (selectedoption == 3) {
      safeindex1.clear();
      safeindex0.clear();
      safeindex2.clear();
      safeindex4.clear();
      safeindex5.clear();
      safeindex6.clear();
      print('yes');
      safeindex3.contains(index)
          ? safeindex3.remove(index)
          : safeindex3.length < limit + 1
              ? safeindex3.add(index)
              : null;

      if (safeindex3.length > limit) {
        safeindex3.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex3);
    } else if (selectedoption == 4) {
      safeindex1.clear();
      safeindex0.clear();
      safeindex2.clear();
      safeindex3.clear();
      safeindex5.clear();
      safeindex6.clear();
      print('yes');
      safeindex4.contains(index)
          ? safeindex4.remove(index)
          : safeindex4.length < limit + 1
              ? safeindex4.add(index)
              : null;

      if (safeindex4.length > limit) {
        safeindex4.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex4);
    } else if (selectedoption == 5) {
      safeindex1.clear();
      safeindex0.clear();
      safeindex2.clear();
      safeindex3.clear();
      safeindex4.clear();
      safeindex6.clear();
      print('yes');
      safeindex5.contains(index)
          ? safeindex5.remove(index)
          : safeindex5.length < limit + 1
              ? safeindex5.add(index)
              : null;

      if (safeindex5.length > limit) {
        safeindex5.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex5);
    } else if (selectedoption == 6) {
      safeindex1.clear();
      safeindex0.clear();
      safeindex2.clear();
      safeindex3.clear();
      safeindex4.clear();
      safeindex5.clear();
      print('yes');
      safeindex6.contains(index)
          ? safeindex6.remove(index)
          : safeindex6.length < limit + 1
              ? safeindex6.add(index)
              : null;

      if (safeindex6.length > limit) {
        safeindex6.remove(index);
        limit == 1
            ? Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(context, 'يمكنك اختيار الحد الأقصى للوجبات $limit')
            : Get.locale.toString() == 'en'
                ? InfoDailog(context, 'You can select maximum $limit Meal')
                : InfoDailog(
                    context, 'يمكنك اختيار الحد الأقصى للوجبات $limit');
      }
      print(safeindex6);
    }
  }

  @override
  void onInit() {
    super.onInit();
    selectedindex(categoryController.selectedIndex.toString());

    getMealPerDays();
  }

  void getMealPerDays() async {
    apiRepository
        .getMealperDayList(initialcon.loginToken.toString())
        .getResponse<Response<String>>((response) {
      debugPrint('get Meal per day list data is $response');

      if (response.data['code'].toString() == '200') {
        List listData = response.data['data'];

        var parsingList = listData.map((m) => MealPerDay.fromJson(m)).toList();
        mealperday.addAll(parsingList);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong".tr());
      }
    });
  }

  void createCartparam(
      List<int> mealCategories, int mealperdayId, int caloriesId, context) {
    print(mealCategories);
    print(mealperdayId);
    print(caloriesId);

    Map<String, dynamic> params = {
      "userId": int.parse(initialcon.userID.toString()),
      "goalId": int.parse(initialcon.userGoal.toString()),
      "planId": int.parse(initialcon.planID.toString()),
      "dietCategoryId": int.parse(initialcon.dietcategoryID.toString()),
      "caloriesId": int.parse(caloriesId.toString()),
      "mealPerDayId": int.parse(mealperdayId.toString()),
      "startDate": "",
      "mealCategories": mealCategories,
      "dieticianAssessment": 1,
      "createdBy": int.parse(initialcon.userID.toString()),
    };
    initialcon.cartparam.addAll(params);

    // apiRepository.createCart(params).getResponse<Response<String>>((response) {
    //   debugPrint('getOnBoardData data is ${response.data}');

    //   if (response.data['code'].toString() == '200') {
    if (initialcon.userExsists.value.toString() == 'Yes') {
      print('yeyey');
      Get.put(MealdurationController(Get.find()));
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const MealPlanDurationPage(),
        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    } else {
      Get.toNamed('/mealPlanDuration');
    }
    // initialcon.cartparam.addAll(params);

    // // apiRepository.createCart(params).getResponse<Response<String>>((response) {
    // //   debugPrint('getOnBoardData data is ${response.data}');

    // //   if (response.data['code'].toString() == '200') {
    // print(initialcon.cartparam);

    // Get.toNamed('/mealPlanDuration');
    //   } else {
    //     Fluttertoast.showToast(msg: "Something went wrong");
    //   }
    // });
  }

////// indeofSelectedCal is the index of selected calories in chips widget we have to find the id of selected calories from List<Calories>
  void validationCheck(int groupval, int indeofSelectedCal,
      List<Caloriess> selectedCal, context) {
    if (groupval == -1) {
      flutterToast('Please Select any meal per day'.tr());
    } else if (groupval == 1 && safeindex0.isEmpty) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 1 &&
        safeindex0.length.toString() != mealperday[0].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 2 && safeindex1.isEmpty) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 2 &&
        safeindex1.length.toString() != mealperday[1].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 3 && safeindex2.isEmpty) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 3 &&
        safeindex2.length.toString() != mealperday[2].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 4 &&
        safeindex3.length.toString() != mealperday[3].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 5 &&
        safeindex4.length.toString() != mealperday[4].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (groupval == 6 &&
        safeindex5.length.toString() != mealperday[5].selection.toString()) {
      flutterToast('Please complete per day meal selection'.tr());
    } else if (indeofSelectedCal == -1) {
      flutterToast('Please Select per day meal calories'.tr());
    } else {
      var selectedcaloriesID = selectedCal[indeofSelectedCal].id;
      createCartparam(
          groupval == 1
              ? safeindex0
              : groupval == 2
                  ? safeindex1
                  : groupval == 3
                      ? safeindex2
                      : groupval == 4
                          ? safeindex3
                          : groupval == 5
                              ? safeindex4
                              : groupval == 6
                                  ? safeindex5
                                  : groupval == 7
                                      ? safeindex6
                                      : safeindex0,
          groupval == 1
              ? mealperday[0].id
              : groupval == 2
                  ? mealperday[1].id
                  : groupval == 3
                      ? mealperday[2].id
                      : groupval == 4
                          ? mealperday[3].id
                          : groupval == 5
                              ? mealperday[4].id
                              : groupval == 6
                                  ? mealperday[5].id
                                  : mealperday[0].id,
          selectedcaloriesID,
          context);
    }
  }
}
