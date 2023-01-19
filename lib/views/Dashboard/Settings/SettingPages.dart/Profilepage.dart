import 'package:eat_well/api-handler/env_constants.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/theme/color_codes.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:eat_well/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as Deo;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  InitialStatusController controller = Get.find();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  bool isEdit = false;
  final picker = ImagePicker();
  File? _image;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx((() => controller.userprofileApiCompleted.value == 'false'
            ? const LoadingWidget()
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.Calloriesbackground,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 180,
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
                              child: FadeInUp(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(55),
                                    topLeft: Radius.circular(55),
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .10,
                                        ),
                                        isEdit
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .088,
                                                ),
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Form(
                                                          key: _formKey,
                                                          child: FormUi()),
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            .20,
                                                      ),
                                                      submitButton(
                                                          onPress: () async {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              String? fileName =
                                                                  _image?.path
                                                                      .split(
                                                                          '/')
                                                                      .last;
                                                              var file = _image ==
                                                                      null
                                                                  ? ''
                                                                  : await Deo
                                                                          .MultipartFile
                                                                      .fromFile(
                                                                          '${_image?.path}',
                                                                          filename:
                                                                              fileName);
                                                              Map<String,
                                                                      dynamic>
                                                                  param = {
                                                                "firstName":
                                                                    firstname
                                                                        .text,
                                                                "lastName":
                                                                    lastname
                                                                        .text,
                                                                'image': file
                                                              };

                                                              controller
                                                                  .updateProfile(
                                                                      param,
                                                                      context)
                                                                  .then(
                                                                      (value) {
                                                                print(
                                                                    'the value of api completed is:$value');
                                                                if (value ==
                                                                    true) {
                                                                  setState(() {
                                                                    isEdit =
                                                                        false;
                                                                  });
                                                                }
                                                              });
                                                            }
                                                          },
                                                          title: 'Update',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.060,
                                                          width:
                                                              double.infinity),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller.userprofile
                                                                  ?.firstName ==
                                                              null
                                                          ? InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  isEdit = true;
                                                                });
                                                              },
                                                              child: const Text(
                                                                'Complete Profile ->',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily: Assets
                                                                      .Product_Sans_Bold,
                                                                  color:
                                                                      Col.black,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            )
                                                          : Text(
                                                              '${controller.userprofile!.firstName} ${controller.userprofile!.lastName}',
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily: Assets
                                                                    .Product_Sans_Bold,
                                                                color:
                                                                    Col.black,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 21,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 22),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Stack(
                                                        //alignment:new Alignment(x, y)
                                                        children: <Widget>[
                                                          Get.locale.toString() ==
                                                                  'en'
                                                              ? Positioned(
                                                                  right: 0,
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .1,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .51,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Col
                                                                          .blue,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              42),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            controller.userprofile!.activeOrder == true
                                                                                ? '${controller.userprofile!.planDuration} DAY MEAL PLAN'
                                                                                : 'NO ORDER YET',
                                                                            style:
                                                                                const TextStyle(
                                                                              fontFamily: Assets.Product_Sans_Bold,
                                                                              color: Col.WHITE,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          const Text(
                                                                            'Current Order',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: Assets.Product_Sans_Regular,
                                                                              color: Col.WHITE,
                                                                              fontSize: 12,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Positioned(
                                                                  left: 0,
                                                                  child:
                                                                      Container(
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        .1,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        .51,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Col
                                                                          .blue,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left: Get.locale.toString() == 'en'
                                                                              ? 42
                                                                              : 0,
                                                                          right: Get.locale.toString() == 'ar'
                                                                              ? 42
                                                                              : 0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: const [
                                                                          Text(
                                                                            '7DAY Meal Plan',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: Assets.Product_Sans_Bold,
                                                                              color: Col.WHITE,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Current Order',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: Assets.Product_Sans_Regular,
                                                                              color: Col.WHITE,
                                                                              fontSize: 12,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                .1,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                .45,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  Col.darkgreen,
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    controller.userprofile!.completedOrderCount ==
                                                                            null
                                                                        ? "0"
                                                                        : controller
                                                                            .userprofile!
                                                                            .completedOrderCount
                                                                            .toString(),
                                                                    style:
                                                                        const TextStyle(
                                                                      fontFamily:
                                                                          Assets
                                                                              .Product_Sans_Bold,
                                                                      color: Col
                                                                          .WHITE,
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                  const Text(
                                                                    'Completed Orders',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          Assets
                                                                              .Product_Sans_Regular,
                                                                      color: Col
                                                                          .WHITE,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 22),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .09,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/svg/Iconemail.svg',
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .03,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .03,
                                                            ),
                                                            const Text('Email',
                                                                style: TextStyle(
                                                                    color: Col
                                                                        .grey,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        Assets
                                                                            .Product_Sans_Regular))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .03,
                                                        ),
                                                        Text(
                                                          controller
                                                              .userprofile!
                                                              .email
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontFamily: Assets
                                                                  .Product_Sans_Regular),
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .03,
                                                        ),
                                                        const Divider(),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const SizedBox(
                                                              width: 0,
                                                            ),
                                                            SvgPicture.asset(
                                                              'assets/svg/Iconphone.svg',
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .03,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .03,
                                                            ),
                                                            const Text(
                                                                'Phone no:',
                                                                style: TextStyle(
                                                                    color: Col
                                                                        .grey,
                                                                    fontSize:
                                                                        15,
                                                                    fontFamily:
                                                                        Assets
                                                                            .Product_Sans_Regular))
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .03,
                                                        ),
                                                        Text(
                                                          controller
                                                              .userprofile!
                                                              .phoneNumber
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontFamily: Assets
                                                                  .Product_Sans_Regular),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (isEdit) {
                                    setState(() {
                                      isEdit = false;
                                    });
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .32,
                              ),
                              const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Col.WHITE,
                                  fontFamily: Assets.Product_Sans_Bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .3,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    controller.userprofile!.firstName
                                                .toString() ==
                                            ''
                                        ? null
                                        : firstname.text = controller
                                            .userprofile!.firstName
                                            .toString();
                                    controller.userprofile!.lastName
                                                .toString() ==
                                            ''
                                        ? null
                                        : lastname.text = controller
                                            .userprofile!.lastName
                                            .toString();

                                    isEdit = true;
                                  });
                                },
                                child: SvgPicture.asset(
                                  'assets/svg/editwhite.svg',
                                  height:
                                      MediaQuery.of(context).size.width * .05,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * .16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.amber,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: secondaryColor),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(100),
                                    )),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                        child: _image != null
                                            ? Image.file(_image!,
                                                width: 120,
                                                height: 120,
                                                fit: BoxFit.cover)
                                            : controller.userprofile!
                                                        .imageUrl ==
                                                    null
                                                ? const Image(
                                                    image: AssetImage(
                                                        'assets/img/profilepng.png'),
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                  )
                                                : CachedNetworkImage(
                                                    imageUrl:
                                                        '${EnvironmentConstants.baseUrl}/${controller.userprofile!.imageUrl}',
                                                    width: 120,
                                                    height: 120,
                                                    imageBuilder: (context,
                                                            imageProvider) =>
                                                        Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover,
                                                          // colorFilter: const ColorFilter.mode(primaryColor, BlendMode.colorBurn
                                                          // )
                                                        ),
                                                      ),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            const LoadingWidget(
                                                      isImage: true,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons.error,
                                                      color: secondaryColor,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  )),
                                    isEdit
                                        ? Positioned(
                                            top: 80,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                imagePickerOption();
                                              },
                                              icon: const Icon(
                                                Icons.add_a_photo_outlined,
                                                color: Col.darkgreen,
                                                size: 25,
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),

                              // Align(
                              //     alignment: Alignment.topCenter,
                              //     child: SizedBox(
                              //         child: CircleAvatar(
                              //       radius: 50.0,
                              //       backgroundColor: Colors.white,
                              //       child: CircleAvatar(
                              //         child: Align(
                              //           alignment: Alignment.bottomRight,
                              //           child: CircleAvatar(
                              //             backgroundColor: Colors.white,
                              //             radius: 15.0,
                              //             child: isEdit
                              //                 ? InkWell(
                              //                     onTap: () {
                              //                       imagePickerOption();
                              //                     },
                              //                     child: const Icon(
                              //                       Icons.camera_alt,
                              //                       size: 25.0,
                              //                       color: Col.blue,
                              //                     ),
                              //                   )
                              //                 : Container(),
                              //           ),
                              //         ),
                              //         radius: 50.0,
                              //         backgroundImage: const AssetImage(
                              //             'assets/img/emptyProfile.png'),
                              //       ),
                              //     )))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )))));
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
              "First Name",
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
          controller: firstname,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.toString() == '') {
              return 'Please enter first name';
            }
            //  else if (val.length < 3) {
            //   return "Please enter valid first name";
            // }

            else {
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

            suffixIcon: firstname.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      firstname.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
            // enabledBorder: InputBorder.none,
            // border: InputBorder.none,
            hintText: "First Name",
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
        Row(
          children: [
            Text(
              "Last Name",
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
          controller: lastname,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: (val) {
            if (val == null || val.toString() == '') {
              return 'Please enter last name';
            }
            // else if (val.length < 3) {
            //   return "Please enter last name";
            // }
            else {
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

            suffixIcon: lastname.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      lastname.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
            // enabledBorder: InputBorder.none,
            // border: InputBorder.none,
            hintText: "Last name",
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
      ],
    );
  }

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 160.h,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 13.h, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.close_sharp,
                              size: 25,
                              color: Col.darkgreen,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageFromCAm();
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Col.WHITE,
                      ),
                      label: const Text("CAMERA"),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        getImageFromGalaery();
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Col.WHITE,
                      ),
                      label: const Text("GALLERY"),
                    ),
                  ),

                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     Get.back();
                  //   },
                  //   icon: const Icon(
                  //     Icons.close,
                  //     color: Col.WHITE,
                  //   ),
                  //   label: const Text("CANCEL"),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future getImageFromCAm() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        Get.back();
      });
    }
  }

  Future getImageFromGalaery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 40);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        Get.back();
      });
    }
  }
}
