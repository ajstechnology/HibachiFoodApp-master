class PlaceOrderModel {
  String token;
  double pendingPayment;
  String method;
  String location;
  String paymentToken;
  int deliveryType;
  int dis;
  int tipAmount;
  String orderComment;
  bool partialWallet;
  OrderCoupon coupon;
  String scheduleDelivery;
  String timeslotes;
  List<OrderItems> orderItems;
  OrderUser orderUser;
  String addressId;
  PlaceOrderModel(
      {this.token,
      this.pendingPayment,
      this.method,
      this.location,
      this.paymentToken,
      this.deliveryType,
      this.dis,
      this.tipAmount,
      this.orderComment,
      this.partialWallet,
      this.coupon,
      this.orderItems,
      this.orderUser,
      this.addressId});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    pendingPayment = json['pending_payment'];
    method = json['method'];
    location = json['location'];
    paymentToken = json['payment_token'];
    deliveryType = json['delivery_type'];
    dis = json['dis'];
    tipAmount = json['tipAmount'];
    orderComment = json['order_comment'];
    partialWallet = json['partial_wallet'];
    scheduleDelivery = json['schedule_delivery'];
    addressId = json['address_id'];
    timeslotes = json['timeslotes'];
    coupon = json['coupon'] != null
        ? new OrderCoupon.fromJson(json['coupon'])
        : null;
    if (json['order'] != null) {
      orderItems = [];
      json['order'].forEach((v) {
        orderItems.add(new OrderItems.fromJson(v));
      });
    }
    orderUser =
        json['user'] != null ? new OrderUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['pending_payment'] = this.pendingPayment;
    data['method'] = this.method;
    data['location'] = this.location;
    data['payment_token'] = this.paymentToken;
    data['delivery_type'] = this.deliveryType;
    data['dis'] = this.dis;
    data['tipAmount'] = this.tipAmount;
    data['order_comment'] = this.orderComment;
    data['partial_wallet'] = this.partialWallet;
    data['schedule_delivery'] = this.scheduleDelivery;
    data['timeslotes'] = this.timeslotes;
    data['address_id'] = addressId;
    if (this.coupon != null) {
      data['coupon'] = this.coupon.toJson();
    }
    if (this.orderItems != null) {
      data['order'] = this.orderItems.map((v) => v.toJson()).toList();
    }
    if (this.orderUser != null) {
      data['user'] = this.orderUser.toJson();
    }
    return data;
  }
}

class OrderCoupon {
  String code;

  OrderCoupon({this.code});

  OrderCoupon.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    return data;
  }
}

class OrderItems {
  int restaurantId;
  int id;
  int quantity;
  String name;
  String price;
  List<Selectedaddons> selectedaddons;

  OrderItems(
      {this.restaurantId,
      this.id,
      this.quantity,
      this.name,
      this.price,
      this.selectedaddons});

  OrderItems.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    id = json['id'];
    quantity = json['quantity'];
    name = json['name'];
    price = json['price'];
    if (json['selectedaddons'] != null) {
      selectedaddons = [];
      json['selectedaddons'].forEach((v) {
        selectedaddons.add(new Selectedaddons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.selectedaddons != null) {
      data['selectedaddons'] =
          this.selectedaddons.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Selectedaddons {
  String addonId;
  String addonCategoryName;
  String addonName;
  String price;

  Selectedaddons(
      {this.addonId, this.addonCategoryName, this.addonName, this.price});

  Selectedaddons.fromJson(Map<String, dynamic> json) {
    addonId = json['addon_id'];
    addonCategoryName = json['addon_category_name'];
    addonName = json['addon_name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_id'] = this.addonId;
    data['addon_category_name'] = this.addonCategoryName;
    data['addon_name'] = this.addonName;
    data['price'] = this.price;
    return data;
  }
}

class OrderUser {
  UserData data;

  OrderUser({this.data});

  OrderUser.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserData {
  DefaultAddress defaultAddress;

  UserData({this.defaultAddress});

  UserData.fromJson(Map<String, dynamic> json) {
    defaultAddress = json['default_address'] != null
        ? new DefaultAddress.fromJson(json['default_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.defaultAddress != null) {
      data['default_address'] = this.defaultAddress.toJson();
    }
    return data;
  }
}

class DefaultAddress {
  String house;
  String address;

  DefaultAddress({this.house, this.address});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    house = json['house'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['house'] = this.house;
    data['address'] = this.address;
    return data;
  }
}
