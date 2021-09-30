class VerifyOtpModel {
  bool success;
  String status;
  String data;

  VerifyOtpModel({this.success, this.status, this.data});

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['data'] = this.data;
    return data;
  }
}
