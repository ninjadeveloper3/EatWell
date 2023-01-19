// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';

import 'package:eat_well/api-handler/api-handler.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:eat_well/service-api-model/error_body.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'api_response.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as GET;

extension ApiExtension on Future<Response<dynamic>> {
  Future execute<T>(Function(Map<String, dynamic>) model) async {
    try {
      final res = await this;
      return ApiResponse.returnResponse(res, res.data);
    } on Exception catch (error, stacktrace) {
      if (error is DioError) {
        dynamic errorResponse = error.response?.data;
        dynamic statusCode = error.response?.statusCode;

        try {
          var errResponse = ErrorBody.fromJson(error.response?.data);
          // return ApiResponse.returnResponse(error.response!, errResponse);
        } catch (error) {
          EasyLoading.dismiss();

          if (errorResponse['code'].toString() == 'ERROR_AUTH01') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == 'ERROR_AUTH02') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == 'ERROR_AUTH03') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == 'ERROR_OTP01') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == '404') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == '500') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == '400') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == '409') {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
          } else if (errorResponse['code'].toString() == '401') {
            if (errorResponse['message'].toString() == '') {
              Fluttertoast.showToast(msg: errorResponse['message'].toString());
            }
          } else if (errorResponse['code'].toString() == '403') {
            if (errorResponse['message']
                .toString()
                .contains('Session Expired')) {
              InitialStatusController controller = GET.Get.find();
              controller.logout();
            }

            // if (errorResponse['message'].toString() ==
            //     'User with request email is already exist') {
            // } else {
            Fluttertoast.showToast(msg: errorResponse['message'].toString());
            // }
          }
        }
      }
      return ApiResponse.error(
          errCode: ApiResponseCode.UNKNOWN,
          errMsg: error.toString(),
          errBdy: stacktrace.toString(),
          data: null);
    }
  }
}

extension ControllerResponseExtension on Future<dynamic> {
  Future getResponse<T>(Function(dynamic) responseData) async {
    //  showProgressBar();

    var response = await this as ApiResponse;
    //  getXProgressLoader.Get.back();
    if (response.data != null && response.status == ApiStatus.COMPLETED) {
      responseData(response);
    } else {
      var message = '';
      if (response.data != null) {
        message = response.data.detail;
      } else {
        // message = response.apiError!.errorMessage!;
      }
      // showSnackBar("Error Message ", message, Colors.black, false, "error");
    }
  }
}
