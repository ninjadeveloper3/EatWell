// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print

import 'dart:ui';

import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/Calories_Calculator/caloriesCalculatorController.dart';
import 'package:eat_well/views/Calories_Calculator/caloriesResultPage.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:eat_well/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CaloriesCalculator extends StatefulWidget {
  const CaloriesCalculator({Key? key}) : super(key: key);

  @override
  State<CaloriesCalculator> createState() => _CaloriesCalculatorState();
}

class _CaloriesCalculatorState extends State<CaloriesCalculator> {
  int heightinCm = 170;
  int heightinFt1 = 5;
  int heightinFt2 = 0;
  int _selectedRadioforHeight = 1;
  int _selectedRadioforWeight = 3;
  DateTime? date;
  int weight = 60;

  String? selectedGender;

  List<String> gender = ['Male'.tr(), 'Female'.tr()];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CaloriesCalculatorController controller =
      Get.find<CaloriesCalculatorController>();
  InitialStatusController initalcon = Get.find<InitialStatusController>();

  @override
  void dispose() {
    print('object');
    initalcon.userExsists.value == 'Yes'
        ? Get.delete<CaloriesCalculatorController>()
        : null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(
            //       Assets.appbarbackground,
            //     ),
            //     fit: BoxFit.fitWidth,
            //   ),
            // ),
            child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .22,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.appbarbackground,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Col.WHITE,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55),
                          topLeft: Radius.circular(55),
                        ),
                      ),
                      child: SlideInUp(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(55),
                            topLeft: Radius.circular(55),
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 41,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Fill Form And Find Out Your\nCurrent Calories"
                                          .tr(),
                                      style: TextStyle(
                                        fontFamily:
                                            Get.locale.toString() == 'en'
                                                ? Assets.Product_Sans_Bold
                                                : Assets.TheSans_Bold,
                                        color: Col.blue,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 43,
                                ),
                                Form(key: _formKey, child: FormUi()),
                              ],
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .099,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Container(
                    // color: Colors.amber,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )));
  }

  Column FormUi() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.locale.toString() == 'en' ? 35 : 0,
              right: Get.locale.toString() == 'ar' ? 35 : 0),
          child: Row(
            children: [
              Text(
                "Gender".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 15,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Container(
            decoration: BoxDecoration(
                color: Col.lightgrey, borderRadius: BorderRadius.circular(10)),
            height: 54,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: const Text(
                    'Select gender',
                    style: TextStyle(
                      fontSize: 14,
                      color: Col.grey,
                    ),
                  ),
                  items: gender
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  value: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value as String;
                    });
                  },
                  buttonHeight: 40,
                  buttonWidth: double.infinity,
                  itemHeight: 40,
                ),
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //     left: 35,
        //     right: 35,
        //   ),
        //   child: DropdownButtonFormField<String>(
        //     alignment: Alignment.bottomCenter,
        //     items: gender
        //         .map((item) =>
        //             DropdownMenuItem<String>(value: item, child: Text(item)))
        //         .toList(),

        //     // readOnly: true,
        //     // enabled: false,
        //     // autofocus: false,
        //     // controller: controller.genderController,
        //     // keyboardType: TextInputType.emailAddress,
        //     // textInputAction: TextInputAction.next,
        //     validator: (val) {
        //       if (val == null || val.toString() == '') {
        //         return 'Please enter gender'.tr();
        //       } else {
        //         return null;
        //       }
        //     },
        //     onChanged: (value) {
        //       setState(() {
        //         selectedGender = value.toString();
        //         print(selectedGender);
        //       });
        //     },

        //     decoration: InputDecoration(
        //       border: const OutlineInputBorder(
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10.0),
        //         ),
        //         borderSide: BorderSide(
        //           width: 0,
        //           style: BorderStyle.none,
        //         ),
        //       ),
        //       isDense: true,
        //       fillColor: Col.lightgrey,
        //       filled: true,
        //       hintText: "Male".tr(),
        //       contentPadding: EdgeInsets.fromLTRB(
        //           18, 12, Get.locale.toString() == 'en' ? 0 : 18, 15.7),
        //       hintStyle: TextStyle(
        //         color: Col.grey,
        //         fontFamily: Get.locale.toString() == 'en'
        //             ? Assets.Product_Sans_Regular
        //             : Assets.TheSans_plain,
        //         fontSize: 14,
        //       ),
        //     ),
        //   ),
        // ),

        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.locale.toString() == 'en' ? 35 : 0,
              right: Get.locale.toString() == 'ar' ? 35 : 0),
          child: Row(
            children: [
              Text(
                "Height".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 15,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  heightdailog(
                      context, _selectedRadioforHeight == 1 ? 'cm' : 'ft');
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: TextFormField(
                    enabled: false,
                    autofocus: false,
                    controller: controller.heightController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null || val.toString() == '') {
                        return 'Please enter height'.tr();
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Col.lightgrey,
                      filled: true,
                      hintText: "Height".tr(),
                      contentPadding: EdgeInsets.fromLTRB(
                          18, 12, Get.locale.toString() == 'en' ? 0 : 18, 15.7),
                      hintStyle: TextStyle(
                        color: Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Theme(
                    data: ThemeData(
                        selectedRowColor: Col.green,
                        colorScheme: ColorScheme.fromSwatch()
                            .copyWith(secondary: Col.green)
                            .copyWith(secondary: Col.grey)),
                    child: Radio(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return _selectedRadioforHeight == 0
                            ? Col.green
                            : Col.grey;
                      }),
                      value: 0,
                      groupValue: _selectedRadioforHeight,
                      onChanged: _handleRadioValueChangeforHeight,
                    ),
                  ),
                  Text(
                    'Ft'.tr(),
                    style: TextStyle(
                      color:
                          _selectedRadioforHeight == 0 ? Col.green : Col.grey,
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Regular
                          : Assets.TheSans_plain,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return _selectedRadioforHeight == 1
                          ? Col.green
                          : Col.grey;
                    }),
                    value: 1,
                    groupValue: _selectedRadioforHeight,
                    onChanged: _handleRadioValueChangeforHeight,
                  ),
                  Text('Cm'.tr(),
                      style: TextStyle(
                        color:
                            _selectedRadioforHeight == 1 ? Col.green : Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 20,
                      )),
                ],
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.locale.toString() == 'en' ? 35 : 0,
              right: Get.locale.toString() == 'ar' ? 35 : 0),
          child: Row(
            children: [
              Text(
                "Date of Birth".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 15,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () async {
            date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (date != null) {
              controller.dobDay.text = date!.day.toString();
              controller.dobMonth.text = date!.month.toString();
              controller.dobYear.text = date!.year.toString();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: TextFormField(
                    enabled: false,
                    // readOnly: true,
                    autofocus: false,
                    controller: controller.dobDay,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    // validator: (val) {
                    //   if (val == null || val.toString() == '') {
                    //     return 'Please enter day';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Col.lightgrey,
                      filled: true,
                      hintText: "DD",
                      contentPadding: EdgeInsets.fromLTRB(
                          18, 12, Get.locale.toString() == 'en' ? 0 : 18, 15.7),
                      hintStyle: TextStyle(
                        color: Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    autofocus: false,
                    controller: controller.dobMonth,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    // validator: (val) {
                    //   if (val == null || val.toString() == '') {
                    //     return 'Please enter month';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Col.lightgrey,
                      filled: true,
                      hintText: "MM",
                      contentPadding: EdgeInsets.fromLTRB(
                          18, 12, Get.locale.toString() == 'en' ? 0 : 18, 15.7),
                      hintStyle: TextStyle(
                        color: Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: TextFormField(
                    enabled: false,
                    readOnly: true,
                    autofocus: false,
                    controller: controller.dobYear,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    // validator: (val) {
                    //   if (val == null || val.toString() == '') {
                    //     return 'Please enter year';
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Col.lightgrey,
                      filled: true,
                      hintText: "YYYY",
                      contentPadding: EdgeInsets.fromLTRB(
                          18, 12, Get.locale.toString() == 'en' ? 0 : 18, 15.7),
                      hintStyle: TextStyle(
                        color: Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Get.locale.toString() == 'en' ? 35 : 0,
              right: Get.locale.toString() == 'ar' ? 35 : 0),
          child: Row(
            children: [
              Text(
                "Weight".tr(),
                style: TextStyle(
                  color: Col.blue,
                  fontSize: 15,
                  fontFamily: Get.locale.toString() == 'en'
                      ? Assets.Product_Sans_Bold
                      : Assets.TheSans_Bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          onTap: () {
            weightDailog(context, _selectedRadioforWeight == 3 ? 'kg' : 'lbs');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Col.ksidePadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: TextFormField(
                      enabled: false,
                      autofocus: false,
                      controller: controller.weight,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      // validator: (val) {
                      //   if (val == null || val.toString() == '') {
                      //     return 'Please enter weight';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        fillColor: Col.lightgrey,
                        filled: true,
                        hintText: "70",
                        contentPadding: EdgeInsets.fromLTRB(18, 12,
                            Get.locale.toString() == 'en' ? 0 : 18, 15.7),
                        hintStyle: TextStyle(
                          color: Col.grey,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Regular
                              : Assets.TheSans_plain,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return _selectedRadioforWeight == 3
                            ? Col.green
                            : Col.grey;
                      }),
                      value: 3,
                      groupValue: _selectedRadioforWeight,
                      onChanged: _handleRadioValueChangeforWeight,
                    ),
                    Text(
                      'Kg'.tr(),
                      style: TextStyle(
                        color:
                            _selectedRadioforWeight == 3 ? Col.green : Col.grey,
                        fontFamily: Get.locale.toString() == 'en'
                            ? Assets.Product_Sans_Regular
                            : Assets.TheSans_plain,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return _selectedRadioforWeight == 4
                            ? Col.green
                            : Col.grey;
                      }),
                      value: 4,
                      groupValue: _selectedRadioforWeight,
                      onChanged: _handleRadioValueChangeforWeight,
                    ),
                    Text('Lbs'.tr(),
                        style: TextStyle(
                          color: _selectedRadioforWeight == 4
                              ? Col.green
                              : Col.grey,
                          fontFamily: Get.locale.toString() == 'en'
                              ? Assets.Product_Sans_Regular
                              : Assets.TheSans_plain,
                          fontSize: 20,
                        )),
                  ],
                ),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Row(
            children: [
              Expanded(
                child: submitButton(
                    onPress: () {
                      if (selectedGender == null) {
                        flutterToast('Please select gender'.tr());
                      } else if (controller.heightController.text.isEmpty &&
                          selectedGender != null) {
                        flutterToast('Please select height'.tr());
                      } else if (date == null) {
                        flutterToast('Please select date of birth'.tr());
                      } else if (controller.weight.text.isEmpty) {
                        flutterToast('Please select weight'.tr());
                      } else {
                        var heightinInches;
                        var Weightinpounds;
                        late Duration age;
                        late int years;

                        age = DateTime.now().difference(date!);

                        // Check if the person's date of birth is in a leap year.
                        bool isLeapYear =
                            (date!.isBefore(DateTime(date!.year, 3, 1)) &&
                                date!.isAfter(DateTime(date!.year, 2, 28)));

                        // Calculate the person's age in years.
                        years = age.inDays ~/ 365;

                        // If the person's date of birth is in a leap year, subtract one from the number of years.
                        if (isLeapYear) years--;

                        // Print the person's age in years.
                        print('The person is $years old');

                        if (_selectedRadioforHeight == 1) {
                          // height is in cm
                          heightinInches = heightinCm / 2.54;
                          print('height  in inches is: $heightinInches ');
                        }
                        if (_selectedRadioforHeight != 1) {
                          var heightinInchesString =
                              '$heightinFt1.$heightinFt2';
                          heightinInches =
                              double.parse(heightinInchesString) * 12;

                          print('height  in inches is: $heightinInches ');

                          // height in Lbs
                        }
                        if (_selectedRadioforWeight == 3) {
                          Weightinpounds =
                              int.parse(controller.weight.text) * 2.20462;
                          print(
                              'weight in pound is: ${Weightinpounds.round().toString()} ');

                          // wright in kgs
                        }
                        if (_selectedRadioforWeight != 3) {
                          Weightinpounds = controller.weight.text;
                          print(
                              'weight in pound is: ${Weightinpounds.toString()} ');
                          // weight in lbs
                        }

                        print(
                            'age:$years, height:${int.parse(heightinInches.round().toString())}, weight:  ${_selectedRadioforWeight != 3 ? int.parse(Weightinpounds.toString()) : int.parse(Weightinpounds.round().toString())},');

                        double callories = calculateBMR(
                            age: years,
                            height:
                                int.parse(heightinInches.round().toString()),
                            weight: _selectedRadioforWeight != 3
                                ? int.parse(Weightinpounds.toString())
                                : int.parse(Weightinpounds.round().toString()),
                            gender:
                                selectedGender.toString() == 'Male' ? 1 : 2);
                        print("person callories is: $callories");

                        if (initalcon.userExsists.value == 'Yes') {
                          controller.usercalories(callories.toStringAsFixed(2));
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: const CalloriesResultPage(),
                            withNavBar:
                                true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                                PageTransitionAnimation.cupertino,
                          );
                        } else {
                          controller.usercalories(callories.toString());
                          Get.toNamed(
                            '/calloriesresult',
                          );
                        }
                      }
                    },
                    title: 'Next'.tr(),
                    height: MediaQuery.of(context).size.height * 0.060,
                    width: double.infinity),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  double calculateBMR(
      {required int gender,
      required int height,
      required int weight,
      required int age}) {
    // Men: BMR = 66 + (6.2 x weight in pounds) + (12.7 x height in inches) - (6.76 x age in years)
    // Women: BMR = 655 + (4.35 x weight in pounds) + (4.7 x height in inches) - (4.7 x age in years)
    if (gender == 1) {
      return 66 + (6.2 * weight) + (12.7 * height) - (6.76 * age);
    } else {
      return 655 + (4.35 * weight) + (4.7 * height) - (4.7 * age);
    }
  }

  void _handleRadioValueChangeforHeight(int? value) {
    setState(() {
      controller.heightController.clear();
      _selectedRadioforHeight = value!;
    });
  }

  void _handleRadioValueChangeforWeight(int? value) {
    setState(() {
      controller.weight.clear();
      _selectedRadioforWeight = value!;
    });
  }

  Future<dynamic> heightdailog(BuildContext context, String type) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeIn(
          delay: const Duration(milliseconds: 100),
          child: Center(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          titlePadding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          //this right here
                          title: SizedBox(
                            height: type == 'cm' ? 330.0 : 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  type == 'cm'
                                      ? 'Height (in cm)'.tr()
                                      : 'Height (in ft)'.tr(),
                                  style: TextStyle(
                                    color: Col.grey,
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Regular
                                        : Assets.TheSans_plain,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                type == 'cm'
                                    ? SizedBox(
                                        height: 120,
                                        child: NumberPicker(
                                            haptics: true,
                                            minValue: 120,
                                            maxValue: 220,
                                            value: heightinCm,
                                            selectedTextStyle: const TextStyle(
                                                color: Col.blue, fontSize: 30),
                                            textStyle: const TextStyle(
                                                color: Col.grey, fontSize: 16),
                                            axis: Axis.horizontal,
                                            itemCount: 5,
                                            itemWidth: 55,
                                            onChanged: (newValue) {
                                              setState(() {
                                                heightinCm = newValue;
                                                controller
                                                        .heightController.text =
                                                    heightinCm.toString();
                                              });
                                            }),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          NumberPicker(
                                              axis: Axis.vertical,
                                              haptics: true,
                                              minValue: 0,
                                              maxValue: 10,
                                              value: heightinFt1,
                                              selectedTextStyle:
                                                  const TextStyle(
                                                      color: Col.blue,
                                                      fontSize: 30),
                                              textStyle: const TextStyle(
                                                  color: Col.grey,
                                                  fontSize: 14),
                                              itemCount: 5,
                                              itemWidth: 50,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  heightinFt1 = newValue;
                                                });
                                              }),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          NumberPicker(
                                              haptics: true,
                                              minValue: 0,
                                              maxValue: 11,
                                              value: heightinFt2,
                                              selectedTextStyle:
                                                  const TextStyle(
                                                      color: Col.blue,
                                                      fontSize: 20),
                                              textStyle: const TextStyle(
                                                  color: Col.grey,
                                                  fontSize: 15),
                                              axis: Axis.vertical,
                                              itemCount: 5,
                                              itemWidth: 50,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  heightinFt2 = newValue;
                                                });
                                              })
                                        ],
                                      ),
                                type == 'cm'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(
                                            5,
                                            (index) => Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  height: index == 2 ? 20 : 10,
                                                  width: 2,
                                                  color: index == 2
                                                      ? Colors.black
                                                      : Col.grey,
                                                )),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 50),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: submitButton(
                                            onPress: () {
                                              if (type == 'cm') {
                                                controller
                                                        .heightController.text =
                                                    heightinCm.toString();
                                              } else {
                                                controller
                                                        .heightController.text =
                                                    // ignore: prefer_interpolation_to_compose_strings
                                                    heightinFt1.toString() +
                                                        '′' +
                                                        heightinFt2.toString() +
                                                        '″';
                                              }
                                              Navigator.pop(context);
                                            },
                                            title: 'Select'.tr(),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.060,
                                            width: double.infinity),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))),
          ),
        );
      },
    );
  }

  Future<dynamic> weightDailog(BuildContext context, String type) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return FadeIn(
          delay: const Duration(milliseconds: 100),
          child: Center(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          titlePadding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          //this right here
                          title: SizedBox(
                            height: 330.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  type == 'kg'
                                      ? 'Weight (in kg)'.tr()
                                      : 'Weight (in lbs)'.tr(),
                                  style: TextStyle(
                                    color: Col.grey,
                                    fontFamily: Get.locale.toString() == 'en'
                                        ? Assets.Product_Sans_Regular
                                        : Assets.TheSans_plain,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                // type == 'kg'
                                //     ?
                                Column(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.18),
                                          border: Border.all(
                                              width: 2,
                                              color:
                                                  Colors.grey.withOpacity(.3)),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          const Positioned(
                                            bottom: 100,
                                            child: RotatedBox(
                                              quarterTurns: 45,
                                              child: Icon(
                                                Icons.play_arrow_rounded,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: SizedBox(
                                              height: 150,
                                              child: NumberPicker(
                                                  minValue: 10,
                                                  maxValue: 350,
                                                  value: weight,
                                                  itemWidth: 45,
                                                  selectedTextStyle:
                                                      const TextStyle(
                                                          color: Col.blue,
                                                          fontSize: 24),
                                                  textStyle: const TextStyle(
                                                      color: Col.grey,
                                                      fontSize: 16),
                                                  axis: Axis.horizontal,
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      weight = newValue;
                                                      controller.weight.text =
                                                          weight.toString();
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                                // : Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.center,
                                //     children: [
                                //       NumberPicker(
                                //           axis: Axis.vertical,
                                //           haptics: true,
                                //           minValue: 0,
                                //           maxValue: 10,
                                //           value: heightinFt1,
                                //           selectedTextStyle:
                                //               const TextStyle(
                                //                   color: Col.blue,
                                //                   fontSize: 30),
                                //           textStyle: const TextStyle(
                                //               color: Col.grey,
                                //               fontSize: 14),
                                //           itemCount: 5,
                                //           itemWidth: 50,
                                //           onChanged: (newValue) {
                                //             setState(() {
                                //               heightinFt1 = newValue;
                                //             });
                                //           }),
                                //       const SizedBox(
                                //         width: 20,
                                //       ),
                                //       NumberPicker(
                                //           haptics: true,
                                //           minValue: 0,
                                //           maxValue: 11,
                                //           value: heightinFt2,
                                //           selectedTextStyle:
                                //               const TextStyle(
                                //                   color: Col.blue,
                                //                   fontSize: 20),
                                //           textStyle: const TextStyle(
                                //               color: Col.grey,
                                //               fontSize: 15),
                                //           axis: Axis.vertical,
                                //           itemCount: 5,
                                //           itemWidth: 50,
                                //           onChanged: (newValue) {
                                //             setState(() {
                                //               heightinFt2 = newValue;
                                //             });
                                //           })
                                //     ],
                                //   ),
                                ,
                                type == 'cm'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: List.generate(
                                            5,
                                            (index) => Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  height: index == 2 ? 25 : 18,
                                                  width: 2,
                                                  color: index == 2
                                                      ? Colors.black
                                                      : Col.grey,
                                                )),
                                      )
                                    : Container(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 70),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: submitButton(
                                            onPress: () {
                                              controller.weight.text.isEmpty
                                                  ? controller.weight.text =
                                                      '60'
                                                  : null;
                                              Navigator.pop(context);
                                            },
                                            title: 'Select'.tr(),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.060,
                                            width: double.infinity),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))),
          ),
        );
      },
    );
  }
}
