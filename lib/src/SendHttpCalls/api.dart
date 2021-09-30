import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:markets/src/SendHttpCalls/Models/user_info_model.dart';
import 'package:markets/src/SendHttpCalls/apiRoutes.dart';
import 'package:markets/src/database/sharedPreference.dart';

class Api{
  static Dio _getDio() {
    Dio dio = Dio();

    // dio.options.baseUrl = ApiList.baseUrl;
    // dio.options.method = enumDioMethod.toString().split(".").last;
    dio.options.headers["Authorization"] =
    "Bearer ${loggedInUser == null ? '' : loggedInUser.apiToken}";
    dio.options.headers["content-type"] = Headers.jsonContentType;
    dio.options.contentType = Headers.jsonContentType;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
    };
    // dio.interceptors.add(AppInterceptors());
    /*dio..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) => log("onRequest"),
      onResponse: (e, handler) => log("onResponse"),
      onError: (e, handler) => log("onError"),
    ));*/
    return dio;
  }

  static Future<UserInfoModel> getUserData() async {
      String tag = "getUserData";

      log("URL = ${APIRoute.getUserInfo()}", name: tag);
      FormData formData = FormData.fromMap({
        "user_id" : loggedInUser.id
      });
      log("Request = ${formData.fields}", name: tag);
      try {
        Response response = await _getDio().post(APIRoute.getUserInfo(), data: formData);
        log("Response statusCode = ${response.statusCode}", name: tag);
        if(response.statusCode == HttpStatus.ok){
          if(response.data != null){
            log("Response data = ${response.data}", name: tag);
            return UserInfoModel.fromJson(jsonDecode(jsonEncode(response.data)));
          } else {
            return null;
          }
        } else {
          return null;
        }
      } on Exception catch (e) {
        log("Error getUserData = $e");
      }
      return null;
  }
}