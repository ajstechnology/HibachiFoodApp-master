class CouponsModel {
  int id;
  String name;
  String description;
  String code;
  String discountType;
  String discount;
  String expiryDate;
  String isActive;
  String createdAt;
  String updatedAt;
  String restaurantId;
  String count;
  String maxCount;
  String minSubtotal;
  String maxDiscount;
  String subtotalMessage;
  String userType;
  String maxCountPerUser;
  List<Restaurants> restaurants = [];
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new CouponsModel.fromJson(job)).toList();
  }

  CouponsModel(
      {this.id,
      this.name,
      this.description,
      this.code,
      this.discountType,
      this.discount,
      this.expiryDate,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.restaurantId,
      this.count,
      this.maxCount,
      this.minSubtotal,
      this.maxDiscount,
      this.subtotalMessage,
      this.userType,
      this.maxCountPerUser,
      this.restaurants});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    discountType = json['discount_type'];
    discount = json['discount'];
    expiryDate = json['expiry_date'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantId = json['restaurant_id'];
    count = json['count'];
    maxCount = json['max_count'];
    minSubtotal = json['min_subtotal'];
    maxDiscount = json['max_discount'];
    subtotalMessage = json['subtotal_message'];
    userType = json['user_type'];
    maxCountPerUser = json['max_count_per_user'];
    if (json['restaurants'] != null) {
      restaurants = [];
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['expiry_date'] = this.expiryDate;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['restaurant_id'] = this.restaurantId;
    data['count'] = this.count;
    data['max_count'] = this.maxCount;
    data['min_subtotal'] = this.minSubtotal;
    data['max_discount'] = this.maxDiscount;
    data['subtotal_message'] = this.subtotalMessage;
    data['user_type'] = this.userType;
    data['max_count_per_user'] = this.maxCountPerUser;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
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
  Pivot pivot;

  Restaurants(
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
      this.isOrderscheduling,
      this.pivot});

  Restaurants.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
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
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  String couponId;
  String restaurantId;

  Pivot({this.couponId, this.restaurantId});

  Pivot.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    restaurantId = json['restaurant_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['restaurant_id'] = this.restaurantId;
    return data;
  }
}
