// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, constant_identifier_names, library_prefixes, depend_on_referenced_packages

import 'dart:async';
// import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:eat_well/widgets/InternalStorage.dart';
import 'package:flutter/widgets.dart';
import 'package:eat_well/constant/api_constants.dart';
// import 'package:get/get.dart';
import 'env_constants.dart';
import 'logging_interceptor.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as GetLib;

/// Helper class for configuring Api calls
class ApiBaseHelper {
  Dio? _dio;
  var box = GetStorage();
  // Alice? alice;

  ApiBaseHelper() {
    debugPrint('apibase helper created');
    // alice = Alice(showNotification: false);
    var options = BaseOptions(
        receiveTimeout: ApiConstant.TIMEOUT,
        connectTimeout: ApiConstant.TIMEOUT);
    options.baseUrl = EnvironmentConstants.setEnvironment(Environment.DEV);
    _dio = Dio(
      options,
    );
    _dio!.interceptors.add(LoggingInterceptors());
    // _dio!.interceptors.add(alice!.getDioInterceptor());
    //displays logs in notification view
  }

  void setLanguageHeader() {
    if (GetLib.Get.locale == null) {
      var locale = box.read('locale');
      if (locale == null) {
        _dio!.options.headers["Accept-Language"] = "en";
      } else {
        _dio!.options.headers["Accept-Language"] = locale.toString();
      }
    } else {
      GetLib.Get.locale.toString() == 'en'
          ? _dio!.options.headers["Accept-Language"] = "en"
          : _dio!.options.headers["Accept-Language"] = "ar";
    }
  }

  /// Method : POST
  /// Params : url, map for parameters
  Future<Response> post(String url, Map<String, dynamic> params) async {
    print('params is ${params}');
    await getAccessToken().then((value) async {
      if (value.toString() == '' || value.toString() == 'null') {
        getGuestToken().then((value) {
          _dio!.options.headers["Authorization"] = "Bearer $value";
          setLanguageHeader();
        });
      } else {
        await getAccessToken().then((val) {
          _dio!.options.headers["Authorization"] = "Bearer $val";
          setLanguageHeader();
        });
      }
    });
    print(Options(responseType: ResponseType.json));

    var response = await _dio!.post(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

  //// post with form data
  Future<Response> postWithformdata(
      String url, Map<String, dynamic> params) async {
    FormData body = FormData.fromMap(params);
    print('params is ${params}');
    await getAccessToken().then((value) async {
      if (value.toString() == '' || value.toString() == 'null') {
        getGuestToken().then((value) {
          _dio!.options.headers["Authorization"] = "Bearer $value";
          setLanguageHeader();
        });
      } else {
        await getAccessToken().then((val) {
          _dio!.options.headers["Authorization"] = "Bearer $val";
          setLanguageHeader();
        });
      }
    });
    print(Options(responseType: ResponseType.json));

    var response = await _dio!.post(url,
        data: body, options: Options(responseType: ResponseType.json));
    return response;
  }

  //// post request for guest login
  Future<Response> guestpost(String url, Map<String, dynamic> params) async {
    print('guestparam : $params');
    print(Options(responseType: ResponseType.json));

    var response = await _dio!.post(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

  ///// post with static token

  Future<Response> postWithStaticToken(
      String url, Map<String, dynamic> params) async {
    FormData body = FormData.fromMap(params);

    // _dio!.options.headers["Authorization"] = "Bearer ${token}";
    _dio!.options.headers["Authorization"] =
        "Bearer 1|EpeUMH2iHjXWfOf8tq20TzpWpzMNrP7TRvPXZXcZ";
    setLanguageHeader();

    print('posted param ${params}');
    var response = await _dio!.post(url,
        data: body, options: Options(responseType: ResponseType.json));
    return response;
  }

  //// post without Token
  Future<Response> postWithoutToken(
      String url, Map<String, dynamic> params) async {
    setLanguageHeader();
    FormData body = FormData.fromMap(params);

    var response = await _dio!.post(url,
        data: body, options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : PUT
  /// Params : url, map for parameters
  Future<Response> put(String url, Map<String, dynamic> params) async {
    getAccessToken().then((value) async {
      if (value.toString() == '' || value.toString() == 'null') {
        await getGuestToken().then((value) {
          _dio!.options.headers["Authorization"] = "Bearer $value";
          setLanguageHeader();
        });
      } else {
        await getAccessToken().then((val) {
          _dio!.options.headers["Authorization"] = "Bearer $val";
          setLanguageHeader();
        });
      }
    });
    var response = await _dio!.put(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : DELETE
  /// Params : url, map for parameters
  Future<Response> delete(String url, String params) async {
    print(url + params);
    await getAccessToken().then((value) async {
      if (value.toString() == '' || value.toString() == 'null') {
        getGuestToken().then((value) {
          _dio!.options.headers["Authorization"] = "Bearer $value";
          setLanguageHeader();
        });
      } else {
        await getAccessToken().then((val) {
          _dio!.options.headers["Authorization"] = "Bearer $val";
          setLanguageHeader();
        });
      }
    });
    print(Options(responseType: ResponseType.json));
    var response = await _dio!.delete(url + params,
        options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : GET
  /// Params : url
  Future<Response> getWithoutParams(String url) async {
    setLanguageHeader();
    print("url is $url");
    print(url);
    var response =
        await _dio!.get(url, options: Options(responseType: ResponseType.json));
    return response;
  }

//// get with auth access token
  Future<Response> getWithAccessToken(String url) async {
    await getAccessToken().then((value) async {
      if (value.toString() == '' || value.toString() == 'null') {
        print('EMPTY SHOW');
        getGuestToken().then((value) {
          _dio!.options.headers["Authorization"] = "Bearer $value";
          setLanguageHeader();
        });
      } else {
        print('not EMPTY SHOW');
        await getAccessToken().then((vall) {
          _dio!.options.headers["Authorization"] = "Bearer $vall";
          setLanguageHeader();
        });
      }
    });

    var response =
        await _dio!.get(url, options: Options(responseType: ResponseType.json));
    return response;
  }

  //// get with auth access token
  Future<Response> getwithauthparam(String url, String auth) async {
    _dio!.options.headers["Authorization"] = "Bearer $auth";
    setLanguageHeader();

    var response =
        await _dio!.get(url, options: Options(responseType: ResponseType.json));
    return response;
  }

  /// Method : GET
  /// Params : url, map for parameters
  Future<Response> getWithParam(String url, Map<String, dynamic> params) async {
    setLanguageHeader();
    // _dio!.options.headers["Authorization"] = ApiConstant.AUTHORIZED_KEY;
    var response = (await _dio?.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json)))!;
    return response;
  }

  Future<Response> postWithoutHeader(
      String url, Map<String, dynamic> params) async {
    setLanguageHeader();
    // FormData body = FormData.fromMap(params);

    var response = await _dio!.post(url,
        data: params, options: Options(responseType: ResponseType.json));
    return response;
  }

//// add addition url parameter in GET method
  Future<Response> getWithParamUrl(
      String url, String additionalUrl, String loginToken) async {
    print('Url iss${url + additionalUrl}');
    _dio!.options.headers["Authorization"] = "Bearer $loginToken";
    setLanguageHeader();
    var response = (await _dio?.get(url + additionalUrl,
        options: Options(responseType: ResponseType.json)))!;
    return response;
  }

  ////// ADD addition url in post method
  Future<Response> postWithAdditionalUrl(
      String url, Map<String, dynamic> params, String additionURL) async {
    setLanguageHeader();
    FormData body = FormData.fromMap(params);

    print('posted param ${params}');
    var response = await _dio!.post(url + additionURL,
        data: body, options: Options(responseType: ResponseType.json));
    return response;
  }
}

/// Api Response codes
class ApiResponseCode {
  static const int SUCCESS_200 = 200;
  static const int SUCCESS_201 = 201;
  static const int ERROR_400 = 400;
  static const int ERROR_499 = 499;
  static const int ERROR_401 = 201;
  static const int ERROR_404 = 201;
  static const int ERROR_500 = 500;
  static const int INTERNET_UNAVAILABLE = 999;
  static const int UNKNOWN = 533;
}
