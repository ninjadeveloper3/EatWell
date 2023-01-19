// ignore_for_file: file_names, unnecessary_overrides

import 'package:eat_well/api-handler/api-extention.dart';
import 'package:eat_well/api-handler/api-repo.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Trans;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DeliveryDetailController extends GetxController {
  ApiRepository apiRepository;
  DeliveryDetailController(this.apiRepository);
  InitialStatusController initialcon = Get.find<InitialStatusController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  var selectedaddressid = ''.obs;
  var selectedaddressname = ''.obs;
  var paymentUrl = ''.obs;
  var paymentRef = ''.obs;
  var carid = ''.obs;

  @override
  void onInit() {
    super.onInit();

    carid(initialcon.cartItems[0].id.toString());
  }

  Future<bool> placeOrder(
      {required int addressId, required String deliverymethod}) async {
    EasyLoading.show();
    bool apiscompleted = false;

    Map<String, dynamic> params = {
      "cartId": int.parse(carid.value),
      "addressId": addressId,
      "deliveryMethod": deliverymethod,
      "contactEmail": emailController.text,
      "contactName": nameController.text,
      "contactNumber": mobileController.text
    };

    await apiRepository
        .placeOrder(params)
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '500') {
        paymentUrl(response.data['data']['paymentUrl'].toString());
        paymentRef(response.data['data']['paymentRef'].toString());
        apiscompleted = true;
        EasyLoading.dismiss();

        return apiscompleted;
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
        return apiscompleted;
      }
    });
    return apiscompleted;
  }

  void verifyPayment(BuildContext context) async {
    EasyLoading.show();
    Map<String, dynamic> params = {
      "orderId": int.parse(carid.value),
      "refId": paymentRef.value
    };

    await apiRepository
        .verifyPaymentStatus(params)
        .getResponse<Response<String>>((response) {
      if (response.data['code'].toString() == '200') {
        if (response.data['data']['paymentStatus'].toString() == '1') {
          Fluttertoast.showToast(msg: "Your Payment is PENDING");
        }
        if (response.data['data']['paymentStatus'].toString() == '-2') {
          Fluttertoast.showToast(msg: "Your Payment is CANCELLED");
        }
        if (response.data['data']['paymentStatus'].toString() == '3') {
          initialcon.initialcheckUserCartData().then((value) {
            if (value) {
              EasyLoading.dismiss();
              initialcon.clearcache();

              Get.offAllNamed('/HomeDashboard');
              Fluttertoast.showToast(msg: "Your Payment is COMPLETED");
            }
          });
        }
        if (response.data['data']['paymentStatus'].toString() == '0') {
          Fluttertoast.showToast(msg: "ERROR occurred during Transaction");
        }
        if (response.data['data']['paymentStatus'].toString() == '-9') {
          Fluttertoast.showToast(msg: "Your payment FAILED");
        }

        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(msg: "Something went wrong");
      }
    });
  }
}
