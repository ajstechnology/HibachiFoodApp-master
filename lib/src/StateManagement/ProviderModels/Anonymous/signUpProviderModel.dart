import 'package:flutter/cupertino.dart';
import '../../../SendHttpCalls/anonymousApis.dart';

class SignUpProviderModel extends ChangeNotifier {
  String _name;
  String _email;
  String _mobileNumber;
  String _password;
  bool _isRegister = false;
  bool _isLoading = false;
  String _errorMessage = '';

  final _nameController = TextEditingController();
  TextEditingController getUserNameController() => _nameController;
  final _emailController = TextEditingController();
  TextEditingController getEmailController() => _emailController;

  final _mobileNoController = TextEditingController(text: "+91");
  TextEditingController getMobileNoController() => _mobileNoController;

  final _passwordController = TextEditingController();
  TextEditingController getPasswordController() => _passwordController;

  bool getIsRegister() => _isRegister;
  bool getIsLoading() => _isLoading;

  String getErrorMessage() => this._errorMessage;

  resetMobileText() {
    _passwordController.text = "+91";
  }

  SignUpProviderModel() {
    // this._nameController.text = "Wajid";
    // this._emailController.text = "abc@gmail.com";
    // this._mobileNoController.text = "+923419117511";
    // this._passwordController.text = "123456789";
  }

  registor() async {
    _name = _nameController.text;
    _email = _emailController.text;
    _mobileNumber = _mobileNoController.text;
    _password = _passwordController.text;
    if (_name == "") {
      _errorMessage = 'Please enter your name. ';
      notifyListeners();
      return;
    }
    if (_name.length < 3) {
      _errorMessage = 'Name should not be less then 3 characters. ';
      notifyListeners();
      return;
    }
    if (!_isValidEmail(_email)) {
      _errorMessage = 'Please enter a valid email address. ';
      notifyListeners();
      return;
    }
    if (!_mobileNumber.startsWith("+91")) {
      _errorMessage = 'Mobile number should start with +91';
      notifyListeners();
      return;
    }
    if (_mobileNumber.length < 7) {
      _errorMessage = 'Please valid mobile number.';
      notifyListeners();
      return;
    }
    if (_password.length < 8) {
      _errorMessage = 'Password length should be atleast 8 character';
      notifyListeners();
      return;
    }
    _errorMessage = "";
    _isLoading = true;
    notifyListeners();
    var statusCode =
        await registerUser(_name, _email, _mobileNumber, _password);

    if (statusCode == 201) {
      _isRegister = true;
      _nameController.text = "";
      _passwordController.text = "";
      _emailController.text = "";
      _mobileNoController.text = "";
      _errorMessage = '';
    } else if (statusCode == 200) {
      _isRegister = false;
      _errorMessage = "Email or phone is already registered.";
    } else if (statusCode == 500) {
      _isRegister = false;
      _errorMessage = "Unable to register, please contact us.";
    } else if (statusCode == 403) {
      _isRegister = false;
      _errorMessage = "Email or phone already registered.";
    } else {
      _isRegister = false;
      _errorMessage =
          "Unable to register,please contact with our support status Code:" +
              statusCode.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  bool _isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
