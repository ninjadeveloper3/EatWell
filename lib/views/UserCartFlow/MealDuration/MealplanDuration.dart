// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/MealPlannning/mealplanningController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../DietCategory/dietcategory_controller.dart';
import 'mealplandurationController.dart';

class MealPlanDurationPage extends StatefulWidget {
  const MealPlanDurationPage({Key? key}) : super(key: key);

  @override
  _MealPlanDurationPageState createState() => _MealPlanDurationPageState();
}

class _MealPlanDurationPageState extends State<MealPlanDurationPage> {
  DateRangePickerController? dateRangePickerController;
  MealdurationController mealdurcon = Get.find<MealdurationController>();
  DietCategoryController categoryController =
      Get.find<DietCategoryController>();
  MealPlanningController controller = Get.find<MealPlanningController>();
  InitialStatusController initialcon = Get.find<InitialStatusController>();

  DateTime todaysDate = DateTime.now();
  var after2Days;
  var endDate;

  bool selectedtick = true;

  /// for reset (this is to reset the date to its inital state if user choose standard plan after try to schdule its own plan)
  var after2Days1;

  /// for reset (this is to reset the date to its inital state if user choose standard plan after try to schdule its own plan)
  var endDate1;

  /// for reset
  var selectedrang;

  ///// temp hold user dates
  var tempafter2Days1;
  var tempendDate1;
  var tempselectedrang;

  bool isTapped = false;

  @override
  void dispose() {
    initialcon.userExsists.toString() == 'Yes'
        ? Get.delete<MealdurationController>()
        : null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedrang = initialcon.plandays.toString();
    tempselectedrang = initialcon.plandays.toString();
    after2Days = todaysDate.add(const Duration(days: 2));
    after2Days1 = todaysDate.add(const Duration(days: 2));

    endDate = after2Days
        .add(Duration(days: int.parse(initialcon.plandays.toString())));
    endDate1 = after2Days
        .add(Duration(days: int.parse(initialcon.plandays.toString())));
    tempafter2Days1 = todaysDate.add(const Duration(days: 2));
    tempendDate1 = endDate;

    dateRangePickerController = DateRangePickerController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
          child: Appbar(
            context: context,
            title: 'DAYS',
            lighttitle: 'PLAN',
          ),
          preferredSize: const Size.fromHeight(150)),
      backgroundColor: Col.WHITE,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.BgKito_Image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor(categoryController
                              .dietCategory[int.parse(
                                  controller.selectedindex.toString())]
                              .headingColor)
                          .withOpacity(.0),
                      borderRadius: const BorderRadius.all(Radius.circular(0)),
                    ),
                    height: 240.h,
                    child: Stack(fit: StackFit.expand, children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Wrap(
                                runSpacing: 0,
                                children: [
                                  Text(
                                    categoryController
                                        .dietCategory[int.parse(controller
                                            .selectedindex
                                            .toString())]
                                        .name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(.2),
                                            offset: const Offset(0.2, 2.0),
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.053,
                                        color: HexColor(categoryController
                                            .dietCategory[int.parse(controller
                                                .selectedindex
                                                .toString())]
                                            .headingColor),
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Poppins_Bold
                                                : Assets.TheSans_Bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        right: 20,
                        left: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                // height: 100.h,
                                width: MediaQuery.of(context).size.width * .80,
                                child: ZoomIn(
                                  delay: const Duration(milliseconds: 200),
                                  child: CachedNetworkImage(
                                    imageUrl: EnvironmentConstants.baseUrl +
                                        '/' +
                                        categoryController
                                            .dietCategory[int.parse(controller
                                                .selectedindex
                                                .toString())]
                                            .image
                                            .toString(),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.38,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fitHeight,

                                          // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                                          // )
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        const LoadingWidget(
                                      isImage: true,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Col.blue,
                                    ),
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.width *
                                        0.38,
                                    // height:
                                    //     100,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Col.ksidePadding),
                    child: Text(
                      "How would you like to proceed with the plan ?".tr(),
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          //  fontFamily:
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(0, 90, 156, 1),
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Poppins_Bold
                              : Assets.TheSans_Bold),
                      maxLines: 2,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedtick = true;
                      after2Days = tempafter2Days1;
                      selectedrang = tempselectedrang;
                      after2Days = after2Days1;
                      endDate = endDate1;
                      selectedrang = initialcon.plandays.toString();

                      // dateRangePickerController?.selectedRange =
                      //     PickerDateRange(after2Days.to, endDate);
                      setState(() {
                        isTapped = false;
                      });
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: Col.ksidePadding,
                              right: Col.ksidePadding,
                              top: 20),
                          padding: EdgeInsets.only(
                              left: Get.locale.toString() == 'en' ? 15 : 0,
                              right: Get.locale.toString() == 'ar' ? 15 : 0,
                              top: 10,
                              bottom: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Col.darkgreen,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Get.locale.toString() == 'en'
                                        ? "Standard Plan - ${initialcon.plandays.toString()} Days"
                                        : "الخطة القياسية - ${initialcon.plandays.toString()} أيام",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Poppins_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      //fontFamily:
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                      Get.locale.toString() == 'en'
                                          ? "Your ${categoryController.dietCategory[int.parse(controller.selectedindex.toString())].plans[0].name} plan will start after a period of 48 hours"
                                          : "ستبدأ خطتك ${categoryController.dietCategory[int.parse(controller.selectedindex.toString())].plans[0].name} بعد فترة 48 ساعة",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Poppins_Regular
                                                : Assets.TheSans_plain,

                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.022,

                                        //fontFamily:
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SvgPicture.asset(
                                    Assets.nextarrow_icon,
                                    height: MediaQuery.of(context).size.width *
                                        0.04,
                                    color: Colors.white,
                                  ),
                                  // Icon(Icons.arrow_forward_sharp,color: Colors.white,)
                                  // IconButton(icon: Icon(Icons.arrow_forward_sharp), onPressed: (){},padding: EdgeInsets.all(0),)
                                ],
                              ),
                              Transform.scale(
                                scale: 1.45,
                                child: SvgPicture.asset(
                                  Assets.maple_left,
                                  height:
                                      MediaQuery.of(context).size.width * 0.18,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                        selectedtick
                            ? Get.locale.toString() == 'en'
                                ? const Positioned(
                                    right: Col.ksidePadding,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Image(
                                        image: AssetImage(
                                          Assets.CheckedTick,
                                        ),
                                        height: 22,
                                      ),
                                    ),
                                  )
                                : const Positioned(
                                    left: Col.ksidePadding,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Image(
                                        image: AssetImage(
                                          Assets.CheckedTick,
                                        ),
                                        height: 22,
                                      ),
                                    ),
                                  )
                            : Container()
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedtick = false;
                      after2Days = tempafter2Days1;
                      endDate = tempendDate1;
                      selectedrang = tempselectedrang;

                      // after2Days = after2Days1;
                      // endDate = endDate1;
                      // selectedrang = initialcon.plandays.toString();
                      // dateRangePickerController?.selectedRange =
                      //     PickerDateRange(after2Days, endDate);
                      setState(() {
                        isTapped = !isTapped;
                      });
                    },
                    child: SlideInUp(
                      delay: const Duration(milliseconds: 100),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: Col.ksidePadding,
                                right: Col.ksidePadding,
                                top: 20),
                            padding: EdgeInsets.only(
                                left: Get.locale.toString() == 'en' ? 15 : 0,
                                right: Get.locale.toString() == 'ar' ? 15 : 0,
                                top: 10,
                                bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Col.blue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Schedule Meal Plan".tr(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Poppins_Regular
                                                : Assets.TheSans_plain,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        //fontFamily:
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        "You can schedule your plan for later"
                                            .tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily:
                                              Get.locale.toString() == 'en'
                                                  ? Assets.Poppins_Regular
                                                  : Assets.TheSans_plain,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.025,
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),

                                    Image.asset(
                                      Assets.Calendar_Image,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      fit: BoxFit.cover,
                                      color: Col.WHITE,
                                    ),

                                    // IconButton(icon: Icon(Icons.arrow_forward_sharp), onPressed: (){},padding: EdgeInsets.all(0),)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, top: 5, bottom: 5),
                                  child: Transform.scale(
                                    scale: 1.15,
                                    child: SvgPicture.asset(
                                      Assets.maple_right,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.18,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          !selectedtick
                              ? Get.locale.toString() == 'en'
                                  ? const Positioned(
                                      right: Col.ksidePadding,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image(
                                          image: AssetImage(
                                            Assets.CheckedTick,
                                          ),
                                          height: 22,
                                        ),
                                      ),
                                    )
                                  : const Positioned(
                                      left: Col.ksidePadding,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Image(
                                          image: AssetImage(
                                            Assets.CheckedTick,
                                          ),
                                          height: 22,
                                        ),
                                      ),
                                    )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  !isTapped
                      ? const SizedBox(
                          height: 50,
                        )
                      : const SizedBox(),
                  Visibility(
                    visible: isTapped,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Col.ksidePadding,
                          right: Col.ksidePadding,
                          top: 10),
                      child: SfDateRangePicker(
                        minDate: after2Days,
                        initialSelectedRange:
                            PickerDateRange(after2Days, endDate),
                        onSelectionChanged:
                            (DateRangePickerSelectionChangedArgs args) {
                          after2Days =
                              args.value.startDate.toString().substring(0, 10);

                          endDate = args.value.endDate != null
                              ? args.value.endDate.toString().substring(0, 10)
                              : after2Days;

                          selectedrang = daysBetween(DateTime.parse(after2Days),
                              DateTime.parse(endDate));
                        },

                        controller: dateRangePickerController,
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          todayTextStyle: const TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.black),
                          leadingDatesDecoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                              shape: BoxShape.circle),
                        ),

                        todayHighlightColor: Colors.transparent,
                        view: DateRangePickerView.month,
                        selectionMode: DateRangePickerSelectionMode.range,
                        selectionColor: const Color.fromRGBO(228, 212, 93, 1),

                        startRangeSelectionColor:
                            const Color.fromRGBO(228, 212, 93, 1),

                        endRangeSelectionColor:
                            const Color.fromRGBO(228, 212, 93, 1),
                        //rangeSelectionColor: Color.fromRGBO(228, 212, 93, 1),
                        selectionTextStyle:
                            const TextStyle(color: Colors.black),
                        rangeTextStyle: const TextStyle(color: Colors.black),
                        // onSelectionChanged: _onchanged,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Col.ksidePadding, right: Col.ksidePadding),
                    child: Row(
                      children: [
                        Expanded(
                          child: submitButton(
                              onPress: () {
                                if (selectedrang.toString() !=
                                    initialcon.plandays.value.toString()) {
                                  flutterToast(Get.locale.toString() == 'en'
                                      ? 'Please Select ${initialcon.plandays.value} days'
                                      : "يرجى تحديد ${initialcon.plandays.value} يومًا");
                                } else {
                                  mealdurcon.createCart(
                                      after2Days.toString().substring(0, 10),
                                      context);
                                }
                              },
                              title: 'Continue'.tr(),
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              width: double.infinity),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .07,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
