class CouponOutputModel {
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
  int maxCountPerUser;
  bool success;

  CouponOutputModel(
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
      this.success});

  CouponOutputModel.fromJson(Map<String, dynamic> json) {
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
    success = json['success'];
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
    data['success'] = this.success;
    return data;
  }
}
