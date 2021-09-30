import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:markets/src/SendHttpCalls/Models/Notification/notification_model_new.dart';

import '../../../database/sharedPreference.dart';
import '../../apiRoutes.dart';

Future<List<NotificationModelNew>> getNotificationOfUser(
    {@required String lat, @required String long}) async {
  List<NotificationModelNew> orders = [];
  try {
    String url = APIRoute.getNotificationsURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("Logged in user token: " + token);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("notification status code" + response.statusCode.toString());

    if (response.statusCode == 200) {
      List<dynamic> ouptut = jsonDecode(response.body);
      // log("getNotificationOfUser() " + response.body);
      // orders = NotificationModel.fromJsonList(ouptut);
      // log("getNotificationOfUser - ouptut = $ouptut");
      /*ouptut.map((x) {
            log("getNotificationOfUser - map item = $x");
      });*/

      // List<NotificationModel> tempList = ouptut.map((x) => NotificationModel.fromJson(x)).toList();
      /*for (var value in tempList.toList()) {
        log("getNotificationOfUser - notification data = ${value.data.toJson()}");
      }*/

      Iterable l = json.decode(response.body);
      orders = List<NotificationModelNew>.from(l.map((model) {
        log("in the loop = $model");
        return NotificationModelNew.fromJson(model);
      }));
    }
  } catch (ex) {
    print("Error getNotificationOfUser() - " + ex);
  }
  return orders;
}

Future<bool> saveNotificationToken() async {
  try {
    String url = APIRoute.getSaveCustomerToken();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;

    var body = {
      "user_id": loggedInUser.id,
      "push_token": userNotificationToken
    };
    print("Push notification token: " + userNotificationToken);
    var response =
        await http.post(Uri.parse(url), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("saveNotificationToken() " + response.body);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  } catch (ex) {
    print("Error saveNotificationToken()" + ex.toString());
    return false;
  }
}
