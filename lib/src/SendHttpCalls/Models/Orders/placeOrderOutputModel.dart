class PlaceOrderOutputModel {
  bool success;
  Data data;

  PlaceOrderOutputModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String uniqueOrderId;
  int userId;
  int orderstatusId;
  String location;
  String address;
  String restaurantCharge;
  String transactionId;
  int subTotal;
  String couponName;
  int couponAmount;
  String deliveryCharge;
  int taxAmount;
  int payable;
  int total;
  String orderComment;
  String paymentMode;
  int restaurantId;
  int tipAmount;
  int deliveryType;
  String updatedAt;
  String createdAt;
  int id;
  int walletAmount;

  Data(
      {this.uniqueOrderId,
      this.userId,
      this.orderstatusId,
      this.location,
      this.address,
      this.restaurantCharge,
      this.transactionId,
      this.subTotal,
      this.couponName,
      this.couponAmount,
      this.deliveryCharge,
      this.taxAmount,
      this.payable,
      this.total,
      this.orderComment,
      this.paymentMode,
      this.restaurantId,
      this.tipAmount,
      this.deliveryType,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.walletAmount});

  Data.fromJson(Map<String, dynamic> json) {
    uniqueOrderId = json['unique_order_id'];
    userId = json['user_id'];
    orderstatusId = json['orderstatus_id'];
    location = json['location'];
    address = json['address'];
    restaurantCharge = json['restaurant_charge'];
    transactionId = json['transaction_id'];
    subTotal = json['sub_total'];
    couponName = json['coupon_name'];
    couponAmount = json['coupon_amount'];
    deliveryCharge = json['delivery_charge'];
    taxAmount = json['tax_amount'];
    payable = json['payable'];
    total = json['total'];
    orderComment = json['order_comment'];
    paymentMode = json['payment_mode'];
    restaurantId = json['restaurant_id'];
    tipAmount = json['tip_amount'];
    deliveryType = json['delivery_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    walletAmount = json['wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unique_order_id'] = this.uniqueOrderId;
    data['user_id'] = this.userId;
    data['orderstatus_id'] = this.orderstatusId;
    data['location'] = this.location;
    data['address'] = this.address;
    data['restaurant_charge'] = this.restaurantCharge;
    data['transaction_id'] = this.transactionId;
    data['sub_total'] = this.subTotal;
    data['coupon_name'] = this.couponName;
    data['coupon_amount'] = this.couponAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['tax_amount'] = this.taxAmount;
    data['payable'] = this.payable;
    data['total'] = this.total;
    data['order_comment'] = this.orderComment;
    data['payment_mode'] = this.paymentMode;
    data['restaurant_id'] = this.restaurantId;
    data['tip_amount'] = this.tipAmount;
    data['delivery_type'] = this.deliveryType;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
