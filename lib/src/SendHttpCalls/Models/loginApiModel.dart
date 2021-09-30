class LoginApiModel {
  int id;
  String authToken;
  String name;
  String email;
  String phone;
  String defaultAddressId;
  DefaultAddress defaultAddress;
  String deliveryPin;
  int walletBalance;
  String avatar;
  String taxNumber;

  LoginApiModel(
      {this.id,
      this.authToken,
      this.name,
      this.email,
      this.phone,
      this.defaultAddressId,
      this.defaultAddress,
      this.deliveryPin,
      this.walletBalance,
      this.avatar,
      this.taxNumber});

  LoginApiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    defaultAddressId = json['default_address_id'];
    defaultAddress = json['default_address'] != null
        ? new DefaultAddress.fromJson(json['default_address'])
        : null;
    deliveryPin = json['delivery_pin'];
    walletBalance = json['wallet_balance'];
    avatar = json['avatar'];
    taxNumber = json['tax_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['auth_token'] = this.authToken;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['default_address_id'] = this.defaultAddressId;
    if (this.defaultAddress != null) {
      data['default_address'] = this.defaultAddress.toJson();
    }
    data['delivery_pin'] = this.deliveryPin;
    data['wallet_balance'] = this.walletBalance;
    data['avatar'] = this.avatar;
    data['tax_number'] = this.taxNumber;
    return data;
  }
}

class DefaultAddress {
  String address;
  String house;
  String latitude;
  String longitude;
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
