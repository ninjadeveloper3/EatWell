// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/mealCategorySelectionModel.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/DeliveryDetails/deliveryDetailController.dart';
import 'package:eat_well/views/UserCartFlow/DeliveryDetails/deliverydetail.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/mealdetails.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:eat_well/views/animations/fade_animation.dart';
import 'package:eat_well/views/animations/slide_animation.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:eat_well/widgets/datepick.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class SelectDailyMealScreen extends StatefulWidget {
  @override
  _SelectDailyMealScreenState createState() => _SelectDailyMealScreenState();
}

class _SelectDailyMealScreenState extends State<SelectDailyMealScreen> {
  final ScrollController _controllerOne = ScrollController();
  final DatePickerController _controller = DatePickerController();
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  DailyMealSelectController controller = Get.find<DailyMealSelectController>();
  var Scrollcontroller = ScrollController();
  DateRangePickerController? dateRangePickerController;
  DateTime todaysDate = DateTime.now();
  var after2Days;
  var selecteddate;
  bool showselecteddateColor = false;

  late DateTime _selectedValue;

  @override
  void initState() {
    after2Days = todaysDate.add(const Duration(days: 2));

    print('the startdate is :${initialcon.startDays.value.toString()} ');
    _selectedValue = DateTime.parse(initialcon.startDays.toString());

    super.initState();
  }

  @override
  void dispose() {
    if (initialcon.userExsists.value == 'Yes') {
      Get.delete<DailyMealSelectController>();
    }
    super.dispose();
  }

  Future<bool> onWillPop(context) async {
    initialcon.userExsists.value.toString() == 'Yes'
        ? Get.offAllNamed('/HomeDashboard')
        : Get.offAllNamed('/GuestDashboard');

    return false;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Obx(
              () => Appbar(
                context: context,
                title: initialcon.reviewStatus.value.toString() == '1'
                    ? 'CART'
                    : 'Daily',
                lighttitle: initialcon.reviewStatus.value.toString() == '1'
                    ? 'DETAIL'
                    : 'Meal',
              ),
            )),
        backgroundColor: Colors.white,
        body: Obx(
          () => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    Assets.BgDashBoard_Image,
                  ),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 30 : 0,
                        right: Get.locale.toString() == 'ar' ? 30 : 0,
                        top: 20),
                    child: Row(
                      children: [
                        Text(
                          initialcon.reviewStatus.value.toString() == '1'
                              ? 'Your Plan Contains'.tr()
                              : "Select your preferred".tr(),
                          style: TextStyle(
                            color: Col.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.030,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                        Text(
                          initialcon.rebuilldwidget.value,
                          style: const TextStyle(color: Colors.transparent),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Get.locale.toString() == 'en' ? 30 : 0,
                      right: Get.locale.toString() == 'ar' ? 30 : 0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          initialcon.reviewStatus.value.toString() == '1'
                              ? '${controller.totalcalories.value} CAL'
                              : "Menu Items".tr(),
                          style: TextStyle(
                            color: Col.blue,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 30 : 0,
                        right: Get.locale.toString() == 'ar' ? 30 : 0,
                        top: 5),
                    child: Row(
                      children: [
                        initialcon.cartItems.isEmpty
                            ? const Text('')
                            : Text(
                                initialcon.reviewStatus.value.toString() == '1'
                                    ? Get.locale.toString() == 'en'
                                        ? 'You have selected ${initialcon.cartItems[0].mealCategories.length} Meals Per Day'
                                        : "لقد اخترت ${initialcon.cartItems[0].mealCategories.length} وجبات في اليوم"
                                    : Get.locale.toString() == 'en'
                                        ?

                                        // "Choose from the list ${initialcon.plandays} Day Plan",
                                        "Choose from the list ${initialcon.plandayselected.value} Day Plan"
                                        : 'اختر من القائمة ${initialcon.plandayselected.value} خطة اليوم',
                                style: TextStyle(
                                  color: Col.black.withOpacity(0.6),
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.015,
                                  fontFamily: Get.locale.toString() == 'en'
                                      ? Assets.Product_Sans_Regular
                                      : Assets.TheSans_plain,
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      initialcon.reviewStatus.value.toString() == '1'
                          ? Container()
                          : Get.bottomSheet(
                              SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0),
                                  ),
                                  child: Container(
                                    color: Colors.white,
                                    height: 400.h,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 30, right: 30, top: 10),
                                            child: SfDateRangePicker(
                                              minDate: after2Days,
                                              showNavigationArrow: true,

                                              onSelectionChanged:
                                                  (DateRangePickerSelectionChangedArgs
                                                      args) {
                                                selecteddate = args.value
                                                    .toString()
                                                    .substring(0, 10);
                                                print(selecteddate);
                                              },
                                              controller:
                                                  dateRangePickerController,
                                              monthCellStyle:
                                                  DateRangePickerMonthCellStyle(
                                                todayTextStyle: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black),
                                                leadingDatesDecoration:
                                                    BoxDecoration(
                                                        color: Colors.black,
                                                        border: Border.all(
                                                            color: Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        shape: BoxShape.circle),
                                              ),

                                              todayHighlightColor:
                                                  Colors.transparent,
                                              view: DateRangePickerView.month,
                                              selectionMode:
                                                  DateRangePickerSelectionMode
                                                      .single,
                                              selectionColor:
                                                  const Color.fromRGBO(
                                                      228, 212, 93, 1),

                                              startRangeSelectionColor:
                                                  const Color.fromRGBO(
                                                      228, 212, 93, 1),

                                              endRangeSelectionColor:
                                                  const Color.fromRGBO(
                                                      228, 212, 93, 1),
                                              //rangeSelectionColor: Color.fromRGBO(228, 212, 93, 1),
                                              selectionTextStyle:
                                                  const TextStyle(
                                                      color: Colors.black),
                                              rangeTextStyle: const TextStyle(
                                                  color: Colors.black),
                                              // onSelectionChanged: _onchanged,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 22.w),
                                            child: submitButton(
                                                onPress: () {
                                                  if (selecteddate == null ||
                                                      selecteddate.toString() ==
                                                          'null' ||
                                                      selecteddate.toString() ==
                                                          '') {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Please select any date"
                                                                .tr());
                                                  } else {
                                                    controller
                                                        .updateStartdate(
                                                            selecteddate,
                                                            initialcon
                                                                .cartItems[0]
                                                                .id)
                                                        .then((value) {
                                                      _selectedValue =
                                                          DateTime.parse(
                                                              selecteddate);
                                                      showselecteddateColor =
                                                          true;

                                                      print(
                                                          'the value of selected change date is $value');
                                                      // if (value == true) {
                                                      //   Future.delayed(
                                                      //       const Duration(
                                                      //           seconds: 2),
                                                      //       () {
                                                      //     _selectedValue =
                                                      //         DateTime.parse(
                                                      //             initialcon
                                                      //                 .startDays
                                                      //                 .value
                                                      //                 .toString());
                                                      //     setState(() {
                                                      //       showselecteddateColor =
                                                      //           true;
                                                      //     }); // Prints after 1 second.
                                                      //   });
                                                      // }
                                                    });
                                                  }
                                                },
                                                title: 'Change Date'.tr(),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.060,
                                                width: 200.w),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 30 : 0,
                        right: Get.locale.toString() == 'ar' ? 30 : 0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat.yMMMMd().format(_selectedValue),
                            style: TextStyle(
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Bold
                                  : Assets.TheSans_Bold,
                              wordSpacing: 3.0,
                            ),
                            // day+month+year
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          initialcon.reviewStatus.value.toString() == '1'
                              ? Container()
                              : const Icon(Icons.edit)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: RawScrollbar(
                      controller: Scrollcontroller,
                      thumbVisibility: true,
                      thumbColor:
                          initialcon.reviewStatus.value.toString() == '1'
                              ? Col.darkgreen
                              : Col.dullyellow,
                      radius: const Radius.circular(20),
                      thickness: 3,

                      //  controller: Scrollcontroller,
                      // thumbVisibility: true,
                      child: Column(
                        children: [
                          FadeAnimation(
                            child: DatePicker(
                              DateTime.parse(
                                  initialcon.startDays.value.toString()),
                              locale:
                                  Get.locale.toString() == 'en' ? 'en' : 'ar',
                              width: 60,
                              showRedColorondates: controller.unselecteddate,
                              height: 100,
                              selecteddateColor: showselecteddateColor,
                              controller: _controller,
                              initialSelectedDate: _selectedValue,
                              selectionColor:
                                  initialcon.reviewStatus.toString() == '1'
                                      ? Col.darkgreen
                                      : Col.dullyellow,
                              selectedTextColor: Colors.white,
                              // daysCount: 7,
                              daysCount: int.parse(
                                  initialcon.plandayselected.value.toString()),

                              scrolcontroller: Scrollcontroller,

                              onDateChange: (date) {
                                showselecteddateColor = false;
                                if (controller.unselecteddate.contains(date)) {
                                  // controller.unselecteddate.remove(date);
                                }
                                initialcon.tempselectedIndex.clear();
                                initialcon.resetCart(false);
                                _selectedValue = date;
                                controller.refershMealitems();
                                // New date selecteds
                                // setState(() {

                                // });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // const Divider(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  initialcon.cartItems.isEmpty
                      ? Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: LoadingWidget(
                                      isImage: true,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 100,
                          child: SlideAnimation(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: initialcon
                                    .cartItems[0].mealCategories.length,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                initialcon.lineintemindex(
                                                    index.toString());
                                                initialcon.tempselectedIndex
                                                    .clear();
                                                initialcon.selectedItem =
                                                    MealCategorySelectionModel(
                                                        id: initialcon
                                                            .cartItems[0]
                                                            .mealCategories[
                                                                index]
                                                            .mealCategory
                                                            .id,
                                                        name: initialcon
                                                            .cartItems[0]
                                                            .mealCategories[
                                                                index]
                                                            .mealCategory
                                                            .name
                                                            .toString(),
                                                        selectedIndex: index,
                                                        mealCatID: initialcon
                                                            .cartItems[0]
                                                            .mealCategories[
                                                                index]
                                                            .id,
                                                        lineitems: initialcon
                                                            .cartItems[0]
                                                            .mealCategories[
                                                                index]
                                                            .lineItems);
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: Get.locale.toString() ==
                                                        'en'
                                                    ? 30
                                                    : 0,
                                                right: Get.locale.toString() ==
                                                        'ar'
                                                    ? 30
                                                    : 0,
                                              ),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    index.toString() ==
                                                            initialcon
                                                                .selectedItem!
                                                                .selectedIndex
                                                                .toString()
                                                        ? BoxShadow(
                                                            color: Col.blue
                                                                .withOpacity(
                                                                    .2),
                                                            spreadRadius: -1,
                                                            blurRadius: 20,
                                                            offset:
                                                                const Offset(
                                                                    12, 1))
                                                        : BoxShadow(
                                                            color: Col.WHITE
                                                                .withOpacity(
                                                                    .0),
                                                            spreadRadius: 1,
                                                            blurRadius: 20,
                                                            offset:
                                                                const Offset(
                                                                    12, 1))
                                                    // changes position of shadow
                                                  ],
                                                  color: initialcon.reviewStatus
                                                                  .value
                                                                  .toString() ==
                                                              '1' &&
                                                          index.toString() ==
                                                              initialcon
                                                                  .selectedItem!
                                                                  .selectedIndex
                                                                  .toString()
                                                      ? Col.darkgreen
                                                      : index.toString() ==
                                                              initialcon
                                                                  .selectedItem!
                                                                  .selectedIndex
                                                                  .toString()
                                                          ? Col.dullyellow
                                                          : Col.lightgrey,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(8),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: SvgPicture.network(
                                                      '${EnvironmentConstants.baseUrl}/${initialcon.cartItems[0].mealCategories[index].mealCategory.image}',
                                                      height: 25.w,
                                                      width: 25.w,
                                                      color: index.toString() ==
                                                              initialcon
                                                                  .selectedItem!
                                                                  .selectedIndex
                                                                  .toString()
                                                          ? Col.WHITE
                                                          : Col.black,
                                                      placeholderBuilder:
                                                          (context) => SizedBox(
                                                              height: 25.w,
                                                              width: 25.w,
                                                              child:
                                                                  const LoadingWidget(
                                                                isImage: true,
                                                              )),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Get.locale.toString() == 'en'
                                                ? 30
                                                : 0,
                                            right: Get.locale.toString() == 'ar'
                                                ? 30
                                                : 0,
                                            top: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              initialcon
                                                  .cartItems[0]
                                                  .mealCategories[index]
                                                  .mealCategory
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: Get.locale
                                                            .toString() ==
                                                        'en'
                                                    ? Assets.Product_Sans_Bold
                                                    : Assets.TheSans_Bold,
                                                color: index.toString() ==
                                                        initialcon.selectedItem!
                                                            .selectedIndex
                                                            .toString()
                                                    ? Col.blue
                                                    : Col.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                          ),
                        ),
                  Obx((() => Padding(
                        padding: EdgeInsets.only(
                            left: Get.locale.toString() == 'en' ? 10 : 0,
                            top: 0,
                            right: Get.locale.toString() == 'ar' ? 10 : 0),
                        child: SizedBox(
                          height: 400,
                          // color: Colors.yellow,
                          child: controller.mealData.isEmpty &&
                                  controller.mealdataisEmpty.value.toString() ==
                                      'false'
                              ? const LoadingWidget(
                                  isImage: true,
                                )
                              : controller.mealData.isEmpty &&
                                      controller.mealdataisEmpty.value
                                              .toString() ==
                                          'true'
                                  ? Center(
                                      child: SizedBox(
                                        height: 250.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(
                                              'assets/lottie/nodata.json',
                                              // width: 200,
                                              height: 200,
                                              fit: BoxFit.fill,
                                            ),
                                            Text('No meal item found'.tr())
                                          ],
                                        ),
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      controller: _controllerOne,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.mealData.length,
                                      itemBuilder: (context, ind) {
                                        print(controller.mealData[ind]
                                            .mealCategories[0].id);
                                        print(initialcon.selectedItem!.id);
                                        return controller
                                                .mealData[ind].mealCategories
                                                .any((element) =>
                                                    element.id ==
                                                    initialcon.selectedItem!.id)
                                            ? Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: Get.locale
                                                                    .toString() ==
                                                                'en'
                                                            ? 10
                                                            : 0,
                                                        right: Get.locale
                                                                    .toString() ==
                                                                'ar'
                                                            ? 10
                                                            : 0,
                                                        top: 0),
                                                    child: KitoDietPlanCard(
                                                        controller,
                                                        ind,
                                                        _selectedValue,
                                                        initialcon),
                                                  ),
                                                  Container(
                                                    width: initialcon
                                                                .reviewStatus
                                                                .value ==
                                                            '1'
                                                        ? 0
                                                        : 20,
                                                  )
                                                ],
                                              )
                                            : Container();
                                      }),
                        ),
                      ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: initialcon.reviewStatus.value.toString() == '1'
                        ? false
                        : true,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: submitButton(
                            onPress: () {
                              if (initialcon.cartItems[0].checkoutFlag) {
                                controller.unselecteddate.clear();
                              }
                              // print(initialcon.cartStatus.value);
                              initialcon.cartItems[0].checkoutFlag
                                  ? initialcon.reviewStatus('1')
                                  : controller.checkAlldates(
                                      initialcon.cartItems[0].id, context);
                            },
                            title: 'Continue'.tr(),
                            height: MediaQuery.of(context).size.height * 0.060,
                            width: 300.w),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: initialcon.reviewStatus.value.toString() == '0'
                        ? false
                        : true,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            submitButton(
                                onPress: () {
                                  initialcon.cartItems[0].checkoutFlag
                                      ? initialcon.reviewStatus('0')
                                      : print('Please complete cart first');
                                },
                                title: 'Review Menu'.tr(),
                                height:
                                    MediaQuery.of(context).size.height * 0.060,
                                width: 150.w),
                            submitButton(
                                onPress: () {
                                  if (initialcon.cartItems[0].checkoutFlag) {
                                    if (initialcon.userExsists.value
                                            .toString() ==
                                        'No') {
                                      Get.toNamed('/SignUp', arguments: [
                                        {'isSignin': false, "guestpopup": true}
                                      ]);
                                    } else {
                                      Get.put(
                                          DeliveryDetailController(Get.find()));
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const DeilveryDetailScreen(),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    }
                                  }
                                },
                                title: 'Check out'.tr(),
                                height:
                                    MediaQuery.of(context).size.height * 0.060,
                                width: 150.w),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class KitoDietPlanCard extends StatefulWidget {
  DailyMealSelectController controller;
  int index;
  DateTime selectedDate;
  InitialStatusController initialcon;
  KitoDietPlanCard(
      this.controller, this.index, this.selectedDate, this.initialcon,
      {Key? key})
      : super(key: key);
  @override
  _KitoDietPlanCardState createState() => _KitoDietPlanCardState();
}

class _KitoDietPlanCardState extends State<KitoDietPlanCard> {
  late List<int> contains = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contains.clear();
    for (var i = 0; i < widget.initialcon.selectedItem!.lineitems.length; i++) {
      if (widget.initialcon.selectedItem!.lineitems[i].dietCategoryMealItemsId
                  .toString() ==
              widget.controller.mealData[widget.index].details[0].id
                  .toString() &&
          widget.initialcon.selectedItem!.lineitems[i].mealItemId.toString() ==
              widget.controller.mealData[widget.index].details[0].mealItemsId
                  .toString() &&
          widget.initialcon.selectedItem!.lineitems[i].orderDate ==
              widget.selectedDate.toString().substring(0, 10)) {
        widget.initialcon.selectedlineitemid(
            widget.initialcon.selectedItem!.lineitems[i].id.toString());
      }
      //   print(
      //       'the id is ${widget.initialcon.selectedItem!.lineitems[i].dietCategoryMealItemsId}');
      //   print(
      //       'the id is ${widget.controller.mealData[widget.index].details[0].id.toString()}');
      //   print(
      //       'the id is ${widget.initialcon.selectedItem!.lineitems[i].mealItemId.toString()}');
      //   print(
      //       'the id is ${widget.controller.mealData[widget.index].details[0].mealItemsId.toString()}');

      // if (widget.initialcon.selectedItem!.lineitems[i]
      //             .dietCategoryMealItemsId ==
      //         widget.controller.mealData[widget.index].details[0].id &&
      //     widget.initialcon.selectedItem!.lineitems[i].mealItemId ==
      //         widget.controller.mealData[widget.index].details[0].id
      //             .toString() &&
      //     widget.initialcon.selectedItem!.lineitems[i].orderDate ==
      //         widget.selectedDate.toString().substring(0, 10)) {
      //   widget.initialcon.selectedlineitemid(
      //       widget.initialcon.selectedItem!.lineitems[i].id.toString());
      // } else {
      //   print('the is is null');
      // }
    }
    final bool productIsInList = widget.initialcon.selectedItem!.lineitems.any(
        (product) =>
            product.dietCategoryMealItemsId.toString() ==
                widget.controller.mealData[widget.index].details[0].id
                    .toString() &&
            product.mealItemId.toString() ==
                widget.controller.mealData[widget.index].details[0].mealItemsId
                    .toString() &&
            product.orderDate ==
                widget.selectedDate.toString().substring(0, 10));
    if (productIsInList) {
      print('yes exsists');
      contains.add(widget.controller.mealData[widget.index].id +
          widget.initialcon.selectedItem!.mealCatID);
    } else {
      contains.add(-1);
    }

    return contains.contains(widget.controller.mealData[widget.index].id +
                widget.initialcon.selectedItem!.mealCatID) ||
            widget.initialcon.tempselectedIndex.contains(
                    widget.controller.mealData[widget.index].id +
                        widget.initialcon.selectedItem!.mealCatID) &&
                widget.initialcon.reviewStatus.value == '1'
        ? Stack(fit: StackFit.passthrough, children: [
            InkWell(
              onTap: () {
                Map<String, dynamic> param = {
                  "orderMealCatId": widget.initialcon.selectedItem!.mealCatID,
                  "dietCategoryMealItemsId":
                      widget.controller.mealData[widget.index].details[0].id,
                  "orderDate": widget.selectedDate.toString().substring(0, 10)
                };

                if (widget.initialcon.userExsists.value.toString() == 'Yes') {
                  widget.controller.param1 = {
                    'selectedmeal': widget.controller.mealData[widget.index],
                    'selecteddate': widget.selectedDate,
                    'index': widget.index,
                    'isAdded': contains.contains(widget
                                    .controller.mealData[widget.index].id +
                                widget.initialcon.selectedItem!.mealCatID) ||
                            widget.initialcon.tempselectedIndex.contains(
                                widget.controller.mealData[widget.index].id +
                                    widget.initialcon.selectedItem!.mealCatID)
                        ? 1
                        : 0
                  };

                  widget.controller.param2 = param;

                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: MealDetails(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                } else {
                  Get.toNamed('/dailymealDetails', arguments: [
                    {
                      'selectedmeal': widget.controller.mealData[widget.index],
                      'selecteddate': widget.selectedDate,
                      'index': widget.index,
                      'isAdded': contains.contains(widget
                                      .controller.mealData[widget.index].id +
                                  widget.initialcon.selectedItem!.mealCatID) ||
                              widget.initialcon.tempselectedIndex.contains(
                                  widget.controller.mealData[widget.index].id +
                                      widget.initialcon.selectedItem!.mealCatID)
                          ? 1
                          : 0
                    },
                    param
                  ]);
                }
              },
              child: FadeAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.84,
                    width: MediaQuery.of(context).size.width *
                        0.60, //MediaQuery.of(context).size.width * 0.56,
                    decoration: BoxDecoration(
                      color: Col.lightgrey,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        width: 2,
                        color: widget.initialcon.reviewStatus.value
                                    .toString() ==
                                '1'
                            ? Colors.transparent
                            : contains.contains(widget.controller
                                            .mealData[widget.index].id +
                                        widget.initialcon.selectedItem!
                                            .mealCatID) ||
                                    widget.initialcon.tempselectedIndex
                                        .contains(widget.controller
                                                .mealData[widget.index].id +
                                            widget.initialcon.selectedItem!
                                                .mealCatID)
                                ? Col.darkgreen
                                : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: Get.locale.toString() == 'en'
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : 0,
                              right: Get.locale.toString() == 'ar'
                                  ? MediaQuery.of(context).size.width * 0.05
                                  : 0,
                              bottom: MediaQuery.of(context).size.width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                // color: Colors.amber,
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Text(
                                  widget.controller.mealData[widget.index].name,
                                  style: TextStyle(
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Bold
                                        : Assets.TheSans_Bold,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Flexible(
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.40,
                                  child: Text(
                                    widget.controller.mealData[widget.index]
                                        .description,
                                    style: TextStyle(
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Regular
                                          : Assets.TheSans_plain,
                                      fontSize: 10,
                                      color: Col.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 17,
                              ),
                              Visibility(
                                visible:
                                    widget.initialcon.reviewStatus.value == '1'
                                        ? true
                                        : false,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Assets.Calendar_Image,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.017,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat.yMMMMd()
                                            .format(widget.selectedDate),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Col.black,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.017,
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Product_Sans_Regular
                                                  : Assets.TheSans_plain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        widget.initialcon.reviewStatus.value.toString() == '1'
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  if (contains.contains(widget.controller
                                          .mealData[widget.index].id +
                                      widget.initialcon.selectedItem!
                                          .mealCatID)) {}

                                  Map<String, dynamic> param = {
                                    "orderMealCatId": widget
                                        .initialcon.selectedItem!.mealCatID,
                                    "dietCategoryMealItemsId": widget.controller
                                        .mealData[widget.index].details[0].id,
                                    "orderDate": widget.selectedDate
                                        .toString()
                                        .substring(0, 10),
                                    // 'mealitemid': widget.controller
                                    //     .mealData[widget.index].details[0].id
                                  };
                                  String params = '?orderLineItemId='
                                      '${widget.initialcon.selectedlineitemid.value}';

                                  print(widget.initialcon.selectedItem!
                                      .lineitems.length);

                                  if (contains.contains(widget.controller
                                              .mealData[widget.index].id +
                                          widget.initialcon.selectedItem!
                                              .mealCatID) ||
                                      widget.initialcon.tempselectedIndex
                                          .contains(widget.controller
                                                  .mealData[widget.index].id +
                                              widget.initialcon.selectedItem!
                                                  .mealCatID)) {
                                    contains.remove(widget.controller
                                            .mealData[widget.index].id +
                                        widget.initialcon.selectedItem!
                                            .mealCatID);

                                    widget.initialcon.tempselectedIndex.remove(
                                        widget.controller.mealData[widget.index]
                                                .id +
                                            widget.initialcon.selectedItem!
                                                .mealCatID);

                                    widget.initialcon.deleteMealItem(
                                        params,
                                        widget.controller.mealData[widget.index]
                                                .id +
                                            widget.initialcon.selectedItem!
                                                .mealCatID,
                                        context);
                                  } else {
                                    widget.initialcon.addtoCart(
                                      param,
                                      widget.controller.mealData[widget.index]
                                              .id +
                                          widget.initialcon.selectedItem!
                                              .mealCatID,
                                    );
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    BounceInDown(
                                      child: Container(
                                          height: 52,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: contains.contains(widget
                                                            .controller
                                                            .mealData[
                                                                widget.index]
                                                            .id +
                                                        widget
                                                            .initialcon
                                                            .selectedItem!
                                                            .mealCatID) ||
                                                    widget.initialcon
                                                        .tempselectedIndex
                                                        .contains(widget
                                                                .controller
                                                                .mealData[widget
                                                                    .index]
                                                                .id +
                                                            widget
                                                                .initialcon
                                                                .selectedItem!
                                                                .mealCatID)
                                                ? Col.darkgreen
                                                : Col.yellow,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Get.locale.toString() ==
                                                      'en'
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                              topRight: Get.locale.toString() ==
                                                      'ar'
                                                  ? const Radius.circular(20)
                                                  : const Radius.circular(0),
                                              bottomRight: Get.locale
                                                          .toString() ==
                                                      'en'
                                                  ? const Radius.circular(16)
                                                  : const Radius.circular(0),
                                              bottomLeft: Get.locale
                                                          .toString() ==
                                                      'ar'
                                                  ? const Radius.circular(16)
                                                  : const Radius.circular(0),
                                            ),
                                          ),
                                          child: Icon(
                                            contains.contains(widget
                                                            .controller
                                                            .mealData[
                                                                widget.index]
                                                            .id +
                                                        widget
                                                            .initialcon
                                                            .selectedItem!
                                                            .mealCatID) ||
                                                    widget.initialcon
                                                        .tempselectedIndex
                                                        .contains(widget
                                                                .controller
                                                                .mealData[widget
                                                                    .index]
                                                                .id +
                                                            widget
                                                                .initialcon
                                                                .selectedItem!
                                                                .mealCatID)
                                                ? Icons.delete_rounded
                                                : Icons.add_circle,
                                            color: Col.WHITE,
                                            size: 20,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              // left: MediaQuery.of(context).size.width * 0.073,

              right: 0,
              top: 0,
              child: InkWell(
                onTap: () {
                  Map<String, dynamic> param = {
                    "orderMealCatId": widget.initialcon.selectedItem!.mealCatID,
                    "dietCategoryMealItemsId":
                        widget.controller.mealData[widget.index].details[0].id,
                    "orderDate": widget.selectedDate.toString().substring(0, 10)
                  };

                  if (widget.initialcon.userExsists.value.toString() == 'Yes') {
                    widget.controller.param1 = {
                      'selectedmeal': widget.controller.mealData[widget.index],
                      'selecteddate': widget.selectedDate,
                      'index': widget.index,
                      'isAdded': contains.contains(widget
                                      .controller.mealData[widget.index].id +
                                  widget.initialcon.selectedItem!.mealCatID) ||
                              widget.initialcon.tempselectedIndex.contains(
                                  widget.controller.mealData[widget.index].id +
                                      widget.initialcon.selectedItem!.mealCatID)
                          ? 1
                          : 0
                    };

                    widget.controller.param2 = param;

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: MealDetails(),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  } else {
                    Get.toNamed('/dailymealDetails', arguments: [
                      {
                        'selectedmeal':
                            widget.controller.mealData[widget.index],
                        'selecteddate': widget.selectedDate,
                        'index': widget.index,
                        'isAdded': contains.contains(widget
                                        .controller.mealData[widget.index].id +
                                    widget
                                        .initialcon.selectedItem!.mealCatID) ||
                                widget.initialcon.tempselectedIndex.contains(
                                    widget.controller.mealData[widget.index]
                                            .id +
                                        widget
                                            .initialcon.selectedItem!.mealCatID)
                            ? 1
                            : 0
                      },
                      param
                    ]);
                  }
                },
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width * 0.54,
                  decoration: BoxDecoration(
                    // color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      bottomLeft: Get.locale.toString() == 'en'
                          ? const Radius.circular(20)
                          : const Radius.circular(0),
                      bottomRight: Get.locale.toString() == 'ar'
                          ? const Radius.circular(20)
                          : const Radius.circular(0),
                      topRight: const Radius.circular(20),
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        '${EnvironmentConstants.baseUrl}/${widget.controller.mealData[widget.index].imageMenu}',
                    imageBuilder: (context, imageProvider) => Container(
                      height: MediaQuery.of(context).size.width * 0.38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          bottomLeft: Get.locale.toString() == 'en'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          bottomRight: Get.locale.toString() == 'ar'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          topRight: const Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,

                          // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                          // )
                        ),
                      ),
                    ),
                    placeholder: (context, url) => const LoadingWidget(
                      isImage: true,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Col.blue,
                    ),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.38,
                    // height:
                    //     100,
                  ),
                ),
              ),
            ),
          ])
        : widget.initialcon.reviewStatus.value == '1'
            ? Container()
            : Stack(fit: StackFit.passthrough, children: [
                InkWell(
                  onTap: () {
                    Map<String, dynamic> param = {
                      "orderMealCatId":
                          widget.initialcon.selectedItem!.mealCatID,
                      "dietCategoryMealItemsId": widget
                          .controller.mealData[widget.index].details[0].id,
                      "orderDate":
                          widget.selectedDate.toString().substring(0, 10)
                    };

                    if (widget.initialcon.userExsists.value.toString() ==
                        'Yes') {
                      widget.controller.param1 = {
                        'selectedmeal':
                            widget.controller.mealData[widget.index],
                        'selecteddate': widget.selectedDate,
                        'index': widget.index,
                        'isAdded': contains.contains(widget
                                        .controller.mealData[widget.index].id +
                                    widget
                                        .initialcon.selectedItem!.mealCatID) ||
                                widget.initialcon.tempselectedIndex.contains(
                                    widget.controller.mealData[widget.index]
                                            .id +
                                        widget
                                            .initialcon.selectedItem!.mealCatID)
                            ? 1
                            : 0
                      };

                      widget.controller.param2 = param;

                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: MealDetails(),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    } else {
                      Get.toNamed('/dailymealDetails', arguments: [
                        {
                          'selectedmeal':
                              widget.controller.mealData[widget.index],
                          'selecteddate': widget.selectedDate,
                          'index': widget.index,
                          'isAdded': contains.contains(widget.controller
                                          .mealData[widget.index].id +
                                      widget.initialcon.selectedItem!
                                          .mealCatID) ||
                                  widget.initialcon.tempselectedIndex.contains(
                                      widget.controller.mealData[widget.index]
                                              .id +
                                          widget.initialcon.selectedItem!
                                              .mealCatID)
                              ? 1
                              : 0
                        },
                        param
                      ]);
                    }
                  },
                  child: FadeAnimation(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.84,

                        width: MediaQuery.of(context).size.width *
                            0.60, //MediaQuery.of(context).size.width * 0.56,
                        decoration: BoxDecoration(
                          color: Col.lightgrey,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            width: 2,
                            color: widget.initialcon.reviewStatus.value
                                        .toString() ==
                                    '1'
                                ? Colors.transparent
                                : contains.contains(widget.controller
                                                .mealData[widget.index].id +
                                            widget.initialcon.selectedItem!
                                                .mealCatID) ||
                                        widget.initialcon.tempselectedIndex
                                            .contains(widget.controller
                                                    .mealData[widget.index].id +
                                                widget.initialcon.selectedItem!
                                                    .mealCatID)
                                    ? Col.darkgreen
                                    : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: Get.locale.toString() == 'en'
                                      ? MediaQuery.of(context).size.width * 0.05
                                      : 0,
                                  right: Get.locale.toString() == 'ar'
                                      ? MediaQuery.of(context).size.width * 0.05
                                      : 0,
                                  bottom:
                                      MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    // color: Colors.amber,
                                    width: 140,
                                    child: Text(
                                      widget.controller.mealData[widget.index]
                                          .name,
                                      style: TextStyle(
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Product_Sans_Bold
                                                  : Assets.TheSans_Bold,
                                          fontSize: 22,
                                          overflow: TextOverflow.ellipsis),
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Flexible(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.40,
                                      child: Text(
                                        widget.controller.mealData[widget.index]
                                            .description,
                                        style: TextStyle(
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Product_Sans_Regular
                                                  : Assets.TheSans_plain,
                                          fontSize: 10,
                                          color: Col.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 17,
                                  ),
                                  Visibility(
                                    visible:
                                        widget.initialcon.reviewStatus.value ==
                                                '1'
                                            ? true
                                            : false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            Assets.Calendar_Image,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.017,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            DateFormat.yMMMMd()
                                                .format(widget.selectedDate),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              color: Col.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                              fontFamily:
                                                  Get.locale.toString() == 'en'
                                                      ? Assets
                                                          .Product_Sans_Regular
                                                      : Assets.TheSans_plain,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            widget.initialcon.reviewStatus.value.toString() ==
                                    '1'
                                ? Container()
                                : InkWell(
                                    onTap: () {
                                      if (contains.contains(widget.controller
                                              .mealData[widget.index].id +
                                          widget.initialcon.selectedItem!
                                              .mealCatID)) {}

                                      Map<String, dynamic> param = {
                                        "orderMealCatId": widget
                                            .initialcon.selectedItem!.mealCatID,
                                        "dietCategoryMealItemsId": widget
                                            .controller
                                            .mealData[widget.index]
                                            .details[0]
                                            .id,
                                        "orderDate": widget.selectedDate
                                            .toString()
                                            .substring(0, 10)
                                      };
                                      String params = '?orderLineItemId='
                                          '${widget.initialcon.selectedlineitemid.value}';

                                      print(widget.initialcon.selectedItem!
                                          .lineitems.length);

                                      if (contains.contains(widget.controller
                                                  .mealData[widget.index].id +
                                              widget.initialcon.selectedItem!
                                                  .mealCatID) ||
                                          widget.initialcon.tempselectedIndex
                                              .contains(widget
                                                      .controller
                                                      .mealData[widget.index]
                                                      .id +
                                                  widget
                                                      .initialcon
                                                      .selectedItem!
                                                      .mealCatID)) {
                                        widget.initialcon.tempselectedIndex
                                            .removeWhere((element) =>
                                                element ==
                                                widget
                                                        .controller
                                                        .mealData[widget.index]
                                                        .id +
                                                    widget
                                                        .initialcon
                                                        .selectedItem!
                                                        .mealCatID);
                                        contains.removeWhere((element) =>
                                            (element ==
                                                widget
                                                        .controller
                                                        .mealData[widget.index]
                                                        .id +
                                                    widget
                                                        .initialcon
                                                        .selectedItem!
                                                        .mealCatID));
                                        widget.initialcon.deleteMealItem(
                                            params,
                                            widget.controller
                                                    .mealData[widget.index].id +
                                                widget.initialcon.selectedItem!
                                                    .mealCatID,
                                            context);
                                      } else {
                                        widget.initialcon.addtoCart(
                                            param,
                                            widget.controller
                                                    .mealData[widget.index].id +
                                                widget.initialcon.selectedItem!
                                                    .mealCatID);
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        BounceInDown(
                                          child: Container(
                                              height: 52,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: contains.contains(widget
                                                                .controller
                                                                .mealData[widget
                                                                    .index]
                                                                .id +
                                                            widget
                                                                .initialcon
                                                                .selectedItem!
                                                                .mealCatID) ||
                                                        widget.initialcon
                                                            .tempselectedIndex
                                                            .contains(widget
                                                                    .controller
                                                                    .mealData[
                                                                        widget
                                                                            .index]
                                                                    .id +
                                                                widget
                                                                    .initialcon
                                                                    .selectedItem!
                                                                    .mealCatID)
                                                    ? Col.darkgreen
                                                    : Col.yellow,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Get.locale
                                                              .toString() ==
                                                          'en'
                                                      ? const Radius.circular(
                                                          20)
                                                      : const Radius.circular(
                                                          0),
                                                  topRight: Get.locale
                                                              .toString() ==
                                                          'ar'
                                                      ? const Radius.circular(
                                                          20)
                                                      : const Radius.circular(
                                                          0),
                                                  bottomRight: Get.locale
                                                              .toString() ==
                                                          'en'
                                                      ? const Radius.circular(
                                                          16)
                                                      : const Radius.circular(
                                                          0),
                                                  bottomLeft: Get.locale
                                                              .toString() ==
                                                          'ar'
                                                      ? const Radius.circular(
                                                          16)
                                                      : const Radius.circular(
                                                          0),
                                                ),
                                              ),
                                              child: Icon(
                                                contains.contains(widget
                                                                .controller
                                                                .mealData[widget
                                                                    .index]
                                                                .id +
                                                            widget
                                                                .initialcon
                                                                .selectedItem!
                                                                .mealCatID) ||
                                                        widget.initialcon
                                                            .tempselectedIndex
                                                            .contains(widget
                                                                    .controller
                                                                    .mealData[
                                                                        widget
                                                                            .index]
                                                                    .id +
                                                                widget
                                                                    .initialcon
                                                                    .selectedItem!
                                                                    .mealCatID)
                                                    ? Icons.delete_rounded
                                                    : Icons.add_circle,
                                                color: Col.WHITE,
                                                size: 20,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // left: MediaQuery.of(context).size.width * 0.073,

                  right: 0,
                  top: 0,
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> param = {
                        "orderMealCatId":
                            widget.initialcon.selectedItem!.mealCatID,
                        "dietCategoryMealItemsId": widget
                            .controller.mealData[widget.index].details[0].id,
                        "orderDate":
                            widget.selectedDate.toString().substring(0, 10)
                      };

                      if (widget.initialcon.userExsists.value.toString() ==
                          'Yes') {
                        widget.controller.param1 = {
                          'selectedmeal':
                              widget.controller.mealData[widget.index],
                          'selecteddate': widget.selectedDate,
                          'index': widget.index,
                          'isAdded': contains.contains(widget.controller
                                          .mealData[widget.index].id +
                                      widget.initialcon.selectedItem!
                                          .mealCatID) ||
                                  widget.initialcon.tempselectedIndex.contains(
                                      widget.controller.mealData[widget.index]
                                              .id +
                                          widget.initialcon.selectedItem!
                                              .mealCatID)
                              ? 1
                              : 0
                        };

                        widget.controller.param2 = param;

                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: MealDetails(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      } else {
                        Get.toNamed('/dailymealDetails', arguments: [
                          {
                            'selectedmeal':
                                widget.controller.mealData[widget.index],
                            'selecteddate': widget.selectedDate,
                            'index': widget.index,
                            'isAdded': contains.contains(widget.controller
                                            .mealData[widget.index].id +
                                        widget.initialcon.selectedItem!
                                            .mealCatID) ||
                                    widget.initialcon.tempselectedIndex
                                        .contains(widget.controller
                                                .mealData[widget.index].id +
                                            widget.initialcon.selectedItem!
                                                .mealCatID)
                                ? 1
                                : 0
                          },
                          param
                        ]);
                      }
                    },
                    child: Container(
                      height: 220,
                      width: MediaQuery.of(context).size.width * 0.54,
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20),
                          bottomLeft: Get.locale.toString() == 'en'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          bottomRight: Get.locale.toString() == 'ar'
                              ? const Radius.circular(20)
                              : const Radius.circular(0),
                          topRight: const Radius.circular(20),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${EnvironmentConstants.baseUrl}/${widget.controller.mealData[widget.index].imageMenu}',
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.width * 0.38,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,

                              // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                              // )
                            ),
                          ),
                        ),
                        placeholder: (context, url) => const LoadingWidget(
                          isImage: true,
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Col.blue,
                        ),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width * 0.38,
                        // height:
                        //     100,
                      ),
                    ),
                  ),
                ),
              ]);
  }
}

// class KitoDietPlanCard extends StatefulWidget {
//   @override
//   _KitoDietPlanCardState createState() => _KitoDietPlanCardState();
// }
//
// class _KitoDietPlanCardState extends State<KitoDietPlanCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(                   fit: StackFit.passthrough,
//  children: [
//       Container(
//         height: 500, //MediaQuery.of(context).size.height * 0.42,
//         width: 220, //MediaQuery.of(context).size.width * 0.56,
//         decoration: BoxDecoration(
//           color: Col.lightgreylite,
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//         ),
//       ),
//       Positioned(
//         top: 200,
//         left: 20,
//         child: Text(
//           "Avocado boats",
//           style: TextStyle(
//             fontFamily: Assets.Poppins_Bold,
//             fontSize: 20,
//           ),
//         ),
//       ),
//       Positioned(
//         top: 230,
//         left: 20,
//         right: 5,
//         child: Text(
//           "This food contains Gluten,dairy,egg,nuts",
//           style: TextStyle(
//             fontFamily: Assets.Poppins_Medium,
//             fontSize: 12,
//             color: Col.black,
//           ),
//         ),
//       ),
//       Positioned(
//         left: 170,
//         top: 248,
//         child: Container(
//             height: 52,
//             width: 50,
//             decoration: BoxDecoration(
//               color: Col.green,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//             child: InkWell(
//               onTap: () {},
//               child: Icon(
//                 Icons.add_circle_outlined,
//                 color: Col.WHITE,
//                 size: 20,
//               ),
//             )),
//       ),
//       Positioned(
//         left: 20,
//         top: -15,
//         child: Row(
//           children: [
//             Container(
//               height: 200,
//               width: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   bottomLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(
//                     Assets.KitoDiet_Image,
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ]);
//   }
// }




