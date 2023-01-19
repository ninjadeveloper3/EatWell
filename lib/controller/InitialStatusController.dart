// ignore_for_file: file_names, unnecessary_overrides, avoid_print, depend_on_referenced_packages

import 'dart:io';

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/model/CartItems.dart';
import 'package:eat_well/model/appPreRequestData.dart';
import 'package:eat_well/model/mealCategorySelectionModel.dart';
import 'package:eat_well/model/onBoardDataModel.dart';
import 'package:eat_well/model/orderHistoryModel.dart';
import 'package:eat_well/model/userProfieModel.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class InitialStatusController extends GetxController {
  ApiRepository apiRepository;
  InitialStatusController(this.apiRepository);
  var onboardDataList = List<OnBoardData>.empty(growable: true).obs;
  var cartItems = List<CartItems>.empty(growable: true).obs;
  var orderHistory = List<OrderHistoryModel>.empty(growable: true).obs;
  var apppreRequest = List<AppPreRequestData>.empty(growable: true).obs;
  ProfileModel? userprofile;
  var userprofileApiCompleted = 'false'.obs;
  var orderHistoryIsEmpty = 'false'.obs;
  MealCategorySelectionModel? selectedItem;
  final box = GetStorage();
  var userGoal = ''.obs;
  var dietcategoryID = ''.obs;
  var planID = ''.obs;
  var plandays = ''.obs;
  var loginToken = ''.obs;
  var userID = ''.obs;
  var selectedCategory = ''.obs;
  var planduration = ''.obs;
  var startDays = ''.obs;
  var plandayselected = ''.obs;
  var termsAndConditionUrl = ''.obs;
  var privacyPolicyUrl = ''.obs;
  var dietitionPhoneNum = ''.obs;
  var supportCAllphone = ''.obs;
  var userCartEmpty = '0'.obs; // check if user cart is empty or not
  Map<String, dynamic> cartparam = {};
  Map<String, dynamic> mealCategory = {};
  var contains = List<int>.empty(growable: true).obs;

  ///////////// for language change
  Map<String, bool> Languages = {
    'Arabic': false,
    'English': false,
  }.obs;
  var currentlanguage = ''.obs;
////////////////////

  var tempselectedIndex = List<int>.empty(growable: true).obs;
  var cartStatus = 'Added'.obs;
  var reviewStatus = '0'.obs;

///// save index for selected line item
  var lineintemindex = '0'.obs;

  //// device Id
  String? deviceId;

  ////// id of a selected line item
  ///
  var selectedlineitemid = '0'.obs;

///// for meal items in cart
  var userGoalforCartMeal = ''.obs;
  var dietcategoryIDforCartMeal = ''.obs;

  //////////// device registration token
  ///
  var deviceTokenToSendPushNotification = ''.obs;

  ///// user Exsists check btw user or guest
  ///
  var userExsists = 'No'.obs;

  ////// selected goal discription
  var userselectedgoalDiscription = ''.obs;

  /// rebuild widget
  var rebuilldwidget = 'rebuild'.obs;

  @override
  void onInit() async {
    super.onInit();

    deviceId = await _getId();

    print('deviceId is $deviceId');
    var authtoken = await getAccessToken();
    if (authtoken.toString() != 'null' || authtoken.toString() == '') {
      userExsists('Yes');
      print(authtoken);
      loginToken(authtoken.toString());
      print('auth token exsits');
      checkUserCart(false);
    }

    var userid = await getuserId();
    if (userid.toString() != '' || userid.toString() == 'null') {
      userID(userid.toString());
      print('userid  exsits');
    }
    loginToken.toString() == '' ? getOnBoardData() : null;
    getPrerequestAppData();

    // getTokenNow();
  }

  Future<bool> getGuestTokenInfo() async {
    bool apicompleted = false;
    userExsists('No');
    await apiRepository
        .guestToken(deviceId.toString())
        .getResponse<Response<String>>((response) {
      debugPrint('guest token data is $response');

      if (response.data['code'].toString() == '200') {
        userID(response.data['data']['id'].toString());
        box.write(
            'GuestToken', response.data['data']['accessToken'].toString());
        box.write('GuestID', response.data['data']['id'].toString());

        print(
            'guest token is ${response.data['data']['accessToken'].toString()}');
        apicompleted = true;
        return apicompleted;
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return apicompleted;
      }
    });

    return apicompleted;
  }

  /// updateprofile
  ///
  ///
  Future<bool> updateProfile(
      Map<String, dynamic> param, BuildContext context) async {
    EasyLoading.show();
    bool apicompleted = false;
    print('posted param are:$param');
    await apiRepository
        .updateProfile(param)
        .getResponse<Response<String>>((response) async {
      if (response.data['code'].toString() == '200') {
        getUserProfile();

        EasyLoading.dismiss();

        print('profile Updated Successfully');
        apicompleted = true;

        return apicompleted;
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
        return apicompleted;
      }
    });

    return apicompleted;
  }

// //// fcm token for each device
//   Future<void> getDeviceTokenToSendNotification() async {
//     final FirebaseMessaging _fcm = FirebaseMessaging.instance;
//     _fcm.subscribeToTopic('all');
//     final token = await _fcm.getToken();
//     deviceTokenToSendPushNotification(token.toString());
//     print("Device Token Value $deviceTokenToSendPushNotification");
//     // final box = GetStorage();

//     // box.write('deviceregistrationID', deviceTokenToSendPushNotification);
//     // print('boxx value is${box.read('deviceregistrationID')}');
//   }

  //// get device unique id
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      print('the id is ${androidDeviceInfo.androidId}');
      return androidDeviceInfo.androidId; // unique ID on Android
    }
    return null;
  }

  /// get order history
  Future<bool> getOrderHistory() async {
    orderHistoryIsEmpty('false');
    bool apicompleted = false;

    await apiRepository
        .getOrderHistory()
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          orderHistoryIsEmpty('true');
        } else {
          List listData = response.data['data'];

          var parsingList =
              listData.map((m) => OrderHistoryModel.fromJson(m)).toList();
          orderHistory.addAll(parsingList);

          apicompleted = true;
        }

        return apicompleted;
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        return apicompleted;
      }
    });

    return apicompleted;
  }

  /// user profile
  /// get order history
  void getUserProfile() async {
    userprofileApiCompleted('false');

    userprofile = null;

    await apiRepository
        .getUserProfile()
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        userprofileApiCompleted('true');

        var data = response.data['data'];
        userprofile = ProfileModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  /// get app pre request data
  /// get order history
  void getPrerequestAppData() async {
    await apiRepository
        .getPrerequestdata()
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        print(
            'the response of app pre request data is: ${response.data['data']}');
        List listData = response.data['data'];

        var parsingList =
            listData.map((m) => AppPreRequestData.fromJson(m)).toList();
        apppreRequest.addAll(parsingList);

        for (var i = 0; i < apppreRequest.length; i++) {
          if (apppreRequest[i].paramName.toString() ==
              'term_and_condition_url') {
            termsAndConditionUrl(apppreRequest[i].paramValue.toString());
          }
          if (apppreRequest[i].paramName.toString() == 'privacy_policy_url') {
            privacyPolicyUrl(apppreRequest[i].paramValue.toString());
          }
          if (apppreRequest[i].paramName.toString() == 'support_phone_no') {
            supportCAllphone(apppreRequest[i].paramValue.toString());

            print(
                'the support call is :${apppreRequest[i].paramValue.toString()}');
          }
          if (apppreRequest[i].paramName.toString() == 'dietician_phone_no') {
            dietitionPhoneNum(apppreRequest[i].paramValue.toString());
          }
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future checkUserCart(bool refershMeal) async {
    var authToken = userExsists.value.toString() == 'Yes'
        ? await getAccessToken()
        : await getGuestToken();
    var userId = userExsists.value.toString() == 'Yes'
        ? await getuserId()
        : await getguestId();

    print('=====${userExsists.value.toString()}=====$userId======$authToken');

    await apiRepository
        .checkUserCart(userId, authToken)
        .getResponse<Response<String>>((response) {
      debugPrint('cart data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          EasyLoading.dismiss();
          debugPrint('empty');
          userCartEmpty('0');
        } else {
          debugPrint('not empty');

          userCartEmpty('1');

          if (cartItems.isEmpty) {
            List listData = response.data['data'];

            var parsingList =
                listData.map((m) => CartItems.fromJson(m)).toList();
            cartItems.addAll(parsingList);
          }

          userGoal(response.data['data'][0]['goalId'].toString());
          dietcategoryID(response.data['data'][0]['dietCategoryId'].toString());

          userGoalforCartMeal(response.data['data'][0]['goalId'].toString());
          dietcategoryIDforCartMeal(
              response.data['data'][0]['dietCategoryId'].toString());

          planID(response.data['data'][0]['planId'].toString());
          startDays(response.data['data'][0]['startDate'].toString());

          print(
              'the start days is${response.data['data'][0]['startDate'].toString()}');
          plandayselected(
              response.data['data'][0]['plan']['duration'].toString());

          if (selectedItem?.id == null) {
            selectedItem = MealCategorySelectionModel(
                id: cartItems[0].mealCategories[0].mealCategory.id,
                name:
                    cartItems[0].mealCategories[0].mealCategory.name.toString(),
                selectedIndex: 0,
                mealCatID: cartItems[0].mealCategories[0].id,
                lineitems: cartItems[0].mealCategories[0].lineItems);
          } else {
            selectedItem = MealCategorySelectionModel(
                id: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .mealCategory
                    .id,
                name: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .mealCategory
                    .name
                    .toString(),
                selectedIndex: int.parse(lineintemindex.value),
                mealCatID: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .id,
                lineitems: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .lineItems);
          }
          // DailyMealSelectController dailymealcon =
          //     Get.find<DailyMealSelectController>();
          // dailymealcon.refershMealitems();

          EasyLoading.dismiss();

          // rebuilldwidget('rebuild2');

          // if (refershMeal) {
          //   DailyMealSelectController con =
          //       Get.find<DailyMealSelectController>();
          //   con.refershMealitems();
          // }
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

//// usercart check on guest screens
  void checkUserCartforGuest() async {
    EasyLoading.show();
    var authToken = userExsists.value.toString() == 'Yes'
        ? await getAccessToken()
        : await getGuestToken();
    var userId = userExsists.value.toString() == 'Yes'
        ? await getuserId()
        : await getguestId();

    print('=====${userExsists.value.toString()}=====$userId======$authToken');

    await apiRepository
        .checkUserCart(userId, authToken)
        .getResponse<Response<String>>((response) {
      debugPrint('cart data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          EasyLoading.dismiss();
          debugPrint('empty');
          userCartEmpty('0');
        } else {
          debugPrint('not empty');

          userCartEmpty('1');

          if (cartItems.isEmpty) {
            List listData = response.data['data'];

            var parsingList =
                listData.map((m) => CartItems.fromJson(m)).toList();
            cartItems.addAll(parsingList);
          }

          userGoal(response.data['data'][0]['goalId'].toString());
          dietcategoryID(response.data['data'][0]['dietCategoryId'].toString());

          userGoalforCartMeal(response.data['data'][0]['goalId'].toString());
          dietcategoryIDforCartMeal(
              response.data['data'][0]['dietCategoryId'].toString());

          planID(response.data['data'][0]['planId'].toString());
          startDays(response.data['data'][0]['startDate'].toString());
          plandayselected(
              response.data['data'][0]['plan']['duration'].toString());

          if (selectedItem?.id == null) {
            selectedItem = MealCategorySelectionModel(
                id: cartItems[0].mealCategories[0].mealCategory.id,
                name:
                    cartItems[0].mealCategories[0].mealCategory.name.toString(),
                selectedIndex: 0,
                mealCatID: cartItems[0].mealCategories[0].id,
                lineitems: cartItems[0].mealCategories[0].lineItems);
          } else {
            selectedItem = MealCategorySelectionModel(
                id: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .mealCategory
                    .id,
                name: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .mealCategory
                    .name
                    .toString(),
                selectedIndex: int.parse(lineintemindex.value),
                mealCatID: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .id,
                lineitems: cartItems[0]
                    .mealCategories[int.parse(lineintemindex.value)]
                    .lineItems);
          }
          // DailyMealSelectController dailymealcon =
          //     Get.find<DailyMealSelectController>();
          // dailymealcon.refershMealitems();

          EasyLoading.dismiss();

          // rebuilldwidget('rebuild2');

          // if (refershMeal) {
          //   DailyMealSelectController con =
          //       Get.find<DailyMealSelectController>();
          //   con.refershMealitems();
          // }
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future resetCart(bool refershMeal) async {
    cartItems.clear();
    await checkUserCart(refershMeal);
  }

  void checkCartData(context) {
    cartItems.clear();

    checkUserCartData(context);
  }

  void getOnBoardData() async {
    getGuestTokenInfo();
    apiRepository.getOnboardData().getResponse<Response<String>>((response) {
      debugPrint('getOnBoardData data is $response');

      if (response.data['code'].toString() == '200') {
        EasyLoading.dismiss();
        List listData = response.data['data'];

        var parsingList = listData.map((m) => OnBoardData.fromJson(m)).toList();
        onboardDataList.addAll(parsingList);
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAllNamed('/GettingStartedScreen');
        });
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  void getOnBoardDataForSelectionSecreen() async {
    apiRepository.getOnboardData().getResponse<Response<String>>((response) {
      debugPrint('getOnBoardData data is $response');

      if (response.data['code'].toString() == '200') {
        List listData = response.data['data'];

        var parsingList = listData.map((m) => OnBoardData.fromJson(m)).toList();
        onboardDataList.addAll(parsingList);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
  //// add item to cart

  void addtoCart(Map<String, dynamic> param, int ind) async {
    EasyLoading.show();
    await apiRepository
        .addtoCart(param)
        .getResponse<Response<String>>((response) {
      debugPrint('add to cart response is $response');

      if (response.data['code'].toString() == '200') {
        tempselectedIndex.add(ind);
        resetCart(true);

        DailyMealSelectController con = Get.find<DailyMealSelectController>();
        con.unselecteddate
            .remove(DateTime.parse(param['orderDate'].toString()));

        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "item added");
      } else if (response.data['code'].toString() == '400') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else if (response.data['code'].toString() == '409') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  ///// delete item from cart
  ///
  void deleteMealItem(String param, int ind, BuildContext context) async {
    // rebuilldwidget('rebuild');
    print(param);
    EasyLoading.show();
    apiRepository.deleteItem(param).getResponse<Response<String>>((response) {
      debugPrint('add to cart response is $response');

      if (response.data['code'].toString() == '200') {
        // tempselectedIndex.removeWhere(
        //   (element) => element == ind,
        // );
        // contains.removeWhere((element) => (element == ind));
        resetCart(false);

        // EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "item deleted");
      } else if (response.data['code'].toString() == '400') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  ///// reset to add to cart when initial cart is created
  ///
  void checkUserCartData(context) async {
    var authToken = userExsists.value.toString() == 'Yes'
        ? await getAccessToken()
        : await getGuestToken();
    var userId = userExsists.value.toString() == 'Yes'
        ? await getuserId()
        : await getguestId();
    await apiRepository
        .checkUserCart(userId, authToken)
        .getResponse<Response<String>>((response) {
      debugPrint('cart data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          debugPrint('empty');
          userCartEmpty('0');
        } else {
          debugPrint('not empty');

          userCartEmpty('1');
          List listData = response.data['data'];

          var parsingList = listData.map((m) => CartItems.fromJson(m)).toList();
          cartItems.addAll(parsingList);

          userGoal(response.data['data'][0]['goalId'].toString());
          dietcategoryID(response.data['data'][0]['dietCategoryId'].toString());
          planID(response.data['data'][0]['planId'].toString());
          startDays(response.data['data'][0]['startDate'].toString());
          plandayselected(
              response.data['data'][0]['plan']['duration'].toString());

          selectedItem = MealCategorySelectionModel(
              id: cartItems[0].mealCategories[0].mealCategory.id,
              name: cartItems[0].mealCategories[0].mealCategory.name.toString(),
              selectedIndex: 0,
              mealCatID: cartItems[0].mealCategories[0].id,
              lineitems: cartItems[0].mealCategories[0].lineItems);

          if (userExsists.value.toString() == 'Yes') {
            Get.put(DailyMealSelectController(Get.find()));
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: SelectDailyMealScreen(),
              withNavBar: true, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          } else {
            Get.offAllNamed('/dailymealSelection');
          }
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  Future<bool> initialcheckUserCartData() async {
    bool isAPicompleted = false;
    cartItems.clear();
    var authToken = userExsists.value.toString() == 'Yes'
        ? await getAccessToken()
        : await getGuestToken();
    var userId = await getuserId();
    await apiRepository
        .checkUserCart(userId, authToken)
        .getResponse<Response<String>>((response) {
      debugPrint('cart data is $response');

      if (response.data['code'].toString() == '200') {
        if (response.data.toString().contains('data: []')) {
          debugPrint('empty');
          userCartEmpty('0');
          isAPicompleted = true;
          return isAPicompleted;
        } else {
          debugPrint('not empty');

          userCartEmpty('1');
          List listData = response.data['data'];

          var parsingList = listData.map((m) => CartItems.fromJson(m)).toList();
          cartItems.addAll(parsingList);

          userGoal(response.data['data'][0]['goalId'].toString());
          dietcategoryID(response.data['data'][0]['dietCategoryId'].toString());
          planID(response.data['data'][0]['planId'].toString());
          startDays(response.data['data'][0]['startDate'].toString());
          plandayselected(
              response.data['data'][0]['plan']['duration'].toString());

          userGoalforCartMeal(response.data['data'][0]['goalId'].toString());
          dietcategoryIDforCartMeal(
              response.data['data'][0]['dietCategoryId'].toString());

          selectedItem = MealCategorySelectionModel(
              id: cartItems[0].mealCategories[0].mealCategory.id,
              name: cartItems[0].mealCategories[0].mealCategory.name.toString(),
              selectedIndex: 0,
              mealCatID: cartItems[0].mealCategories[0].id,
              lineitems: cartItems[0].mealCategories[0].lineItems);

          isAPicompleted = true;
          return isAPicompleted;

          // Get.offAllNamed('/dailymealSelection');
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
        isAPicompleted = false;
        return isAPicompleted;
      }
    });

    return isAPicompleted;
  }

  logout() {
    userprofileApiCompleted('false');
    userprofile = null;
    orderHistory.clear();
    orderHistoryIsEmpty('false');
    reviewStatus('0');

    userGoal('');
    dietcategoryID('');
    planID('');
    plandays('');
    loginToken('');
    userID('');
    selectedCategory('');
    planduration('');
    startDays('');
    plandayselected('');
    userCartEmpty('0');
    cartparam = {};
    mealCategory = {};

    cartStatus('Added');
    lineintemindex('0');
    selectedlineitemid('0');
    userGoalforCartMeal('');
    dietcategoryIDforCartMeal('');
    userselectedgoalDiscription('');
    userExsists('No');
    selectedItem = null;
    cLearEvertyThing();
    userExsists('No');
    onboardDataList.clear();
    contains.clear();
    tempselectedIndex.clear();
    contains.clear();
    tempselectedIndex.clear();
    rebuilldwidget('rebuild');

    getOnBoardDataafterLogout();
  }

  ///// clear cache
  clearcache() {
    reviewStatus('0');
    userGoal('');
    dietcategoryID('');
    planID('');
    plandays('');
    selectedCategory('');
    planduration('');
    startDays('');
    plandayselected('');
    cartparam = {};
    mealCategory = {};
    cartStatus('Added');
    lineintemindex('0');
    selectedlineitemid('0');
    userGoalforCartMeal('');
    dietcategoryIDforCartMeal('');
    userselectedgoalDiscription('');
    selectedItem = null;
    contains.clear();
    tempselectedIndex.clear();
    contains.clear();
    tempselectedIndex.clear();
    rebuilldwidget('rebuild');
  }

  ///// delete item from cart
  ///
  void deleteCart(String param) async {
    print(param);

    var cartId = cartItems[0].id;
    var params = param + cartId.toString();
    EasyLoading.show();
    apiRepository.deleteCart(params).getResponse<Response<String>>((response) {
      debugPrint('add to cart response is $response');

      if (response.data['code'].toString() == '200') {
        cartCache();
        tempselectedIndex.clear();
        contains.clear();
        resetCart(false);
        Get.back();

        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Cart deleted");
      } else if (response.data['code'].toString() == '400') {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: response.data['message'].toString());
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  cartCache() {
    reviewStatus('0');

    userCartEmpty('0');
    cartparam = {};
    mealCategory = {};

    cartStatus('Added');
    lineintemindex('0');
    selectedlineitemid('0');
    userGoalforCartMeal('');
    dietcategoryIDforCartMeal('');
    selectedItem = null;
    contains.clear();
    tempselectedIndex.clear();
    contains.clear();
    tempselectedIndex.clear();
    rebuilldwidget('rebuild');
  }

  void getOnBoardDataafterLogout() async {
    EasyLoading.show();
    apiRepository
        .getOnboardData()
        .getResponse<Response<String>>((response) async {
      debugPrint('getOnBoardData data is $response');

      if (response.data['code'].toString() == '200') {
        await getGuestTokenInfo().then((value) {
          print('the cvalue is $value');
          if (value == true) {
            EasyLoading.dismiss();
            List listData = response.data['data'];

            var parsingList =
                listData.map((m) => OnBoardData.fromJson(m)).toList();
            onboardDataList.addAll(parsingList);
            Future.delayed(const Duration(seconds: 0), () {
              Get.offAllNamed('/GettingStartedScreen');
              cartItems.clear();
            });
          }
        });
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
