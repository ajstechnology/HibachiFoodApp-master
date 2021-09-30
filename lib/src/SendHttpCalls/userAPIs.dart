import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart' as getPackage;
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';

import '../database/sharedPreference.dart';
import 'Models/profilePictureInputModel.dart';
import 'Models/updateUserInfoModel.dart';
import 'apiRoutes.dart';

Future<bool> updateUserInfoPassword() async {
  try {
    UpdateUserInfoModel updateUserInfoModel = new UpdateUserInfoModel(
        loggedInUser.name, loggedInUser.email, loggedInUser.password);

    String url = APIRoute.getUpdateUserInfoURL();
    print(url);
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updateUserInfoModel));
    print("user Api ${response.body}");
    if (response.statusCode == 200) {
      return true;
    }
    print(response.body.toString());
  } catch (ex) {
    print("updateLoggedInUserPassword" + ex.toString());
  }
  return false;
}

Future<bool> updateMyProfileAPI(Uint8List base64) async {
  try {
    // ProfilePictureInputModel jsonBody = new ProfilePictureInputModel(base64);
    String url = APIRoute.getChangeAvatarURL();
    // log("updateMyProfileAPI - jsonBody = $jsonBody");
    log("updateMyProfileAPI - url = $url");

    String token = loggedInUser == null ? '' : loggedInUser.apiToken;

    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.headers['Content-Type'] = "application/json";
    request.headers['Authorization'] = "Bearer $token";

    request.files.add(new http.MultipartFile.fromBytes(
        'avatar', await File.fromRawPath(base64).readAsBytes()));

    var response = await request.send();

    /*var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(jsonBody));*/
    print("updateMyProfileAPI - " + response.statusCode.toString());
    // print("updateMyProfileAPI -- " + response.body.toString());
    if (response.statusCode == 200) {
      return true;
    }
  } catch (ex) {
    print("updateMyProfileAPI()" + ex);
  }
  return false;
}

Future<dynamic> userProfileUploadProvider(PickedFile userImage, String userId) async {
  var responseJson;

  try {
    getPackage.Get.dialog(Center(child: CircularProgressIndicator(),), barrierDismissible: false);
    // SharedPreferences pref = await SharedPreferences.getInstance();
    // String token = pref.getString(Constants.token);
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    log("userProfileUploadProvider - token = $token");
    log("userProfileUploadProvider - user_id = $userId");

    // var request = http.MultipartRequest('POST', uri);
    // List<int> fileData = await userImage.readAsBytes();
    // var file = http.MultipartFile.fromBytes('profile_photo', fileData);
    // request.files.add(file);
    // request.headers["Authorization"] = token;
    // request.headers[HttpHeaders.acceptHeader] = "application/json";
    // final response = await request.send();

    log("Upload file url = ${userImage.path}");

    Dio dio = Dio();
    dio.options.baseUrl = APIRoute.baseUrl;
    var formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(userImage.path,
          filename: userImage.path.split("/").last),
      "user_id" : userId
    });

    var response = await dio.post(
      APIRoute.getChangeAvatar,
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          // "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2hpYmFjaGkxLnJhdmluYm9zcy5jby5pbi9wdWJsaWMvYXBpL2xvZ2luIiwiaWF0IjoxNjMyNTUxMDUwLCJuYmYiOjE2MzI1NTEwNTAsImp0aSI6IktSajNjVEh0SzN5YnJIQlEiLCJzdWIiOjkwLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.0hhnLphWk-evlh1obxVfC8Jr-1s0B-SQZSBKH8Yu6Po",
          // HttpHeaders.contentTypeHeader: "application/json", // set content-length
        },
      ),
    );

    log("StreamResponse := ${response.toString()}");

    if (response.statusCode == 200) {
      return true;
    }

    // final response = await http.post(uri, body: {
    //   'profile_photo': userImage,
    // },);
  } on SocketException {
    throw ('No Internet connection');
  } on DioError catch (e) {
    log("Dio error - User profile image upload - error = ${e.response}");
  } finally{
    getPackage.Get.back(canPop: false);
  }
  return false;
}
