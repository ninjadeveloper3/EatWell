// ignore_for_file: file_names, unnecessary_overrides

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/dietCategoryModel.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';

class DietCategoryController extends GetxController {
  ApiRepository apiRepository;
  DietCategoryController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var dietCategory = List<DietCategoryModel>.empty(growable: true).obs;
  var dietcategoryisEmpty = 'false'.obs;
  var selectedCategory = ''.obs;
  var selectedIndex = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getCategory();
  }

  void getCategory() async {
    dietcategoryisEmpty('false');

    String token;
    if (initialcon.userExsists.value.toString() == 'Yes') {
      token = await getAccessToken();
    } else {
      token = await getGuestToken();
    }

    apiRepository
        .getDietCategory(initialcon.userGoal.toString(), token.toString())
        .getResponse<Response<String>>((response) {
      debugPrint('get Diet Category data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          dietcategoryisEmpty('true');
        } else {
          List listData = response.data['data'];

          var parsingList =
              listData.map((m) => DietCategoryModel.fromJson(m)).toList();
          dietCategory.addAll(parsingList);
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
