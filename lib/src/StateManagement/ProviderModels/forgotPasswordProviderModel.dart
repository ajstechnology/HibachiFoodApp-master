import 'package:flutter/cupertino.dart';
import '../../SendHttpCalls/anonymousApis.dart';

class ForgotPasswordProviderModel extends ChangeNotifier {
  String _email;
  String _otp;
  String _password;
  bool _isLoading = false;
  String _errorMessage = '';
  final _emailController = TextEditingController(text: "");
  TextEditingController getEmailController() => _emailController;

  final _passwordController = TextEditingController(text: "");
  TextEditingController getPasswordController() => _passwordController;

  String getEmail() => _email;
  bool getIsLoading() => _isLoading;
  String getErrorMessage() => _errorMessage;

  bool _isPlaying = true;
  bool _isVerified = false;

  bool getVerifyIsPlaying() => _isPlaying;

  bool getVerified() => _isVerified;

  setVerifyingIsPlaying(bool isPlaying) {
    this._isPlaying = isPlaying;
    notifyListeners();
  }

  Future<bool> sendOtp() async {
    _email = _emailController.text;
    if (_email == '') {
      _errorMessage = 'Please enter email';
      return false;
    }
    _isLoading = true;
    notifyListeners();

    Future.delayed(Duration(seconds: 10));
    var response = await sendForgotPasswordEmail(_email);
    if (response == "Done") {
      _errorMessage = '';
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  setPin(pin) {
    _otp = pin;
  }

  updatePassword() async {
    _email = _emailController.text;
    _password = _passwordController.text;
    if (_otp == '') {
      _errorMessage = 'Please enter OTP';
      return;
    }
    if (_password == '') {
      _errorMessage = 'Please enter Password.';
      return;
    }
    _isLoading = true;
    notifyListeners();

    var response =
        await forgotPasswordVerifyAndUpdatePassword(_email, _otp, _password);
    if (response == "Done") {
      _errorMessage = '';
      _emailController.text = "";
      _passwordController.text = "";
      _isVerified = true;
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = response;
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
