import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import '../../database/sharedPreference.dart';
import '../../SendHttpCalls/userAPIs.dart';

class UpdatePasswordProviderModel extends ChangeNotifier {
  bool isUpdate;
  bool isUpdating = false;
  String errorMessage = '';
  String myProfilePicture;
  Uint8List getMyProfilePicture() {
    return loggedInUser.image;
  }

  /*String getMyProfilePicture() {
    var image = loggedInUser.image;
    if (isBase64(image)) {
      return myProfilePicture = image;
    }
    return null;
  }*/

  final _nameController = TextEditingController(
      text: loggedInUser == null ? "" : loggedInUser.name);
  TextEditingController getNameController() => _nameController;

  final _emailController = TextEditingController(
      text: loggedInUser == null ? "" : loggedInUser.email);
  TextEditingController getEmailController() => _emailController;

  final _passwordController = TextEditingController();
  TextEditingController getPasswordController() => _passwordController;

  final _rePasswordController = TextEditingController();
  TextEditingController getRePasswordController() => _rePasswordController;

  Future<bool> updateMyProfile(PickedFile file, String userId) async {
    if (await userProfileUploadProvider(file, userId)) {
      loggedInUser.image = await file.readAsBytes();
      // to update image in folder
      saveInSharePrefernece('LoggedInUser', loggedInUser.toJson());
      notifyListeners();
      return true;
    } else {
      return true;
    }
  }

  Future<bool> updateMyPassword() async {
    if (_passwordController.text != _rePasswordController.text) {
      errorMessage = "Password and Re-Password should match.";
      notifyListeners();
      return false;
    }
    isUpdating = true;
    notifyListeners();

    if (await updateUserInfoPassword() == false) {
      isUpdate = false;
      errorMessage = "Unable to update your password";
      return false;
    } else {
      _passwordController.text = "";
      _rePasswordController.text = "";

      errorMessage = '';
    }
    isUpdating = false;
    notifyListeners();
    return true;
  }

  Future<bool> updateMyInfoPassord() async {
    isUpdating = true;
    notifyListeners();

    loggedInUser.name = _nameController.text;
    loggedInUser.email = _emailController.text;
    loggedInUser.password = _passwordController.text;
    if (await updateUserInfoPassword() == false) {
      isUpdate = false;
      errorMessage = "Unable to update your profile info";
      return false;
    } else {
      _passwordController.text = "";
      errorMessage = '';
    }
    isUpdating = false;
    notifyListeners();
    return true;
  }
}
