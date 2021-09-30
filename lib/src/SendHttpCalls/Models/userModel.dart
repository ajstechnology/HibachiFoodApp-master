import 'dart:typed_data';

import 'package:string_validator/string_validator.dart';

class UserModel {
  int id;
  String name;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  DefaultAddress defaultAddress;
  String bio;
  int walletBalance;

  // String image;
  Uint8List image;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  UserModel();

  UserModel.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      name = jsonMap['name'] ?? '';
      email = jsonMap['email'] ?? '';
      apiToken = jsonMap['auth_token'];
      // deviceToken = jsonMap['device_token'];
      phone = jsonMap['phone'] ?? '';
      defaultAddress = jsonMap['address'] != null
          ? new DefaultAddress.fromJson(jsonMap['address'])
          : null;
      ;
      walletBalance =
          jsonMap['wallet_balance'] == null ? 0 : jsonMap['wallet_balance'];
      bio = jsonMap['bio'] ?? '';

      image = jsonMap['avatar'] ?? '';
      if (isBase64(jsonMap['avatar'])) {
        print("Image is valid");
      } else {
        print("Invalid base64 from API");
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["name"] = name;
    map["password"] = password;
    map["auth_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["phone"] = phone;
    map["address"] = defaultAddress;
    map['wallet_balance'] = walletBalance;
    map["bio"] = bio;
    map["avatar"] = image;
    return map;
  }

  @override
  String toString() {
    var map = this.toJson();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    return defaultAddress != null &&
        defaultAddress != '' &&
        phone != null &&
        phone != '';
  }
}

class DefaultAddress {
  String address;
  String house;
  double latitude;
  double longitude;
  String tag;

  DefaultAddress(
      {this.address, this.house, this.latitude, this.longitude, this.tag});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    house = json['house'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['house'] = this.house;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['tag'] = this.tag;
    return data;
  }
}
