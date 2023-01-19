import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/model/addresslist.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddAddressController extends GetxController {
  ApiRepository apiRepository;
  AddAddressController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();
  var addressList = List<AddressList>.empty(growable: true).obs;
  List<String> placeses = [];

  @override
  void onInit() {
    super.onInit();
    getAddressList();
  }

  void getAddressList() async {
    var userID = await getuserId();

    apiRepository.getAddress(userID).getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        List listData = response.data['data'];

        var parsingList = listData.map((m) => AddressList.fromJson(m)).toList();
        addressList.addAll(parsingList);
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }

  void saveAddress(Map<String, dynamic> params) async {
    var userID = await getuserId();

    apiRepository.saveAddress(params).getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        addressList.clear();
        apiRepository
            .getAddress(userID)
            .getResponse<Response<String>>((response) {
          if (response.data['code'].toString() == '200') {
            List listData = response.data['data'];

            var parsingList =
                listData.map((m) => AddressList.fromJson(m)).toList();
            addressList.addAll(parsingList);

            EasyLoading.dismiss();
            Get.back();
          } else {
            EasyLoading.dismiss();

            Fluttertoast.showToast(msg: "Something went wrong");
          }
        });

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
