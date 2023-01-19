import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/model/mealItem.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/SelectDailyMeal/selectDailyMeal_Controller.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import '../../../controller/InitialStatusController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';

class MealDetails extends StatefulWidget {
  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  InitialStatusController controller = Get.find<InitialStatusController>();
  DailyMealSelectController dailycon = Get.find<DailyMealSelectController>();
  late MealItem selectedMeal;
  late DateTime selecteddate;
  late String Allergieslist = '';
  late int indexofmeal;
  late int isadded;
  late Map<String, dynamic> params;
  @override
  void initState() {
    selectedMeal = controller.userExsists.toString() == 'Yes'
        ? dailycon.param1['selectedmeal']
        : Get.arguments[0]['selectedmeal'];
    selecteddate = controller.userExsists.toString() == 'Yes'
        ? dailycon.param1['selecteddate']
        : Get.arguments[0]['selecteddate'];
    indexofmeal = controller.userExsists.toString() == 'Yes'
        ? dailycon.param1['index']
        : Get.arguments[0]['index'];
    isadded = controller.userExsists.toString() == 'Yes'
        ? dailycon.param1['isAdded']
        : Get.arguments[0]['isAdded'];
    params = controller.userExsists.toString() == 'Yes'
        ? dailycon.param2
        : Get.arguments[1];

    for (var i = 0; i < selectedMeal.ingredients.length; i++) {
      Allergieslist = Allergieslist + ',' + selectedMeal.ingredients[i].name;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child:
                Appbar(context: context, title: controller.selectedItem!.name),
            preferredSize: const Size.fromHeight(150)),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Container(
              // width: MediaQuery.of(context).size.width,
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
                      ),
                      child: Text(
                        selectedMeal.name,
                        style: TextStyle(
                          color: Col.blue,
                          fontSize: MediaQuery.of(context).size.height * 0.035,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Bold
                              : Assets.TheSans_Bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        selectedMeal.description,
                        style: TextStyle(
                          color: Col.black.withOpacity(0.8),
                          fontSize: MediaQuery.of(context).size.height * 0.018,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Regular
                              : Assets.TheSans_plain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.Calendar_Image,
                            height: MediaQuery.of(context).size.height * 0.02,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat.yMMMMd().format(selecteddate),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Col.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Regular
                                  : Assets.TheSans_plain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 30 : 0,
                        right: Get.locale.toString() == 'ar' ? 30 : 0,
                      ),
                      child: Text(
                        "Common Allergies".tr(),
                        style: TextStyle(
                          color: Col.blue,
                          fontSize: MediaQuery.of(context).size.height * 0.025,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Bold
                              : Assets.TheSans_Bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 30 : 0,
                        right: Get.locale.toString() == 'ar' ? 30 : 0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'This food contains'.tr() +
                                '' +
                                Allergieslist.substring(1),
                            style: TextStyle(
                              color: Col.black.withOpacity(0.8),
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.018,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Regular
                                  : Assets.TheSans_plain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      // color: Colors.amber,
                      height: MediaQuery.of(context).size.height * .4,
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: Get.locale.toString() == 'en' ? 30 : 0,
                                  right: Get.locale.toString() == 'ar' ? 30 : 0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sizes".tr(),
                                      style: TextStyle(
                                        color: Col.lightgreylite,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Regular
                                                : Assets.TheSans_plain,
                                      ),
                                    ),
                                    Text(
                                      selectedMeal.details[0].size.toString() +
                                          'z',
                                      style: TextStyle(
                                        color: Col.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Text(
                                      "Food Colorie".tr(),
                                      style: TextStyle(
                                        color: Col.lightgreylite,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.015,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Regular
                                                : Assets.TheSans_plain,
                                      ),
                                    ),
                                    Text(
                                      selectedMeal.details[0].calories
                                              .toString() +
                                          'cal',
                                      style: TextStyle(
                                        color: Col.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.locale.toString() == 'en'
                                    ? MediaQuery.of(context).size.height * .18
                                    : 0,
                                right: Get.locale.toString() == 'ar'
                                    ? MediaQuery.of(context).size.height * .18
                                    : 0,
                                top: MediaQuery.of(context).size.height * .07),
                            child: SizedBox(
                              // color: Colors.amber,
                              height: MediaQuery.of(context).size.width * 0.6,
                              child: ZoomIn(
                                delay: const Duration(milliseconds: 200),
                                child: CachedNetworkImage(
                                  imageUrl: EnvironmentConstants.baseUrl +
                                      '/' +
                                      selectedMeal.imageItem.toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    // height: MediaQuery.of(context).size.width * 0.38,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(20),
                                        bottomLeft:
                                            Get.locale.toString() == 'en'
                                                ? const Radius.circular(20)
                                                : const Radius.circular(0),
                                        bottomRight:
                                            Get.locale.toString() == 'ar'
                                                ? const Radius.circular(20)
                                                : const Radius.circular(0),
                                        topRight: const Radius.circular(20),
                                      ),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain,

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
                                  fit: BoxFit.cover,
                                  // height: MediaQuery.of(context).size.width * 0.8,
                                  // height:
                                  //     100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.locale.toString() == 'en' ? 35 : 0,
                        right: Get.locale.toString() == 'ar' ? 35 : 0,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Ingredients".tr(),
                            style: TextStyle(
                              color: Col.blue,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Regular
                                  : Assets.TheSans_plain,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: Get.locale.toString() == 'en' ? 35 : 0,
                          right: Get.locale.toString() == 'ar' ? 35 : 0,
                          top: 10),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.21,
                        child: SlideInRight(
                          delay: const Duration(milliseconds: 500),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: selectedMeal.ingredients.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Row(
                                    children: [
                                      Ingredients(
                                        mealitem: selectedMeal,
                                        index: index,
                                      ),
                                      Container(
                                        width: 25,
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    controller.reviewStatus.value.toString() == '1'
                        ? Container()
                        : Center(
                            child: Container(
                              // padding:EdgeInsets.only(left: 60,right: 60,top: 8,bottom: 8),
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: const BoxDecoration(
                                color: Col.darkgreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  isadded == 1
                                      ? print('Already Added')
                                      : controller.addtoCart(
                                          params, indexofmeal);
                                },
                                child: Obx(
                                  () => Text(
                                    isadded == 1 ||
                                            controller.tempselectedIndex
                                                .contains(indexofmeal)
                                        ? controller.cartStatus.value
                                        : "ADD TO CART".tr(),
                                    style: TextStyle(
                                      color: Col.WHITE,
                                      fontFamily: Get.locale.toString() == 'en'
                                          ? Assets.Product_Sans_Regular
                                          : Assets.TheSans_plain,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class Ingredients extends StatefulWidget {
  MealItem mealitem;
  int index;
  Ingredients({required this.mealitem, required this.index});
  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
          // height: 100,
          // width: 120,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
          decoration: const BoxDecoration(
            color: Col.lightgrey,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                width: MediaQuery.of(context).size.height * 0.14,
                child: CachedNetworkImage(
                  imageUrl: EnvironmentConstants.baseUrl +
                      '/' +
                      widget.mealitem.ingredients[widget.index].image
                          .toString(),
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
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          widget.mealitem.ingredients[widget.index].name,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontFamily: Get.locale.toString() == 'en'
                ? Assets.Product_Sans_Bold
                : Assets.TheSans_Bold,
          ),
        ),
      ],
    );
  }
}
