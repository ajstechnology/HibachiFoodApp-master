class UserAddressInputModel {
  int user_id;
  double latitude;
  double longitude;
  String address;
  String house;
  String landmark;
  String doorNo;
  String arrivalComment;
  String tag;
  UserAddressInputModel();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['house'] = this.house;
    data['landmark'] = this.landmark;
    data['door_no'] = this.doorNo;
    data['arrival_comment'] = this.arrivalComment;
    data['tag'] = this.tag;
    return data;
  }
}
