class AddressApiModel {
  int id;
  String userId;
  String address;
  String house;
  String landmark;
  String tag;
  String createdAt;
  String updatedAt;
  String latitude;
  String longitude;
  String doorNo;
  String arrivalComment;
  AddressApiModel(
      {this.id,
      this.userId,
      this.address,
      this.house,
      this.landmark,
      this.tag,
      this.createdAt,
      this.updatedAt,
      this.latitude,
      this.longitude,
      this.arrivalComment,
      this.doorNo});

  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new AddressApiModel.fromJson(job)).toList();
  }

  AddressApiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    address = json['address'];
    house = json['house'];
    landmark = json['landmark'];
    tag = json['tag'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    arrivalComment = json['arrival_comment'];
    doorNo = json['door_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['house'] = this.house;
    data['landmark'] = this.landmark;
    data['tag'] = this.tag;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['arrival_comment'] = this.arrivalComment;
    data['door_no'] = this.doorNo;
    return data;
  }
}
