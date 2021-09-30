class ForgotPasswordResponseModel {
  bool success;
  String message;
  String errorCode;

  ForgotPasswordResponseModel({this.success, this.message, this.errorCode});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['error_code'] = this.errorCode;
    return data;
  }
}
