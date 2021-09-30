import 'package:flutter/material.dart';
import 'package:markets/src/SendHttpCalls/Models/Notification/notification_model_new.dart';

import '../../../SendHttpCalls/Models/Notification/notificationAPI.dart';

class NotificationProviderModel extends ChangeNotifier {
  List<NotificationModelNew> _notificationList = [];

  int getNotificationCount() => _notificationList.length;

  Future<List<NotificationModelNew>> getNotificationData(
      {@required String lat, @required String long}) async {
    try {
      _notificationList = await getNotificationOfUser(
        lat: lat,
        long: long,
      );
    } catch (ex) {
      print("_getNotificationData()" + ex.toString());
    }
    return _notificationList;
  }

  setAddNotification() {
    NotificationModelNewData _dataModel = new NotificationModelNewData(
        customNotification: false,
        message: "Msg",
        title: "Title",
        uniqueOrderId: "order id",
        icon: "Icon",
        clickAction: "click action",
        customImage: "custom image");
    /*NotificationModel notificationModel = new NotificationModel(
      1,
      _dataModel,
      "",
      0,
      DateTime.now().toString(),
      DateTime.now().toString(),
    );*/

    NotificationModelNew notificationModel = new NotificationModelNew(
      id: 1,
      data: _dataModel,
      userId: "",
      isRead: 0,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
    );

    _notificationList.add(notificationModel);
    notifyListeners();
  }

  Future<bool> saveUserNotificationToken() async {
    return await saveNotificationToken();
  }
}
