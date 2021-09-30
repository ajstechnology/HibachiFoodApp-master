class RestaurantTimeSlotApiModel {
  Restaurants restaurants;
  List<TimeSlotsModel> timeslotes;

  RestaurantTimeSlotApiModel({this.restaurants, this.timeslotes});

  RestaurantTimeSlotApiModel.fromJson(Map<String, dynamic> json) {
    restaurants = json['restaurants'] != null
        ? new Restaurants.fromJson(json['restaurants'])
        : null;
    if (json['timeslotes'] != null) {
      timeslotes = [];
      json['timeslotes'].forEach((v) {
        timeslotes.add(new TimeSlotsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.toJson();
    }
    if (this.timeslotes != null) {
      data['timeslotes'] = this.timeslotes.map((v) => v.toJson()).toList();
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
  String avgRating;

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
      this.avgRating});

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
    avgRating = json['avgRating'];
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
    data['avgRating'] = this.avgRating;
    return data;
  }
}

class TimeSlotsModel {
  String id;
  String fromtimeslots;
  String fromampm;
  String totimeslote;
  String toampm;
  String status;
  String createdAt;
  String updatedAt;

  TimeSlotsModel(
      {this.id,
      this.fromtimeslots,
      this.fromampm,
      this.totimeslote,
      this.toampm,
      this.status,
      this.createdAt,
      this.updatedAt});

  TimeSlotsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromtimeslots = json['fromtimeslots'];
    fromampm = json['fromampm'];
    totimeslote = json['totimeslote'];
    toampm = json['toampm'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromtimeslots'] = this.fromtimeslots;
    data['fromampm'] = this.fromampm;
    data['totimeslote'] = this.totimeslote;
    data['toampm'] = this.toampm;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
