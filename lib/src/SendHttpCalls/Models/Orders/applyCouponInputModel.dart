class ApplyCouponInputModel {
  String resturantId;
  String couponCode;
  String subTotal;
  ApplyCouponInputModel(this.resturantId, this.couponCode, this.subTotal);
  ApplyCouponInputModel.fromJson(Map<String, dynamic> json) {
    resturantId = json['restaurant_id'];
    couponCode = json['coupon'];
    subTotal = json['subtotal'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.resturantId;
    data['coupon'] = this.couponCode;
    data['subtotal'] = this.subTotal;
    return data;
  }
}
