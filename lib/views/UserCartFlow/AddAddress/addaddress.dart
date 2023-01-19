import 'package:eat_well/resource/assets.dart';
import 'package:eat_well/resource/colors.dart';
import 'package:eat_well/views/UserCartFlow/AddAddress/addadddressController.dart';
import 'package:eat_well/views/UserCartFlow/DeliveryDetails/deliveryDetailController.dart';
import 'package:eat_well/widgets/Appbar.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:eat_well/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AddAdress extends StatefulWidget {
  const AddAdress({Key? key}) : super(key: key);

  @override
  State<AddAdress> createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final _controller = TextEditingController();
  String googleApikey = "AIzaSyDruBo_2bXpTSTl7cb71GCqHueSV2jX30g";
  String location = '';
  var uuid = const Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];
  List<String> placeses = [];
  String selectedPlace = '';
  late int selectedRadioTile;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String placeID;
  TextEditingController lableController = TextEditingController();
  AddAddressController controller = Get.find<AddAddressController>();
  DeliveryDetailController deliverydetail =
      Get.find<DeliveryDetailController>();

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  void getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyA5D1n0x3EVwetgdXMDaLVDkneWsPKV1-Y";
    // String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.delete<AddAddressController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: PreferredSize(
            child: Appbar(
              context: context,
              title: 'ADD ADDRESS',
            ),
            preferredSize: const Size.fromHeight(150)),
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .088),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .02,
                  ),
                  Text(
                    'Where to deliver?'.tr(),
                    style: TextStyle(
                      color: Col.blue,
                      fontSize: MediaQuery.of(context).size.height * 0.030,
                      fontFamily: Get.locale.toString() == 'en'
                          ? Assets.Product_Sans_Bold
                          : Assets.TheSans_Bold,
                    ),
                  ),

                  SizedBox(
                    height: height * .022,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      return null;

                      // if (val == null || val.toString() == '') {
                      //   return 'Please enter name';
                      // } else if (val.length < 3) {
                      //   return "Please enter full name";
                      // } else {
                      //   return null;
                      // }
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(width: 1, color: Col.darkgreen

                            // style: BorderStyle.none,
                            ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Col.darkgreen,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Col.darkgreen,
                          width: 1.0,
                        ),
                      ),
                      fillColor: Col.WHITE,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,

                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Container(
                          height: MediaQuery.of(context).size.width * 0.06,
                          alignment: Alignment.center,
                          child: SlideInRight(
                            child: SvgPicture.asset(
                              Assets.searchicon,
                              height: MediaQuery.of(context).size.width * 0.10,
                              color: Col.blue,
                            ),
                          ),
                        ),
                      ),
                      // enabledBorder: InputBorder.none,
                      // border: InputBorder.none,
                      hintText: "Destination Address".tr(),
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
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _placeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();

                          selectedPlace =
                              _placeList[index]["description"].toString();

                          placeID = _placeList[index]["place_id"].toString();

                          placeses.contains(
                                  _placeList[index]["description"].toString())
                              ? placeses.remove(
                                  _placeList[index]["description"].toString())
                              : placeses.add(
                                  _placeList[index]["description"].toString());

                          _controller.clear();
                          print('selected place info${_placeList[index]}');

                          setState(() {});

                          BottomSheet(height);
                        },
                        child: ListTile(
                            title: Text(_placeList[index]["description"]),
                            trailing: placeses.contains(
                                    _placeList[index]["description"].toString())
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    color: Col.darkgreen,
                                  )),
                      );
                    },
                  ),

                  _controller.text.toString() == ''
                      ? Column(
                          children: [
                            SizedBox(
                              height: height * .022,
                            ),
                            Obx(() => controller.addressList.isEmpty
                                ? Container()
                                : Theme(
                                    data: ThemeData(
                                      primaryColor: Col.blue,
                                      unselectedWidgetColor: Col.blue,
                                    ),
                                    child: AnimationLimiter(
                                        child: ListView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                controller.addressList.length,
                                            itemBuilder: (context, index) {
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                      position: index,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      child: SlideAnimation(
                                                        verticalOffset: 50.0,
                                                        child: FadeInAnimation(
                                                            child:
                                                                RadioListTile(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          value: controller
                                                              .addressList[
                                                                  index]
                                                              .id,
                                                          groupValue:
                                                              selectedRadioTile,
                                                          title: Text(
                                                              controller
                                                                  .addressList[
                                                                      index]
                                                                  .name,
                                                              style: TextStyle(
                                                                color: Col.blue,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.020,
                                                                fontFamily: Get
                                                                            .locale
                                                                            .toString() ==
                                                                        'en'
                                                                    ? Assets
                                                                        .Product_Sans_Bold
                                                                    : Assets
                                                                        .TheSans_Bold,
                                                              )),
                                                          subtitle: Text(
                                                              controller
                                                                  .addressList[
                                                                      index]
                                                                  .address,
                                                              style: TextStyle(
                                                                color:
                                                                    Col.black,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.015,
                                                                fontFamily: Get
                                                                            .locale
                                                                            .toString() ==
                                                                        'en'
                                                                    ? Assets
                                                                        .Product_Sans_Bold
                                                                    : Assets
                                                                        .TheSans_Bold,
                                                              )),
                                                          onChanged: (val) {
                                                            deliverydetail
                                                                .selectedaddressname(
                                                                    controller
                                                                        .addressList[
                                                                            index]
                                                                        .address);
                                                            deliverydetail.selectedaddressid(
                                                                controller
                                                                    .addressList[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                            setSelectedRadioTile(
                                                                val as int);
                                                            Future.delayed(
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          activeColor:
                                                              Col.darkgreen,
                                                          selected: true,
                                                        )),
                                                      ));
                                            }))))
                          ],
                        )

// const ListTile(
                      // title: Text('Devbatch lahore pakistan'),
                      // leading: Icon(
                      //   Icons.favorite_outline,
                      //   color: Col.darkgreen,
                      // ))
                      : Container(),

                  // InkWell(
                  //     onTap: () async {
                  //       var place = await PlacesAutocomplete.show(
                  //           context: context,
                  //           apiKey: googleApikey,
                  //           mode: Mode.overlay,
                  //           types: [],
                  //           strictbounds: false,
                  //           components: [
                  //             // Component(Component.country, 'np')
                  //           ],
                  //           //google_map_webservice package
                  //           onError: (err) {
                  //             print(err);
                  //           });

                  //       if (place != null) {
                  //         setState(() {
                  //           location = place.description.toString();
                  //         });

                  //         //form google_maps_webservice package
                  //         final plist = GoogleMapsPlaces(
                  //           apiKey: googleApikey,
                  //           apiHeaders:
                  //               await const GoogleApiHeaders().getHeaders(),
                  //           //from google_api_headers package
                  //         );
                  //         String placeid = place.placeId ?? "0";
                  //         final detail = await plist.getDetailsByPlaceId(placeid);
                  //         final geometry = detail.result.geometry!;
                  //         final lat = geometry.location.lat;
                  //         final lang = geometry.location.lng;
                  //         var newlatlang = LatLng(lat, lang);
                  //       }
                  //     },
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(15),
                  //       child: Card(
                  //         child: Container(
                  //             padding: const EdgeInsets.all(0),
                  //             width: MediaQuery.of(context).size.width - 40,
                  //             child: ListTile(
                  //               title: Text(
                  //                 location,
                  //                 style: const TextStyle(fontSize: 18),
                  //               ),
                  //               trailing: const Icon(Icons.search),
                  //               dense: true,
                  //             )),
                  //       ),
                  //     ))
                ],
              ),
            ),
          ),
        ));
  }

  Future<dynamic> BottomSheet(double height) {
    return Get.bottomSheet(
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ElasticIn(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: Container(
              color: Colors.white,
              height: height * .4,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 22,
                    ),
                    ListTile(
                        title: Text(selectedPlace),
                        trailing: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "Enter Lable".tr(),
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
                    const SizedBox(
                      height: 12,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: lableController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.toString() == '') {
                            return 'Please enter lable'.tr();
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

                          suffixIcon: lableController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    lableController.clear();
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : null,
                          // enabledBorder: InputBorder.none,
                          // border: InputBorder.none,
                          hintText: "i.e Work",
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
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: submitButton(
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  final plist = GoogleMapsPlaces(
                                    apiKey: googleApikey,
                                    apiHeaders: await const GoogleApiHeaders()
                                        .getHeaders(),
                                    //from google_api_headers package
                                  );
                                  var userid = await getuserId();
                                  EasyLoading.show();

                                  PlacesDetailsResponse detail =
                                      await plist.getDetailsByPlaceId(placeID);
                                  final geometry = detail.result.geometry!;

                                  Map<String, dynamic> param = {
                                    "userId": userid,
                                    "isDefault": true,
                                    "address": selectedPlace,
                                    "name": lableController.text,
                                    "lat": geometry.location.lat,
                                    "lng": geometry.location.lng
                                  };

                                  controller.saveAddress(param);
                                }
                              },
                              title: 'Save Address'.tr(),
                              height:
                                  MediaQuery.of(context).size.height * 0.060,
                              width: double.infinity),
                        ),
                      ],
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
}
