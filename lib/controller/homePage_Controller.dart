// // ignore_for_file: unnecessary_overrides, avoid_print

// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Trans;
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:eat_well/api-handler/api-extention.dart';

// import 'package:eat_well/helper/util.dart';
// import 'package:eat_well/widgets/mycustomtimemessage.dart';
// import '../api-handler/api-repo.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../theme/color_codes.dart';
// import 'package:timeago/timeago.dart' as timeago;
// import 'package:awesome_dialog/awesome_dialog.dart';

// class HomePageController extends GetxController {
//   ApiRepository apiRepository;
//   HomePageController(this.apiRepository);
//   PageController? pageController;
//   RxInt rxIndex = 0.obs;
//   var initialValeofToggle = 0.obs;
//   // var departmentlist = List<Department>.empty(growable: true).obs;
//   // var selectedList = List<Techniciandepartment>.empty(growable: true).obs;
//   // var loginUser = ''.obs;
//   // var Usertoken = 'empty'.obs;
//   // var UserData = List<Technician>.empty(growable: true).obs;
//   // var currentlanguage = ''.obs;
//   // var referalCode = ''.obs;
//   // var notificationList = List<Notificationss>.empty(growable: true).obs;
//   var notificationListisEmpty = false.obs;
//   var totalNotification = '0'.obs;
//   var walletammount = ''.obs;
//   var notificationcurrentpage = 1.obs;
//   var notificationlastpage = 1.obs;
//   var pagevalue = 1.obs;
//   var totalReviews = '0'.obs;
//   var totalRatting = '0'.obs;
//   var aboutusEng = ''.obs;
//   var aboutusArabic = ''.obs;
//   final box = GetStorage();
//   // var masterdata = List<Masterdata>.empty(growable: true).obs;

//   @override
//   void onInit() {
//     // var token = box.read('token');
//     // Usertoken(token);
//     // getMasterData();
//     // token == null ? ' ' : GetProfileData();
//     // token == null ? ' ' : getdep();
//     // token == null ? ' ' : getselectedUserDepartment();
//     // token == null ? ' ' : getNotification(1);
//     // token == null ? ' ' : getWallet();

//     // timeago.setLocaleMessages('ar', MyCustomMessages());

//     // super.onInit();
//     // currentlanguage(Get.context?.locale.toString());
//     // print('ccccc$currentlanguage');
//     // pageController = PageController();
//   }

//   refershpagecon() {
//     pageController = PageController();
//   }

//   // void getMasterData() {
//   //   apiRepository.getMaterData().getResponse<Response<String>>((response) {
//   //     debugPrint('Master data is $response');
//   //     List listData = response.data['master-data'];

//   //     var parsingList = listData.map((m) => Masterdata.fromJson(m)).toList();
//   //     masterdata.addAll(parsingList);
//   //   });
//   // }

//   // void GetAboutUsData() {
//   //   apiRepository.getaboutusData().getResponse<Response<String>>((response) {
//   //     print('The Response of about us api');
//   //     aboutusEng(response.data['aboutus'][0]['about_english'].toString());
//   //     aboutusArabic(response.data['aboutus'][0]['about_arabic'].toString());
//   //   });
//   // }

//   // void getData() {
//   //   print('getdataCAlled');
//   //   RequestedOrderController reqcontroller =
//   //       Get.find<RequestedOrderController>();

//   //   reqcontroller.getAlljobs(1);
//   //   reqcontroller.getAllNewjobs(1);
//   //   reqcontroller.getInprogreejob(1);
//   //   reqcontroller.getCompletedJobs(1);
//   //   getNotification(1);
//   //   getdep();
//   //   GetProfileData();
//   //   getselectedUserDepartment();

//   //   getWallet();
//   //   EasyLoading.dismiss();

//   //   Get.offAndToNamed('/homepage');
//   // }

//   // void GetProfileData() {
//   //   final box = GetStorage();
//   //   var token = box.read('token');

//   //   Usertoken(token);
//   //   apiRepository.GetUserProfile(token)
//   //       .getResponse<Response<String>>((response) {
//   //     print('The Response of profile api');
//   //     print(response.data);
//   //     if (response.data['technician'][0]['type'].toString() == '1') {
//   //       print('yes');
//   //       initialValeofToggle(1);
//   //       update();
//   //     } else {
//   //       initialValeofToggle(0);
//   //       update();
//   //     }

//   //     List listData = response.data['technician'];

//   //     var parsingList = listData.map((m) => Technician.fromJson(m)).toList();
//   //     UserData.addAll(parsingList);
//   //     getRatting();
//   //     EasyLoading.dismiss();

//   //     update();
//   //   });
//   //   EasyLoading.dismiss();
//   // }

//   // void bottomChange(index) {
//   //   print('sda $index');
//   //   pageController?.jumpToPage(index);
//   //   rxIndex.value = index;
//   // }

//   // void getRatting() {
//   //   apiRepository
//   //       .getRatting(UserData[0].id.toString())
//   //       .getResponse<Response<String>>((response) {
//   //     if (response.data['errer'] == false) {
//   //       if (response.data['technician_rattings'].toString().contains('[]')) {
//   //       } else {
//   //         List listData = response.data['technician_rattings'];
//   //         totalRatting(response.data['overallratting'].toString());
//   //         totalReviews(listData.length.toString());
//   //       }
//   //     }
//   //     print('totalrate$totalRatting');
//   //     print('totalrate$totalReviews');
//   //     update();
//   //   });
//   // }

//   // void getdep() {
//   //   var token = box.read('token');
//   //   print('getdep called');
//   //   apiRepository
//   //       .getAllDepartment(token)
//   //       .getResponse<Response<String>>((response) {
//   //     print('The Responsed of this api');
//   //     print(response.data);
//   //     var resData = Department.fromJson(response.data);
//   //     List listData = response.data['technicianalldepartments'];

//   //     var parsingList = listData.map((m) => Department.fromJson(m)).toList();

//   //     departmentlist.addAll(parsingList);

//   //     update();
//   //   });
//   // }

//   // /////// get user selected departments
//   // void getselectedUserDepartment() {
//   //   print('getdep called');
//   //   apiRepository.selectedUserdep().getResponse<Response<String>>((response) {
//   //     print('The Response of  selected dep  api');
//   //     print(response.data);

//   //     List listData = response.data['techniciandepartment'];

//   //     var parsingList =
//   //         listData.map((m) => Techniciandepartment.fromJson(m)).toList();

//   //     selectedList.addAll(parsingList);

//   //     update();
//   //   });
//   // }

//   // /////// get user sLogout
//   // void logout() {
//   //   EasyLoading.show();
//   //   print('logout called');
//   //   apiRepository.Logout().getResponse<Response<String>>((response) {
//   //     if (response.data['message'].toString() == 'Logout Successfully') {
//   //       EasyLoading.dismiss();

//   //       final box = GetStorage();
//   //       clearEverything();
//   //       box.remove('usercertificate');
//   //       box.remove('usercnic');
//   //       totalNotification('0');

//   //       // box.remove('deviceregistrationID');
//   //       box.remove('token');
//   //       Get.offAllNamed('/login');
//   //     } else {
//   //       EasyLoading.dismiss();
//   //       showSnackBarTwo('Error', 'Please try again Later', Colors.white);
//   //     }
//   //     update();
//   //   });
//   // }

//   // /////// get wallet
//   // void getWallet() {
//   //   walletammount('0');
//   //   print('logout called');
//   //   apiRepository.getWallet().getResponse<Response<String>>((response) {
//   //     if (response.data != null) {
//   //       walletammount(response.data['wallet'].toString());
//   //       print('wallet is ${response.data['wallet'].toString()}');
//   //     } else {
//   //       showSnackBarTwo('Error', 'Please try again Later', Colors.white);
//   //     }
//   //     update();
//   //   });
//   // }

//   // /////// get user selected departments
//   // void deleteaccount(String number, BuildContext context) {
//   //   print('phone number is $number');
//   //   print('delete called');
//   //   apiRepository
//   //       .deleteaccount(number)
//   //       .getResponse<Response<String>>((response) {
//   //     print('The Response of  delete account  api');
//   //     print(response.data);
//   //     if (response.data['message'].toString() == 'success') {
//   //       HomePageController controller = Get.find<HomePageController>();
//   //       final box = GetStorage();
//   //       controller.clearEverything();
//   //       context.locale = const Locale('en');
//   //       box.remove('token');
//   //       Get.offAllNamed('/login');
//   //     } else {
//   //       showSnackBarTwo('Error', 'Please try again Later', Colors.white);
//   //     }

//   //     update();
//   //   });
//   // }

//   // /// update technician department
//   // void UpdateDepartment(Map<String, dynamic> param) {
//   //   EasyLoading.show();
//   //   print('getdep called');
//   //   apiRepository.updateDep(param).getResponse<Response<String>>((response) {
//   //     print('The Response of  selected dep  api');
//   //     print(response.data);
//   //     if (response.data['errer'] == false) {
//   //       selectedList.clear();
//   //       getselectedUserDepartment();
//   //       EasyLoading.dismiss();

//   //       // Get.defaultDialog(
//   //       //     title: 'Updated',
//   //       //     titleStyle: TextStyle(fontSize: 18.sp),
//   //       //     barrierDismissible: true,
//   //       //     buttonColor: primaryColor,
//   //       //     middleText: '${response.data['message']}',
//   //       //     textConfirm: 'Ok',
//   //       //     confirmTextColor: Colors.white,
//   //       //     cancelTextColor: Colors.black,
//   //       //     radius: 10,
//   //       //     contentPadding: const EdgeInsets.all(20),
//   //       //     onConfirm: () {
//   //       //       Get.back();
//   //       //       Get.back();
//   //       //     },
//   //       //     backgroundColor: const Color.fromARGB(255, 255, 248, 229));

//   //       AwesomeDialog(
//   //         context: Get.context!,
//   //         dialogType: DialogType.success,
//   //         borderSide: const BorderSide(
//   //           color: greenColor,
//   //           width: 2,
//   //         ),
//   //         width: 400.w,
//   //         buttonsBorderRadius: const BorderRadius.all(
//   //           Radius.circular(2),
//   //         ),
//   //         dismissOnTouchOutside: false,
//   //         dismissOnBackKeyPress: false,
//   //         headerAnimationLoop: false,
//   //         animType: AnimType.bottomSlide,
//   //         title: 'Updated',
//   //         desc: '${response.data['message']}',
//   //         showCloseIcon: true,
//   //         // btnCancelText: 'CANCEL'.tr(),
//   //         btnOkText: 'Ok'.tr(),
//   //         // btnCancelOnPress: () {},
//   //         btnOkOnPress: () {
//   //           Get.back();
//   //           Get.back();
//   //         },
//   //       ).show();
//   //     } else {
//   //       EasyLoading.dismiss();

//   //       showSnackBarTwo('Error', 'Something Went Wrong', Colors.transparent);
//   //     }

//   //     update();
//   //   });
//   // }

//   // void makeOffer(Map<String, dynamic> param) {
//   //   EasyLoading.show();

//   //   apiRepository.makeOffer(param).getResponse<Response<String>>((response) {
//   //     print('The Response of  offer  api');
//   //     print(response.data);
//   //     if (response.data['message'].toString() == 'Offer Create Successfully') {
//   //       EasyLoading.dismiss();
//   //       AwesomeDialog(
//   //         context: Get.context!,
//   //         dialogType: DialogType.success,
//   //         borderSide: const BorderSide(
//   //           color: greenColor,
//   //           width: 2,
//   //         ),
//   //         width: 320,
//   //         buttonsBorderRadius: const BorderRadius.all(
//   //           Radius.circular(2),
//   //         ),
//   //         dismissOnTouchOutside: true,
//   //         dismissOnBackKeyPress: false,
//   //         headerAnimationLoop: false,
//   //         animType: AnimType.bottomSlide,
//   //         title: 'Success'.tr(),
//   //         desc: '${response.data['message']}',
//   //         showCloseIcon: true,
//   //         btnOkText: 'Ok'.tr(),
//   //         btnOkOnPress: () {
//   //           Get.back();
//   //           Get.back();
//   //           Get.back();
//   //           RequestedOrderController recon =
//   //               Get.find<RequestedOrderController>();
//   //           recon.refershEverything();
//   //         },
//   //       ).show();
//   //       // Get.defaultDialog(
//   //       //     title: 'Successfull',
//   //       //     titleStyle: TextStyle(fontSize: 18.sp),
//   //       //     barrierDismissible: true,
//   //       //     buttonColor: primaryColor,
//   //       //     middleText: '${response.data['message']}',
//   //       //     textConfirm: 'Ok',
//   //       //     confirmTextColor: Colors.white,
//   //       //     cancelTextColor: Colors.black,
//   //       //     radius: 10,
//   //       //     contentPadding: const EdgeInsets.all(20),
//   //       //     onConfirm: () {
//   //       //       Get.back();
//   //       //       Get.back();
//   //       //       Get.back();
//   //       //       RequestedOrderController recon =
//   //       //           Get.find<RequestedOrderController>();
//   //       //       recon.refershEverything();
//   //       //     },
//   //       //     backgroundColor: const Color.fromARGB(255, 255, 248, 229));
//   //     } else {
//   //       EasyLoading.dismiss();

//   //       showSnackBarTwo('Error', 'Something Went Wrong', Colors.transparent);
//   //     }

//   //     update();
//   //   });
//   // }

//   // void editOffer(Map<String, dynamic> param, String JobcardId, String token) {
//   //   EasyLoading.show();

//   //   apiRepository.editOffer(param).getResponse<Response<String>>((response) {
//   //     print('The Response of  offer  api');
//   //     print(response.data);
//   //     if (response.data['message'].toString() == 'Offer Update Successfully') {
//   //       EasyLoading.dismiss();
//   //       ViewOfferController viewcontroller = Get.find<ViewOfferController>();
//   //       viewcontroller.refershGetOffer(JobcardId, token);
//   //       AwesomeDialog(
//   //         context: Get.context!,
//   //         dialogType: DialogType.success,
//   //         borderSide: const BorderSide(
//   //           color: greenColor,
//   //           width: 2,
//   //         ),
//   //         width: 400.w,
//   //         buttonsBorderRadius: const BorderRadius.all(
//   //           Radius.circular(2),
//   //         ),
//   //         dismissOnTouchOutside: false,
//   //         dismissOnBackKeyPress: false,
//   //         headerAnimationLoop: false,
//   //         animType: AnimType.bottomSlide,
//   //         title: 'Successfull',
//   //         desc: '${response.data['message']}',
//   //         showCloseIcon: false,
//   //         // btnCancelText: 'CANCEL'.tr(),
//   //         btnOkText: 'Ok'.tr(),
//   //         // btnCancelOnPress: () {},
//   //         btnOkOnPress: () {
//   //           Get.back();
//   //           // Get.back();
//   //         },
//   //       ).show();
//   //       // Get.defaultDialog(
//   //       //     title: 'Successfull',
//   //       //     titleStyle: TextStyle(fontSize: 18.sp),
//   //       //     barrierDismissible: true,
//   //       //     buttonColor: primaryColor,
//   //       //     middleText: '${response.data['message']}',
//   //       //     textConfirm: 'Ok',
//   //       //     confirmTextColor: Colors.white,
//   //       //     cancelTextColor: Colors.black,
//   //       //     radius: 10,
//   //       //     contentPadding: const EdgeInsets.all(20),
//   //       //     onConfirm: () {
//   //       //       Get.back();
//   //       //       Get.back();
//   //       //     },
//   //       //     backgroundColor: const Color.fromARGB(255, 255, 248, 229));
//   //     } else {
//   //       EasyLoading.dismiss();

//   //       showSnackBarTwo('Error', 'Something Went Wrong', Colors.transparent);
//   //     }

//   //     update();
//   //   });
//   // }

//   // void clearEverything() {
//   //   rxIndex(0);
//   //   initialValeofToggle(0);
//   //   departmentlist.clear();
//   //   selectedList.clear();

//   //   UserData.clear();
//   //   RequestedOrderController reqController =
//   //       Get.find<RequestedOrderController>();
//   //   reqController.clearEverything();
//   // }

//   ///GET Notificationss
//   void getNotification(pagevalue) {
//     print('received page $pagevalue');
//     // EasyLoading.show();
//     final box = GetStorage();
//     var token = box.read('token');
//     apiRepository
//         .getNotifications(token + '?page=$pagevalue')
//   //       .getResponse<Response<String>>((response) {
//   //     if (response.data['Notifications']['data'].toString().contains('[]')) {
//   //       notificationListisEmpty(true);
//   //     } else {
//   //       if (response.data['errer'] == false) {
//   //         notificationListisEmpty(false);
//   //         notificationcurrentpage(
//   //             response.data['Notifications']['current_page']);
//   //         notificationlastpage(response.data['Notifications']['last_page']);

//   //         totalNotification(response.data['Totalnotification'].toString());
//   //         print('hello ${response.data['Totalnotification'].toString()}');
//   //         List listData = response.data['Notifications']['data'];

//   //         var parsingList =
//   //             listData.map((m) => Notificationss.fromJson(m)).toList();
//   //         notificationList.addAll(parsingList);

//   //         EasyLoading.dismiss();
//   //       } else {
//   //         EasyLoading.dismiss();
//   //         showSnackBarTwo(
//   //             'Warning', "Something Went Wrong Try Again Later", Colors.white);
//   //       }
//   //     }


//   //     update();
//   //   });
//   // }

//   // void paginationforNotification() {
//   //   print('current page ${notificationcurrentpage.value}');
//   //   print('last page ${notificationlastpage.value}');
//   //   if (notificationcurrentpage.value < notificationlastpage.value) {
//   //     EasyLoading.show();
//   //     notificationcurrentpage(notificationcurrentpage.value + 1);
//   //     getNotification(notificationcurrentpage);
//   //     print('value is${notificationcurrentpage.value}');
//   //     print('maxx reaches');
//   //   }
//   // }

//   // ///GET Notificationss
//   // void markasRead() {
//   //   EasyLoading.show();
//   //   final box = GetStorage();
//   //   var token = box.read('token');
//   //   apiRepository.MarkAsRead(token).getResponse<Response<String>>((response) {
//   //     if (response.data['errer'] == false) {
//   //       notificationList.clear();
//   //       getNotification(pagevalue);

//   //       EasyLoading.dismiss();
//   //     } else {
//   //       EasyLoading.dismiss();
//   //       showSnackBarTwo(
//   //           'Warning', "Something Went Wrong Try Again Later", Colors.white);
//   //     }

//   //     update();
//   //   });
//   // }

// }
