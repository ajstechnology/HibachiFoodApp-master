import '../apiRoutes.dart';

class SearchProductModel {
  List<SearchItems> items;

  SearchProductModel({this.items});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(new SearchItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchItems {
  int id;
  String restaurantId;
  String itemCategoryId;
  String name;
  String price;
  String oldPrice;
  String image;
  int isRecommended;
  int isPopular;
  int isNew;
  String desc;
  String placeholderImage;
  int isActive;
  bool isVeg;
  String orderColumn;
  Restaurant restaurant;

  SearchItems(
      {this.id,
      this.restaurantId,
      this.itemCategoryId,
      this.name,
      this.price,
      this.oldPrice,
      this.image,
      this.isRecommended,
      this.isPopular,
      this.isNew,
      this.desc,
      this.placeholderImage,
      this.isActive,
      this.isVeg,
      this.orderColumn,
      this.restaurant});

  SearchItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    itemCategoryId = json['item_category_id'];
    name = json['name'];
    price = json['price'];
    oldPrice = json['old_price'];
    image = APIRoute.getBaseUrl() + json['image'];
    isRecommended = json['is_recommended'];
    isPopular = json['is_popular'];
    isNew = json['is_new'];
    desc = json['desc'];
    placeholderImage = json['placeholder_image'];
    isActive = json['is_active'];
    isVeg = json['is_veg'];
    orderColumn = json['order_column'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['item_category_id'] = this.itemCategoryId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['image'] = this.image;
    data['is_recommended'] = this.isRecommended;
    data['is_popular'] = this.isPopular;
    data['is_new'] = this.isNew;
    data['desc'] = this.desc;
    data['placeholder_image'] = this.placeholderImage;
    data['is_active'] = this.isActive;
    data['is_veg'] = this.isVeg;
    data['order_column'] = this.orderColumn;
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
  List<String> deliveryAreas;

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
      this.isOrderscheduling,
      this.deliveryAreas});

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
    if (json['delivery_areas'] != null) {
      deliveryAreas = [];
    }
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
    if (this.deliveryAreas != null) {
      data['delivery_areas'] = [];
    }
    return data;
  }
}
