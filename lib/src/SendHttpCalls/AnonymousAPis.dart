import 'dart:convert';
import 'Models/apiGenralModel.dart';
import 'Models/forgotPasswordResponseModel.dart';
import 'Models/verifyOtpModel.dart';
import 'apiRoutes.dart';
import 'package:http/http.dart' as http;

Future<APIGeneraicModel> getUser(String userName, String password) async {
  try {
    String url =
        APIRoute.getLoginURL() + "email=" + userName + "&password=" + password;
    print("Login url" + url);
    var response = await http.post(Uri.parse(url));
    print('getLoginURL ${response.body}');
    if (response.statusCode == 201) {
      return APIGeneraicModel.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (ex) {
    print("Error getUser()" + ex.toString());
    return null;
  }
}

Future<int> registerUser(
    String name, String email, String mobileNo, String password) async {
  try {
    String url = APIRoute.getRegisterURL() +
        "name=" +
        name +
        "&email=" +
        email +
        "&phone=" +
        mobileNo +
        "&password=" +
        password;
    print(url);
    var response = await http.post(Uri.parse(url));
    print('getRegisterURL ${response.body}');
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (responseData["email_phone_already_used"] == true) {
        return 403;
      }
      return 200;
    } else if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      var parseData = APIGeneraicModel.fromJson(responseData);
      if (parseData.success) {
        return response.statusCode;
      } else {
        return 500;
      }
    } else {
      return 500;
    }
  } catch (ex) {
    print("getRegisterURL() " + ex.toString());
    return 500;
  }
}

Future<String> verifyUser(String phoneNo, String otp) async {
  try {
    String url =
        APIRoute.getVerifyOTPURL() + "phone=" + phoneNo + "&otp=" + otp;
    var response = await http.post(Uri.parse(url));
    print('getVerifyOTPURL ${response.body}');
    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      var parseData = VerifyOtpModel.fromJson(responseData);
      if (parseData.success) {
        return "Done";
      } else {
        return parseData.data;
      }
    } else {
      return "Unable to connect with server, please try again.";
    }
  } catch (ex) {
    print("verifyUser " + ex.toString());
    return "Unable to connect with server, please try again.";
  }
}

Future<bool> reSendOtp(String phoneNo, String email) async {
  try {
    String url =
        APIRoute.getReSendOTPURL() + "phone=" + phoneNo + "&email=" + email;
    var response = await http.post(Uri.parse(url));
    print('getReSendOTPURL ${response.body}');
    if (response.statusCode == 201) {
      //var responseData = jsonDecode(response.body);
      // var parseData = SignUpApiModel.fromJson(responseData);
      // if (parseData.success) {
      //   return true;
      // } else {
      //   return false;
      // }
      return true;
    } else {
      return false;
    }
  } catch (ex) {
    print(ex.toString());
    return false;
  }
}

Future<String> sendForgotPasswordEmail(String email) async {
  try {
    String url = APIRoute.getSendPasswordResetMail() + "email=" + email;
    print(url);
    var response = await http.post(Uri.parse(url));
    print('sendForgotPasswordEmail ${response.body}');

    if (response.statusCode == 200) {
      var responseModel =
          ForgotPasswordResponseModel.fromJson(jsonDecode(response.body));
      if (responseModel.success) {
        return "Done";
      }
      return responseModel.message;
    }
    return "Error occured while sending email";
  } catch (ex) {
    print("sendForgotPasswordEmail()" + ex.toString());
    return "Error " + ex.toString();
  }
}

Future<String> forgotPasswordVerifyAndUpdatePassword(
    String email, String otp, String password) async {
  try {
    String url = APIRoute.getForgotPasswordVerify() +
        "email=" +
        email +
        "&code=" +
        otp +
        "&password=" +
        password;
    print(url);
    var response = await http.post(Uri.parse(url));
    print('forgotPasswordVerifyAndUpdatePassword ${response.body}');

    if (response.statusCode == 200) {
      var responseModel =
          ForgotPasswordResponseModel.fromJson(jsonDecode(response.body));
      if (responseModel.success) {
        return "Done";
      }
      return responseModel.message;
    }
    return "Error occured while sending email";
  } catch (ex) {
    print("forgotPasswordVerifyAndUpdatePassword()" + ex.toString());
    return "Error " + ex.toString();
  }
}
