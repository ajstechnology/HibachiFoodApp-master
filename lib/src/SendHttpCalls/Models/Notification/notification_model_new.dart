import 'package:markets/src/SendHttpCalls/apiRoutes.dart';

class NotificationModelNew {
  int id;
  NotificationModelNewData data;
  String userId;
  int isRead;
  String createdAt;
  String updatedAt;

  NotificationModelNew(
      {this.id,
        this.data,
        this.userId,
        this.isRead,
        this.createdAt,
        this.updatedAt});

  NotificationModelNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? new NotificationModelNewData.fromJson(json['data']) : null;
    userId = json['user_id'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['user_id'] = this.userId;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NotificationModelNewData {
  String title;
  String message;
  String icon;
  String clickAction;
  String uniqueOrderId;
  bool customNotification;
  String customImage;

  NotificationModelNewData(
      {this.title,
        this.message,
        this.icon,
        this.clickAction,
        this.uniqueOrderId,
        this.customNotification,
        this.customImage});

  NotificationModelNewData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    icon = json['icon'];
    clickAction = json['click_action'];
    uniqueOrderId = json['unique_order_id'];
    customNotification = json['custom_notification'];
    customImage = json['custom_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['icon'] = this.icon;
    data['click_action'] = this.clickAction;
    data['unique_order_id'] = this.uniqueOrderId;
    data['custom_notification'] = this.customNotification;
    data['custom_image'] = this.customImage;
    return data;
  }
}
/*class NotificationModelNewData {
  int id;
  String title;
  String message;
  String badge;
  String icon;
  String click_action;
  String unique_order_id;
  bool custom_notification;
  String custom_image;

  NotificationModelNewData(
      this.id,
      this.title,
      this.message,
      this.badge,
      this.icon,
      this.click_action,
      this.unique_order_id,
      this.custom_notification,
      this.custom_image);

  NotificationModelNewData.fromJson(Map<String, dynamic> json) {
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
}*/
