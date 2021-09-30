import 'package:intl/intl.dart';

import '../../apiRoutes.dart';

class NotificationModel {
  int id;
  NotificationDataModel data;
  String userId;
  int isRead;
  String createdAt;
  String updatedAt;

  NotificationModel(
    this.id,
    this.data,
    this.userId,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  );
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new NotificationModel.fromJson(job)).toList();
  }

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = NotificationDataModel.fromJson(json['data']);
    userId = json['user_id'];
    isRead = json['is_read'];
    createdAt = json['created_at'] != null && json['created_at'] != ''
        ? DateFormat("yyyy-MM-dd hh:mm:ss")
            .format(DateTime.parse(json['created_at']))
        : "";
    ;
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data'] = this.data;
    data['user_id'] = this.userId;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationDataModel {
  int id;
  String title;
  String message;
  String badge;
  String icon;
  String click_action;
  String unique_order_id;
  bool custom_notification;
  String custom_image;

  NotificationDataModel(
      this.id,
      this.title,
      this.message,
      this.badge,
      this.icon,
      this.click_action,
      this.unique_order_id,
      this.custom_notification,
      this.custom_image);
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new NotificationModel.fromJson(job)).toList();
  }

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    badge = APIRoute.getBaseUrl() + json['badge'];
    icon = APIRoute.getBaseUrl() + json['icon'];
    click_action = json['click_action'];
    unique_order_id = json['unique_order_id'];
    custom_notification = json['custom_notification'];
    custom_image = json['custom_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['message'] = this.message;
    data['badge'] = this.badge;
    data['icon'] = this.icon;
    data['click_action'] = this.click_action;
    data['unique_order_id'] = this.unique_order_id;
    data['custom_notification'] = this.custom_notification;
    data['custom_image'] = this.custom_image;
    return data;
  }
}
