class OrdersAPIModel {
  int id;
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
  String deliveryType;
  String scheduleDelivery;
  String timeslotes;
  int payable;
  int walletAmount;
  int tipAmount;
  int taxAmount;
  int couponAmount;
  int subTotal;
  bool isRatable;
  List<Orderitems> orderitems;
  Restaurant restaurant;
  String rating;
  String driverId;
  String deliveryPin;
  String customerLat;
  String customerLon;
  // delivery_pin

  OrdersAPIModel(
      {this.id,
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
      this.deliveryType,
      this.payable,
      this.walletAmount,
      this.tipAmount,
      this.taxAmount,
      this.couponAmount,
      this.subTotal,
      this.isRatable,
      this.orderitems,
      this.restaurant,
      this.rating,
      this.driverId,
      this.deliveryPin,
      this.customerLat,
      this.customerLon});

  static fromJsonList(List<dynamic> input) {
    List value = input.map((job) => new OrdersAPIModel.fromJson(job)).toList();
    return value;
  }

  OrdersAPIModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    deliveryType = json['delivery_type'];
    payable = json['payable'];
    walletAmount = json['wallet_amount'];
    tipAmount = json['tip_amount'];
    taxAmount = json['tax_amount'];
    couponAmount = json['coupon_amount'];
    subTotal = json['sub_total'];
    isRatable = json['is_ratable'];
    scheduleDelivery = json['schedule_delivery'];
    timeslotes = json['timeslotes'];
    customerLat = json['customer_lat'];
    customerLon = json['customer_lng'];
    if (json['driver'] != null) {
      driverId = json['driver'];
    }
    if (json['delivery_pin'] != null) {
      deliveryPin = json['delivery_pin'];
    } else {
      deliveryPin = "N/A";
    }

    if (json['orderitems'] != null) {
      orderitems = <Orderitems>[];
      json['orderitems'].forEach((v) {
        orderitems.add(new Orderitems.fromJson(v));
      });
    }
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    rating = json['rating'];
  }

  Map<String, dynamic> toJson(values) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['delivery_type'] = this.deliveryType;
    data['payable'] = this.payable;
    data['wallet_amount'] = this.walletAmount;
    data['tip_amount'] = this.tipAmount;
    data['tax_amount'] = this.taxAmount;
    data['coupon_amount'] = this.couponAmount;
    data['sub_total'] = this.subTotal;
    data['is_ratable'] = this.isRatable;
    data['schedule_delivery'] = this.scheduleDelivery;
    data['timeslotes'] = this.timeslotes;
    data['driver'] = this.driverId;
    data['delivery_pin'] = this.deliveryPin;
    data['customer_lat'] = this.customerLat;
    data['customer_lng'] = this.customerLon;

    if (this.orderitems != null) {
      data['orderitems'] = this.orderitems.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    data['rating'] = this.rating;
    return data;
  }
}

class Orderitems {
  int id;
  String orderId;
  String itemId;
  String name;
  String quantity;
  String price;
  String createdAt;
  String updatedAt;
  List<OrderItemAddons> orderItemAddons;

  Orderitems(
      {this.id,
      this.orderId,
      this.itemId,
      this.name,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.orderItemAddons});

  Orderitems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    itemId = json['item_id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order_item_addons'] != null) {
      orderItemAddons = [];
      json['order_item_addons'].forEach((v) {
        orderItemAddons.add(new OrderItemAddons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;

    return data;
  }
}

class OrderItemAddons {
  int orderItemAddonsId;
  OrderItemAddons.fromJson(Map<String, dynamic> json) {
    orderItemAddonsId = json['id'];
  }
}

class Restaurant {
  int id;
  String name;
  String description;
  int locationId;
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
  int deliveryRadius;
  String deliveryChargeType;
  String baseDeliveryCharge;
  String baseDeliveryDistance;
  String extraDeliveryCharge;
  String extraDeliveryDistance;
  String minOrderPrice;
  String isNotifiable;
  String autoAcceptable;
  String scheduleData;
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
