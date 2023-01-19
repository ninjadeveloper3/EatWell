// ignore_for_file: avoid_print, avoid_renaming_method_parameters, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:eat_well/controller/InitialStatusController.dart';
import 'package:get/get.dart' as getx;

/// Interceptor class for logging request/response from api
class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl) + (options.path)}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    print("queryParameters:");
    options.queryParameters.forEach((k, v) => print('$k: $v'));
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    InitialStatusController controller =
        getx.Get.find<InitialStatusController>();

    if (dioError.response!.statusCode.toString() == '401') {
      // print('heeeeeee ${dioError.response!.data['message']}');
      // print('objectly');

      if (dioError.response!.data['message']
          .toString()
          .contains('Expired or invalid JWT token')) {
        controller.logout();
      }
      // Fluttertoast.showToast(msg: 'Session expired please login again');

    }
    

    print(dioError);
    print("eeerorororor ${dioError.response}");
    print(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? (dioError.response!.requestOptions.baseUrl + dioError.requestOptions.path) : 'URL')}");
    print("<-- ${dioError.response!.statusCode} ");
    print(
        "${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    print("<-- End error");
    print(
        'ERROR[${dioError.response?.statusCode}] => PATH: ${dioError.requestOptions.baseUrl}');

    return super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<-- ${response.statusCode} ${(response.requestOptions != null ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    print("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
    return super.onResponse(response, handler);
  }
}
