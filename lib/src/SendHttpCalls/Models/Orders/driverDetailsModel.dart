class DriverDetailsModel {
  String name;
  String age;
  String photo;
  String description;
  String vehicleNumber;
  String commissionRate;
  String isNotifiable;
  String maxAcceptDeliveryLimit;
  String deliveryLat;
  String deliveryLong;
  String heading;
  String tipCommissionRate;
  int status;
  String phone;
  String deliveryPin;

  DriverDetailsModel(
      {this.name,
      this.age,
      this.photo,
      this.description,
      this.vehicleNumber,
      this.commissionRate,
      this.isNotifiable,
      this.maxAcceptDeliveryLimit,
      this.deliveryLat,
      this.deliveryLong,
      this.heading,
      this.tipCommissionRate,
      this.status,
      this.phone,
      this.deliveryPin});

  DriverDetailsModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "N/A";
    age = json['age'] ?? "N/A";
    photo = json['photo'] ?? "N/A";
    description = json['description'] ?? "N/A";
    vehicleNumber = json['vehicle_number'] ?? "N/A";
    commissionRate = json['commission_rate'] ?? "N/A";
    isNotifiable = json['is_notifiable'] ?? "N/A";
    maxAcceptDeliveryLimit = json['max_accept_delivery_limit'] ?? "N/A";
    deliveryLat = json['delivery_lat'] ?? "N/A";
    deliveryLong = json['delivery_long'] ?? "N/A";
    heading = json['heading'] ?? "N/A";
    tipCommissionRate = json['tip_commission_rate'] ?? "N/A";
    status = json['status'] ?? 0;
    phone = json['phone'] ?? "N/A";
    deliveryPin = json['delivery_pin'] ?? "N/A";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['vehicle_number'] = this.vehicleNumber;
    data['commission_rate'] = this.commissionRate;
    data['is_notifiable'] = this.isNotifiable;
    data['max_accept_delivery_limit'] = this.maxAcceptDeliveryLimit;
    data['delivery_lat'] = this.deliveryLat;
    data['delivery_long'] = this.deliveryLong;
    data['heading'] = this.heading;
    data['tip_commission_rate'] = this.tipCommissionRate;
    data['status'] = this.status;
    data['phone'] = this.phone;
    data['delivery_pin'] = this.deliveryPin;
    return data;
  }
}
