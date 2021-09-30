class UserInfoModel {
  bool success;
  Data data;
  RunningOrder runningOrder;
  String deliveryDetails;

  UserInfoModel(
      {this.success, this.data, this.runningOrder, this.deliveryDetails});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    runningOrder = json['running_order'] != null
        ? new RunningOrder.fromJson(json['running_order'])
        : null;
    deliveryDetails = json['delivery_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.runningOrder != null) {
      data['running_order'] = this.runningOrder.toJson();
    }
    data['delivery_details'] = this.deliveryDetails;
    return data;
  }
}

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

class RunningOrder {
  int id;
  String deliveryPin;
  String uniqueOrderId;
  int orderstatusId;
  int userId;
  String couponName;
  String location;
  String address;
  String tax;
  String restaurantCharge;
  String deliveryCharge;
  int total;
  String createdAt;
  String updatedAt;
  String paymentMode;
  String orderComment;
  String restaurantId;
  String transactionId;
  int addressId;
  String deliveryType;
  String scheduleDelivery;
  String timeslotes;
  int payable;
  String walletAmount;
  int tipAmount;
  int taxAmount;
  String couponAmount;
  int subTotal;
  String cashChangeAmount;
  Restaurant restaurant;

  RunningOrder(
      {this.id,
        this.deliveryPin,
        this.uniqueOrderId,
        this.orderstatusId,
        this.userId,
        this.couponName,
        this.location,
        this.address,
        this.tax,
        this.restaurantCharge,
        this.deliveryCharge,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.paymentMode,
        this.orderComment,
        this.restaurantId,
        this.transactionId,
        this.addressId,
        this.deliveryType,
        this.scheduleDelivery,
        this.timeslotes,
        this.payable,
        this.walletAmount,
        this.tipAmount,
        this.taxAmount,
        this.couponAmount,
        this.subTotal,
        this.cashChangeAmount,
        this.restaurant});

  RunningOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryPin = json['delivery_pin'];
    uniqueOrderId = json['unique_order_id'];
    orderstatusId = json['orderstatus_id'];
    userId = json['user_id'];
    couponName = json['coupon_name'];
    location = json['location'];
    address = json['address'];
    tax = json['tax'];
    restaurantCharge = json['restaurant_charge'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentMode = json['payment_mode'];
    orderComment = json['order_comment'];
    restaurantId = json['restaurant_id'];
    transactionId = json['transaction_id'];
    addressId = json['address_id'];
    deliveryType = json['delivery_type'];
    scheduleDelivery = json['schedule_delivery'];
    timeslotes = json['timeslotes'];
    payable = json['payable'];
    walletAmount = json['wallet_amount'];
    tipAmount = json['tip_amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    subTotal = json['sub_total'];
    cashChangeAmount = json['cash_change_amount'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_pin'] = this.deliveryPin;
    data['unique_order_id'] = this.uniqueOrderId;
    data['orderstatus_id'] = this.orderstatusId;
    data['user_id'] = this.userId;
    data['coupon_name'] = this.couponName;
    data['location'] = this.location;
    data['address'] = this.address;
    data['tax'] = this.tax;
    data['restaurant_charge'] = this.restaurantCharge;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_mode'] = this.paymentMode;
    data['order_comment'] = this.orderComment;
    data['restaurant_id'] = this.restaurantId;
    data['transaction_id'] = this.transactionId;
    data['address_id'] = this.addressId;
    data['delivery_type'] = this.deliveryType;
    data['schedule_delivery'] = this.scheduleDelivery;
    data['timeslotes'] = this.timeslotes;
    data['payable'] = this.payable;
    data['wallet_amount'] = this.walletAmount;
    data['tip_amount'] = this.tipAmount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['sub_total'] = this.subTotal;
    data['cash_change_amount'] = this.cashChangeAmount;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  int id;
  String name;
  String description;
  String locationId;
  String image;
  String rating;
  String deliveryTime;
  String priceRange;
  String isPureveg;
  String slug;
  String placeholderImage;
  String latitude;
  String longitude;
  String certificate;
  String restaurantCharges;
  String deliveryCharges;
  String address;
  String pincode;
  String landmark;
  String sku;
  int isActive;
  int isAccepted;
  int isFeatured;
  String commissionRate;
  int deliveryType;
  String timeslotes;
  int deliveryRadius;
  String deliveryChargeType;
  String baseDeliveryCharge;
  String baseDeliveryDistance;
  String extraDeliveryCharge;
  String extraDeliveryDistance;
  String minOrderPrice;
  String isNotifiable;
  String autoAcceptable;
  Null scheduleData;
  String isSchedulable;
  String orderColumn;
  String customMessage;
  bool isOrderscheduling;

  Restaurant(
      {this.id,
        this.name,
        this.description,
        this.locationId,
        this.image,
        this.rating,
        this.deliveryTime,
        this.priceRange,
        this.isPureveg,
        this.slug,
        this.placeholderImage,
        this.latitude,
        this.longitude,
        this.certificate,
        this.restaurantCharges,
        this.deliveryCharges,
        this.address,
        this.pincode,
        this.landmark,
        this.sku,
        this.isActive,
        this.isAccepted,
        this.isFeatured,
        this.commissionRate,
        this.deliveryType,
        this.timeslotes,
        this.deliveryRadius,
        this.deliveryChargeType,
        this.baseDeliveryCharge,
        this.baseDeliveryDistance,
        this.extraDeliveryCharge,
        this.extraDeliveryDistance,
        this.minOrderPrice,
        this.isNotifiable,
        this.autoAcceptable,
        this.scheduleData,
        this.isSchedulable,
        this.orderColumn,
        this.customMessage,
        this.isOrderscheduling});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    locationId = json['location_id'];
    image = json['image'];
    rating = json['rating'];
    deliveryTime = json['delivery_time'];
    priceRange = json['price_range'];
    isPureveg = json['is_pureveg'];
    slug = json['slug'];
    placeholderImage = json['placeholder_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    certificate = json['certificate'];
    restaurantCharges = json['restaurant_charges'];
    deliveryCharges = json['delivery_charges'];
    address = json['address'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    sku = json['sku'];
    isActive = json['is_active'];
    isAccepted = json['is_accepted'];
    isFeatured = json['is_featured'];
    commissionRate = json['commission_rate'];
    deliveryType = json['delivery_type'];
    timeslotes = json['timeslotes'];
    deliveryRadius = json['delivery_radius'];
    deliveryChargeType = json['delivery_charge_type'];
    baseDeliveryCharge = json['base_delivery_charge'];
    baseDeliveryDistance = json['base_delivery_distance'];
    extraDeliveryCharge = json['extra_delivery_charge'];
    extraDeliveryDistance = json['extra_delivery_distance'];
    minOrderPrice = json['min_order_price'];
    isNotifiable = json['is_notifiable'];
    autoAcceptable = json['auto_acceptable'];
    scheduleData = json['schedule_data'];
    isSchedulable = json['is_schedulable'];
    orderColumn = json['order_column'];
    customMessage = json['custom_message'];
    isOrderscheduling = json['is_orderscheduling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location_id'] = this.locationId;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['delivery_time'] = this.deliveryTime;
    data['price_range'] = this.priceRange;
    data['is_pureveg'] = this.isPureveg;
    data['slug'] = this.slug;
    data['placeholder_image'] = this.placeholderImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['certificate'] = this.certificate;
    data['restaurant_charges'] = this.restaurantCharges;
    data['delivery_charges'] = this.deliveryCharges;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['sku'] = this.sku;
    data['is_active'] = this.isActive;
    data['is_accepted'] = this.isAccepted;
    data['is_featured'] = this.isFeatured;
    data['commission_rate'] = this.commissionRate;
    data['delivery_type'] = this.deliveryType;
    data['timeslotes'] = this.timeslotes;
    data['delivery_radius'] = this.deliveryRadius;
    data['delivery_charge_type'] = this.deliveryChargeType;
    data['base_delivery_charge'] = this.baseDeliveryCharge;
    data['base_delivery_distance'] = this.baseDeliveryDistance;
    data['extra_delivery_charge'] = this.extraDeliveryCharge;
    data['extra_delivery_distance'] = this.extraDeliveryDistance;
    data['min_order_price'] = this.minOrderPrice;
    data['is_notifiable'] = this.isNotifiable;
    data['auto_acceptable'] = this.autoAcceptable;
    data['schedule_data'] = this.scheduleData;
    data['is_schedulable'] = this.isSchedulable;
    data['order_column'] = this.orderColumn;
    data['custom_message'] = this.customMessage;
    data['is_orderscheduling'] = this.isOrderscheduling;
    return data;
  }
}

/*class UserInfoModel {
  bool success;
  Data data;
  RunningOrder runningOrder;
  Null deliveryDetails;

  UserInfoModel(
      {this.success, this.data, this.runningOrder, this.deliveryDetails});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    runningOrder = json['running_order'] != null
        ? new RunningOrder.fromJson(json['running_order'])
        : null;
    deliveryDetails = json['delivery_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.runningOrder != null) {
      data['running_order'] = this.runningOrder.toJson();
    }
    data['delivery_details'] = this.deliveryDetails;
    return data;
  }
}

class Data {
  int id;
  String authToken;
  String name;
  String email;
  String phone;
  String defaultAddressId;
  Null defaultAddress;
  String deliveryPin;
  int walletBalance;
  String avatar;
  Null taxNumber;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authToken = json['auth_token'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    defaultAddressId = json['default_address_id'];
    defaultAddress = json['default_address'];
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
    data['default_address'] = this.defaultAddress;
    data['delivery_pin'] = this.deliveryPin;
    data['wallet_balance'] = this.walletBalance;
    data['avatar'] = this.avatar;
    data['tax_number'] = this.taxNumber;
    return data;
  }
}

class RunningOrder {
  int id;
  String deliveryPin;
  String uniqueOrderId;
  int orderstatusId;
  int userId;
  Null couponName;
  String location;
  String address;
  String tax;
  Null restaurantCharge;
  String deliveryCharge;
  int total;
  String createdAt;
  String updatedAt;
  String paymentMode;
  Null orderComment;
  String restaurantId;
  Null transactionId;
  int addressId;
  String deliveryType;
  String scheduleDelivery;
  String timeslotes;
  int payable;
  Null walletAmount;
  int tipAmount;
  int taxAmount;
  Null couponAmount;
  int subTotal;
  Null cashChangeAmount;
  Restaurant restaurant;

  RunningOrder(
      {this.id,
        this.deliveryPin,
        this.uniqueOrderId,
        this.orderstatusId,
        this.userId,
        this.couponName,
        this.location,
        this.address,
        this.tax,
        this.restaurantCharge,
        this.deliveryCharge,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.paymentMode,
        this.orderComment,
        this.restaurantId,
        this.transactionId,
        this.addressId,
        this.deliveryType,
        this.scheduleDelivery,
        this.timeslotes,
        this.payable,
        this.walletAmount,
        this.tipAmount,
        this.taxAmount,
        this.couponAmount,
        this.subTotal,
        this.cashChangeAmount,
        this.restaurant});

  RunningOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryPin = json['delivery_pin'];
    uniqueOrderId = json['unique_order_id'];
    orderstatusId = json['orderstatus_id'];
    userId = json['user_id'];
    couponName = json['coupon_name'];
    location = json['location'];
    address = json['address'];
    tax = json['tax'];
    restaurantCharge = json['restaurant_charge'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentMode = json['payment_mode'];
    orderComment = json['order_comment'];
    restaurantId = json['restaurant_id'];
    transactionId = json['transaction_id'];
    addressId = json['address_id'];
    deliveryType = json['delivery_type'];
    scheduleDelivery = json['schedule_delivery'];
    timeslotes = json['timeslotes'];
    payable = json['payable'];
    walletAmount = json['wallet_amount'];
    tipAmount = json['tip_amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    subTotal = json['sub_total'];
    cashChangeAmount = json['cash_change_amount'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_pin'] = this.deliveryPin;
    data['unique_order_id'] = this.uniqueOrderId;
    data['orderstatus_id'] = this.orderstatusId;
    data['user_id'] = this.userId;
    data['coupon_name'] = this.couponName;
    data['location'] = this.location;
    data['address'] = this.address;
    data['tax'] = this.tax;
    data['restaurant_charge'] = this.restaurantCharge;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_mode'] = this.paymentMode;
    data['order_comment'] = this.orderComment;
    data['restaurant_id'] = this.restaurantId;
    data['transaction_id'] = this.transactionId;
    data['address_id'] = this.addressId;
    data['delivery_type'] = this.deliveryType;
    data['schedule_delivery'] = this.scheduleDelivery;
    data['timeslotes'] = this.timeslotes;
    data['payable'] = this.payable;
    data['wallet_amount'] = this.walletAmount;
    data['tip_amount'] = this.tipAmount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['sub_total'] = this.subTotal;
    data['cash_change_amount'] = this.cashChangeAmount;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  int id;
  String name;
  String description;
  Null locationId;
  String image;
  String rating;
  String deliveryTime;
  String priceRange;
  String isPureveg;
  String slug;
  Null placeholderImage;
  String latitude;
  String longitude;
  Null certificate;
  Null restaurantCharges;
  String deliveryCharges;
  String address;
  Null pincode;
  Null landmark;
  String sku;
  int isActive;
  int isAccepted;
  int isFeatured;
  String commissionRate;
  int deliveryType;
  String timeslotes;
  int deliveryRadius;
  String deliveryChargeType;
  Null baseDeliveryCharge;
  Null baseDeliveryDistance;
  Null extraDeliveryCharge;
  Null extraDeliveryDistance;
  String minOrderPrice;
  String isNotifiable;
  String autoAcceptable;
  Null scheduleData;
  String isSchedulable;
  String orderColumn;
  Null customMessage;
  bool isOrderscheduling;

  Restaurant(
      {this.id,
        this.name,
        this.description,
        this.locationId,
        this.image,
        this.rating,
        this.deliveryTime,
        this.priceRange,
        this.isPureveg,
        this.slug,
        this.placeholderImage,
        this.latitude,
        this.longitude,
        this.certificate,
        this.restaurantCharges,
        this.deliveryCharges,
        this.address,
        this.pincode,
        this.landmark,
        this.sku,
        this.isActive,
        this.isAccepted,
        this.isFeatured,
        this.commissionRate,
        this.deliveryType,
        this.timeslotes,
        this.deliveryRadius,
        this.deliveryChargeType,
        this.baseDeliveryCharge,
        this.baseDeliveryDistance,
        this.extraDeliveryCharge,
        this.extraDeliveryDistance,
        this.minOrderPrice,
        this.isNotifiable,
        this.autoAcceptable,
        this.scheduleData,
        this.isSchedulable,
        this.orderColumn,
        this.customMessage,
        this.isOrderscheduling});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    locationId = json['location_id'];
    image = json['image'];
    rating = json['rating'];
    deliveryTime = json['delivery_time'];
    priceRange = json['price_range'];
    isPureveg = json['is_pureveg'];
    slug = json['slug'];
    placeholderImage = json['placeholder_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    certificate = json['certificate'];
    restaurantCharges = json['restaurant_charges'];
    deliveryCharges = json['delivery_charges'];
    address = json['address'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    sku = json['sku'];
    isActive = json['is_active'];
    isAccepted = json['is_accepted'];
    isFeatured = json['is_featured'];
    commissionRate = json['commission_rate'];
    deliveryType = json['delivery_type'];
    timeslotes = json['timeslotes'];
    deliveryRadius = json['delivery_radius'];
    deliveryChargeType = json['delivery_charge_type'];
    baseDeliveryCharge = json['base_delivery_charge'];
    baseDeliveryDistance = json['base_delivery_distance'];
    extraDeliveryCharge = json['extra_delivery_charge'];
    extraDeliveryDistance = json['extra_delivery_distance'];
    minOrderPrice = json['min_order_price'];
    isNotifiable = json['is_notifiable'];
    autoAcceptable = json['auto_acceptable'];
    scheduleData = json['schedule_data'];
    isSchedulable = json['is_schedulable'];
    orderColumn = json['order_column'];
    customMessage = json['custom_message'];
    isOrderscheduling = json['is_orderscheduling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location_id'] = this.locationId;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['delivery_time'] = this.deliveryTime;
    data['price_range'] = this.priceRange;
    data['is_pureveg'] = this.isPureveg;
    data['slug'] = this.slug;
    data['placeholder_image'] = this.placeholderImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['certificate'] = this.certificate;
    data['restaurant_charges'] = this.restaurantCharges;
    data['delivery_charges'] = this.deliveryCharges;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['sku'] = this.sku;
    data['is_active'] = this.isActive;
    data['is_accepted'] = this.isAccepted;
    data['is_featured'] = this.isFeatured;
    data['commission_rate'] = this.commissionRate;
    data['delivery_type'] = this.deliveryType;
    data['timeslotes'] = this.timeslotes;
    data['delivery_radius'] = this.deliveryRadius;
    data['delivery_charge_type'] = this.deliveryChargeType;
    data['base_delivery_charge'] = this.baseDeliveryCharge;
    data['base_delivery_distance'] = this.baseDeliveryDistance;
    data['extra_delivery_charge'] = this.extraDeliveryCharge;
    data['extra_delivery_distance'] = this.extraDeliveryDistance;
    data['min_order_price'] = this.minOrderPrice;
    data['is_notifiable'] = this.isNotifiable;
    data['auto_acceptable'] = this.autoAcceptable;
    data['schedule_data'] = this.scheduleData;
    data['is_schedulable'] = this.isSchedulable;
    data['order_column'] = this.orderColumn;
    data['custom_message'] = this.customMessage;
    data['is_orderscheduling'] = this.isOrderscheduling;
    return data;
  }
}*/

/*
class UserInfoModel {
  bool success;
  Data data;
  RunningOrder runningOrder;
  Null deliveryDetails;

  UserInfoModel(
      {this.success, this.data, this.runningOrder, this.deliveryDetails});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    runningOrder = json['running_order'] != null
        ? new RunningOrder.fromJson(json['running_order'])
        : null;
    deliveryDetails = json['delivery_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.runningOrder != null) {
      data['running_order'] = this.runningOrder.toJson();
    }
    data['delivery_details'] = this.deliveryDetails;
    return data;
  }
}

class Data {
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
  Null taxNumber;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

class RunningOrder {
  int id;
  String deliveryPin;
  String uniqueOrderId;
  int orderstatusId;
  int userId;
  Null couponName;
  String location;
  String address;
  String tax;
  Null restaurantCharge;
  String deliveryCharge;
  int total;
  String createdAt;
  String updatedAt;
  String paymentMode;
  Null orderComment;
  String restaurantId;
  Null transactionId;
  int addressId;
  String deliveryType;
  String scheduleDelivery;
  String timeslotes;
  int payable;
  Null walletAmount;
  int tipAmount;
  int taxAmount;
  Null couponAmount;
  int subTotal;
  Null cashChangeAmount;
  Restaurant restaurant;

  RunningOrder(
      {this.id,
        this.deliveryPin,
        this.uniqueOrderId,
        this.orderstatusId,
        this.userId,
        this.couponName,
        this.location,
        this.address,
        this.tax,
        this.restaurantCharge,
        this.deliveryCharge,
        this.total,
        this.createdAt,
        this.updatedAt,
        this.paymentMode,
        this.orderComment,
        this.restaurantId,
        this.transactionId,
        this.addressId,
        this.deliveryType,
        this.scheduleDelivery,
        this.timeslotes,
        this.payable,
        this.walletAmount,
        this.tipAmount,
        this.taxAmount,
        this.couponAmount,
        this.subTotal,
        this.cashChangeAmount,
        this.restaurant});

  RunningOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryPin = json['delivery_pin'];
    uniqueOrderId = json['unique_order_id'];
    orderstatusId = json['orderstatus_id'];
    userId = json['user_id'];
    couponName = json['coupon_name'];
    location = json['location'];
    address = json['address'];
    tax = json['tax'];
    restaurantCharge = json['restaurant_charge'];
    deliveryCharge = json['delivery_charge'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    paymentMode = json['payment_mode'];
    orderComment = json['order_comment'];
    restaurantId = json['restaurant_id'];
    transactionId = json['transaction_id'];
    addressId = json['address_id'];
    deliveryType = json['delivery_type'];
    scheduleDelivery = json['schedule_delivery'];
    timeslotes = json['timeslotes'];
    payable = json['payable'];
    walletAmount = json['wallet_amount'];
    tipAmount = json['tip_amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    subTotal = json['sub_total'];
    cashChangeAmount = json['cash_change_amount'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['delivery_pin'] = this.deliveryPin;
    data['unique_order_id'] = this.uniqueOrderId;
    data['orderstatus_id'] = this.orderstatusId;
    data['user_id'] = this.userId;
    data['coupon_name'] = this.couponName;
    data['location'] = this.location;
    data['address'] = this.address;
    data['tax'] = this.tax;
    data['restaurant_charge'] = this.restaurantCharge;
    data['delivery_charge'] = this.deliveryCharge;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['payment_mode'] = this.paymentMode;
    data['order_comment'] = this.orderComment;
    data['restaurant_id'] = this.restaurantId;
    data['transaction_id'] = this.transactionId;
    data['address_id'] = this.addressId;
    data['delivery_type'] = this.deliveryType;
    data['schedule_delivery'] = this.scheduleDelivery;
    data['timeslotes'] = this.timeslotes;
    data['payable'] = this.payable;
    data['wallet_amount'] = this.walletAmount;
    data['tip_amount'] = this.tipAmount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['sub_total'] = this.subTotal;
    data['cash_change_amount'] = this.cashChangeAmount;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  int id;
  String name;
  String description;
  Null locationId;
  String image;
  String rating;
  String deliveryTime;
  String priceRange;
  String isPureveg;
  String slug;
  Null placeholderImage;
  String latitude;
  String longitude;
  Null certificate;
  Null restaurantCharges;
  String deliveryCharges;
  String address;
  Null pincode;
  Null landmark;
  String sku;
  int isActive;
  int isAccepted;
  int isFeatured;
  String commissionRate;
  int deliveryType;
  String timeslotes;
  int deliveryRadius;
  String deliveryChargeType;
  Null baseDeliveryCharge;
  Null baseDeliveryDistance;
  Null extraDeliveryCharge;
  Null extraDeliveryDistance;
  String minOrderPrice;
  String isNotifiable;
  String autoAcceptable;
  Null scheduleData;
  String isSchedulable;
  String orderColumn;
  Null customMessage;
  bool isOrderscheduling;

  Restaurant(
      {this.id,
        this.name,
        this.description,
        this.locationId,
        this.image,
        this.rating,
        this.deliveryTime,
        this.priceRange,
        this.isPureveg,
        this.slug,
        this.placeholderImage,
        this.latitude,
        this.longitude,
        this.certificate,
        this.restaurantCharges,
        this.deliveryCharges,
        this.address,
        this.pincode,
        this.landmark,
        this.sku,
        this.isActive,
        this.isAccepted,
        this.isFeatured,
        this.commissionRate,
        this.deliveryType,
        this.timeslotes,
        this.deliveryRadius,
        this.deliveryChargeType,
        this.baseDeliveryCharge,
        this.baseDeliveryDistance,
        this.extraDeliveryCharge,
        this.extraDeliveryDistance,
        this.minOrderPrice,
        this.isNotifiable,
        this.autoAcceptable,
        this.scheduleData,
        this.isSchedulable,
        this.orderColumn,
        this.customMessage,
        this.isOrderscheduling});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    locationId = json['location_id'];
    image = json['image'];
    rating = json['rating'];
    deliveryTime = json['delivery_time'];
    priceRange = json['price_range'];
    isPureveg = json['is_pureveg'];
    slug = json['slug'];
    placeholderImage = json['placeholder_image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    certificate = json['certificate'];
    restaurantCharges = json['restaurant_charges'];
    deliveryCharges = json['delivery_charges'];
    address = json['address'];
    pincode = json['pincode'];
    landmark = json['landmark'];
    sku = json['sku'];
    isActive = json['is_active'];
    isAccepted = json['is_accepted'];
    isFeatured = json['is_featured'];
    commissionRate = json['commission_rate'];
    deliveryType = json['delivery_type'];
    timeslotes = json['timeslotes'];
    deliveryRadius = json['delivery_radius'];
    deliveryChargeType = json['delivery_charge_type'];
    baseDeliveryCharge = json['base_delivery_charge'];
    baseDeliveryDistance = json['base_delivery_distance'];
    extraDeliveryCharge = json['extra_delivery_charge'];
    extraDeliveryDistance = json['extra_delivery_distance'];
    minOrderPrice = json['min_order_price'];
    isNotifiable = json['is_notifiable'];
    autoAcceptable = json['auto_acceptable'];
    scheduleData = json['schedule_data'];
    isSchedulable = json['is_schedulable'];
    orderColumn = json['order_column'];
    customMessage = json['custom_message'];
    isOrderscheduling = json['is_orderscheduling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location_id'] = this.locationId;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['delivery_time'] = this.deliveryTime;
    data['price_range'] = this.priceRange;
    data['is_pureveg'] = this.isPureveg;
    data['slug'] = this.slug;
    data['placeholder_image'] = this.placeholderImage;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['certificate'] = this.certificate;
    data['restaurant_charges'] = this.restaurantCharges;
    data['delivery_charges'] = this.deliveryCharges;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['landmark'] = this.landmark;
    data['sku'] = this.sku;
    data['is_active'] = this.isActive;
    data['is_accepted'] = this.isAccepted;
    data['is_featured'] = this.isFeatured;
    data['commission_rate'] = this.commissionRate;
    data['delivery_type'] = this.deliveryType;
    data['timeslotes'] = this.timeslotes;
    data['delivery_radius'] = this.deliveryRadius;
    data['delivery_charge_type'] = this.deliveryChargeType;
    data['base_delivery_charge'] = this.baseDeliveryCharge;
    data['base_delivery_distance'] = this.baseDeliveryDistance;
    data['extra_delivery_charge'] = this.extraDeliveryCharge;
    data['extra_delivery_distance'] = this.extraDeliveryDistance;
    data['min_order_price'] = this.minOrderPrice;
    data['is_notifiable'] = this.isNotifiable;
    data['auto_acceptable'] = this.autoAcceptable;
    data['schedule_data'] = this.scheduleData;
    data['is_schedulable'] = this.isSchedulable;
    data['order_column'] = this.orderColumn;
    data['custom_message'] = this.customMessage;
    data['is_orderscheduling'] = this.isOrderscheduling;
    return data;
  }
}*/
