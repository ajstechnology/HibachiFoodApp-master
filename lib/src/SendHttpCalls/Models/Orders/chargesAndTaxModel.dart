class ChargesAndTaxModel {
  bool success;
  ChargesAndTaxModelData data;

  ChargesAndTaxModel({this.success, this.data});

  ChargesAndTaxModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new ChargesAndTaxModelData.fromJson(json['data'])
        : null;
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

class ChargesAndTaxModelData {
  String taxPercentage;
  String deliveryCharges;

  ChargesAndTaxModelData({this.taxPercentage, this.deliveryCharges});

  ChargesAndTaxModelData.fromJson(Map<String, dynamic> json) {
    taxPercentage = json['tax_percentage'];
    deliveryCharges = json['delivery_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tax_percentage'] = this.taxPercentage;
    data['delivery_charges'] = this.deliveryCharges;
    return data;
  }
}
