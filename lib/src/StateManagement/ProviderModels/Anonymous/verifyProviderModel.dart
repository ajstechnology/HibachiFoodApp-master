import 'package:flutter/cupertino.dart';
import '../../../SendHttpCalls/AnonymousAPis.dart';

class VerifyProviderModel extends ChangeNotifier {
  bool _isVerifying = false;
  bool _isVerified = false;
  bool _isPlaying = true;
  String _otp;
  bool _isReSending = false;
  String _errorMessage = '';
  String _mobileNumber;
  String _email;
  VerifyProviderModel(String email, String mobilNo) {
    _email = email;
    _mobileNumber = mobilNo;
  }
  bool getVerifyIsPlaying() => _isPlaying;
  bool getVerifying() => _isVerifying;
  bool getVerified() => _isVerified;
  bool getIsReSending() => _isReSending;
  String getErrorMessage() => this._errorMessage;
  String getMobileNo() => this._mobileNumber;

  setOTP(String otp) {
    this._otp = otp;
    print("Entered OTP" + otp);
  }

  setVerifyingIsPlaying(bool isPlaying) {
    this._isPlaying = isPlaying;
    notifyListeners();
  }

  verifyAccount() async {
    _isVerifying = true;
    notifyListeners();
    String isSucessMessage = await verifyUser(_mobileNumber, _otp);

    if (isSucessMessage == "Done") {
      _isVerified = true;
      _errorMessage = '';
    } else {
      _isVerified = false;
      _errorMessage = isSucessMessage;
    }
    _isVerifying = false;
    notifyListeners();
  }

  //to resend the otp
  reSendOTP() async {
    _isReSending = true;
    notifyListeners();
    var isSucess = await reSendOtp(_mobileNumber, _email);

    if (isSucess == false) {
      _errorMessage = "Unable to Resend OTP.";
    } else {
      _errorMessage = '';
    }
    _isReSending = false;
    notifyListeners();
  }
}
