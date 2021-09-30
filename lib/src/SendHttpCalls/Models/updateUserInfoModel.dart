class UpdateUserInfoModel {
  String name;
  String email;
  String password;
  UpdateUserInfoModel(this.name, this.email, this.password);
  UpdateUserInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
