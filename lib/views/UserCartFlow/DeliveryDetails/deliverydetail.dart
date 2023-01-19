import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/AddAddress/addadddressController.dart';
import 'package:eat_well/views/UserCartFlow/AddAddress/addaddress.dart';
import 'package:eat_well/views/UserCartFlow/DeliveryDetails/deliveryDetailController.dart';
import 'package:eat_well/views/UserCartFlow/paymentScreen.dart/payment.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:animate_do/animate_do.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeilveryDetailScreen extends StatefulWidget {
  const DeilveryDetailScreen({Key? key}) : super(key: key);

  @override
  State<DeilveryDetailScreen> createState() => _DeilveryDetailScreenState();
}

class _DeilveryDetailScreenState extends State<DeilveryDetailScreen> {
  Country? _selectedCountry;

  int selecteddeleiveryMethod = 0;
  DeliveryDetailController controller = Get.find<DeliveryDetailController>();
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  late String planPrice;

  /// by default deleivery option is 0 and for pickup
  DeliveryDetailController detailcontroller =
      Get.find<DeliveryDetailController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void initCountry() async {
    // final country = await getDefaultCountry(context);
    final country = await getCountryByCountryCode(context, 'SA');
    setState(() {
      _selectedCountry = country;
    });
  }

  @override
  void initState() {
    initCountry();
    planPrice = initialcon.cartItems[0].plan.price.toString();
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<DeliveryDetailController>();
    print('dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Appbar(
            context: context,
            title: 'DELIVERY DETAILS',
          )),
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                Assets.BgDashBoard_Image,
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .088),
            child: FadeIn(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      children: [
                        Text(
                          'Select Preferred'.tr(),
                          style: TextStyle(
                            color: Col.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.030,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .002,
                    ),
                    Row(
                      children: [
                        Text(
                          'Receiving Method'.tr(),
                          style: TextStyle(
                            color: Col.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.030,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Bold
                                : Assets.TheSans_Bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .002,
                    ),
                    Row(
                      children: [
                        Text(
                          'Add Delivery Details'.tr(),
                          style: TextStyle(
                            color: Col.black,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.015,
                            fontFamily: Get.locale.toString() == 'en'
                                ? Assets.Product_Sans_Regular
                                : Assets.TheSans_plain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .022,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selecteddeleiveryMethod = 0;
                                });
                              },
                              child: ElasticIn(
                                delay: const Duration(milliseconds: 400),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selecteddeleiveryMethod == 0
                                          ? Col.darkgreen
                                          : Col.grey.withOpacity(.3),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  width: width * .2,
                                  height: height * .1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      Assets.Delivery,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.10,
                                      color: selecteddeleiveryMethod == 0
                                          ? Col.WHITE
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Delivery'.tr(),
                                style: TextStyle(
                                  color: Col.black,
                                  fontSize: 12,
                                  fontFamily: Get.locale.toString() == 'en'
                                      ? Assets.Product_Sans_Bold
                                      : Assets.TheSans_Bold,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: width * .033,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selecteddeleiveryMethod = 1;
                                });
                              },
                              child: ElasticIn(
                                delay: const Duration(milliseconds: 200),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: selecteddeleiveryMethod == 1
                                          ? Col.darkgreen
                                          : Col.grey.withOpacity(.3),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  width: width * .2,
                                  height: height * .1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      Assets.Pickup,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.10,
                                      color: selecteddeleiveryMethod == 1
                                          ? Col.WHITE
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('Pickup'.tr(),
                                style: TextStyle(
                                  color: Col.black,
                                  fontSize: 12,
                                  fontFamily: Get.locale.toString() == 'en'
                                      ? Assets.Product_Sans_Bold
                                      : Assets.TheSans_Bold,
                                ))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Form(key: _formKey, child: FormUi()),
                    const SizedBox(
                      height: 12,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.put(AddAddressController(Get.find()));
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const AddAdress(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              Assets.address,
                              height: MediaQuery.of(context).size.width * 0.05,
                              color: Col.blue,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() => Text(
                              detailcontroller.selectedaddressname.value == ''
                                  ? 'Add Address'.tr()
                                  : 'Edit Address'.tr(),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Col.blue,
                                fontSize: 12,
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold,
                              )))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => detailcontroller.selectedaddressname.value == ''
                        ? Container()
                        : ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: SvgPicture.asset(
                              Assets.address,
                              height: MediaQuery.of(context).size.width * 0.05,
                              color: Col.blue,
                            ),
                            title: Text(
                              detailcontroller.selectedaddressname.value,
                              style: TextStyle(
                                color: Col.black,
                                fontSize: 13,
                                fontFamily: Get.locale.toString() == 'en'
                                    ? Assets.Product_Sans_Bold
                                    : Assets.TheSans_Bold,
                              ),
                            ))),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Bill:'.tr(),
                            style: TextStyle(
                              color: Col.black,
                              fontSize: 15,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Bold
                                  : Assets.TheSans_Bold,
                            )),
                        Text('$planPrice SAR',
                            style: TextStyle(
                              color: Col.black,
                              fontSize: 15,
                              fontFamily: Get.locale.toString() == 'en'
                                  ? Assets.Product_Sans_Bold
                                  : Assets.TheSans_Bold,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: submitButton(
                              onPress: () {
                                if (_formKey.currentState!.validate() &&
                                    detailcontroller
                                            .selectedaddressname.value ==
                                        '') {
                                  Fluttertoast.showToast(
                                      msg: "Please selecte address to continue"
                                          .tr());
                                }
                                if (_formKey.currentState!.validate() &&
                                    detailcontroller
                                            .selectedaddressname.value !=
                                        '') {
                                  controller
                                      .placeOrder(
                                          addressId: int.parse(detailcontroller
                                              .selectedaddressid
                                              .toString()),
                                          deliverymethod:
                                              selecteddeleiveryMethod == 0
                                                  ? 'D'
                                                  : "P")
                                      .then((value) {
                                    if (value) {
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const PaymentScreen(),
                                        withNavBar:
                                            true, // OPTIONAL VALUE. True by default.
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.cupertino,
                                      );
                                    }
                                  });
                                }
                              },
                              title: 'Go To Payment'.tr(),
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              width: double.infinity),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column FormUi() {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Your Name".tr(),
              style: TextStyle(
                color: Col.blue,
                fontSize: 13.3,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: controller.nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.toString() == '') {
              return 'Please enter name'.tr();
            } else if (val.length < 3) {
              return "Please enter full name";
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // setState(() {});
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

            suffixIcon: controller.emailController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controller.emailController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
            // enabledBorder: InputBorder.none,
            // border: InputBorder.none,
            hintText: "Your Name".tr(),
            contentPadding: EdgeInsets.fromLTRB(
                Get.locale.toString() == 'en' ? 18 : 0,
                12,
                Get.locale.toString() == 'en' ? 0 : 18,
                15.7),
            hintStyle: TextStyle(
              color: Col.grey,
              fontFamily: Get.locale.toString() == 'en'
                  ? Assets.Product_Sans_Regular
                  : Assets.TheSans_plain,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Email Address".tr(),
              style: TextStyle(
                color: Col.blue,
                fontSize: 13.3,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: controller.emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          validator: (val) {
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = RegExp(pattern.toString());

            if (val == null || val.toString() == '') {
              return 'Please enter email'.tr();
            } else if (!regex.hasMatch(val)) {
              return "Enter valid email".tr();
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // setState(() {});
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

            suffixIcon: controller.emailController.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      controller.emailController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
            // enabledBorder: InputBorder.none,
            // border: InputBorder.none,
            hintText: "info@eatwell.com",
            contentPadding: EdgeInsets.fromLTRB(
                Get.locale.toString() == 'en' ? 18 : 0,
                12,
                Get.locale.toString() == 'en' ? 0 : 18,
                15.7),

            hintStyle: const TextStyle(
              color: Col.grey,
              fontFamily: Assets.Product_Sans_Regular,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              "Enter mob number".tr(),
              style: TextStyle(
                color: Col.blue,
                fontSize: 13.3,
                fontFamily: Get.locale.toString() == 'en'
                    ? Assets.Product_Sans_Bold
                    : Assets.TheSans_Bold,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          controller: controller.mobileController,
          validator: (val) {
            final n = num.tryParse(val!);

            if (val.toString() == '') {
              return 'Please enter mobile number'.tr();
            } else if (n == null) {
              return 'Please enter valid number';
            } else if (val.length < 9) {
              return 'Number must be atleast 9 characters'.tr();
            } else if (val.length > 9) {
              return 'Number should not exceed 9 characters'.tr();
            } else {
              return null;
            }
          },
          onChanged: (value) {
            // setState(() {});
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
            prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 10, 15.7),
                child: Text(
                  _selectedCountry?.callingCode ?? '',
                  style: TextStyle(
                    fontSize: 16.7,
                    fontFamily: Get.locale.toString() == 'en'
                        ? Assets.Product_Sans_Regular
                        : Assets.TheSans_plain,
                  ),
                )),
            prefixStyle: const TextStyle(color: Colors.black),
            suffixIcon: InkWell(
              onTap: () {
                // _onPressed();
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 22,
                  child: _selectedCountry?.flag == null
                      ? Container()
                      : Image.asset(
                          _selectedCountry?.flag ?? '',
                          package: 'country_calling_code_picker',
                          // height: 7,
                        ),
                ),
              ),
            ),
            // enabledBorder: InputBorder.none,
            hintText: "77987877",
            contentPadding: EdgeInsets.fromLTRB(
                Get.locale.toString() == 'en' ? 18 : 0,
                12,
                Get.locale.toString() == 'en' ? 0 : 18,
                15.7),

            hintStyle: TextStyle(
              color: Col.grey,
              fontFamily: Get.locale.toString() == 'en'
                  ? Assets.Product_Sans_Regular
                  : Assets.TheSans_plain,
              fontSize: 16.7,
            ),
          ),
        ),
      ],
    );
  }
}
