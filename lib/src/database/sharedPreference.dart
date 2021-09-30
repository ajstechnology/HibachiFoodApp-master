import 'dart:convert';
import 'package:location/location.dart';
import '../SendHttpCalls/Models/Address/addressInputModel.dart';
import '../SendHttpCalls/Models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserModel loggedInUser;
LocationData userCurrentPosition;
String userNotificationToken = "";
Future<bool> saveInSharePrefernece(String key, data) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
    return true;
  } catch (ex) {
    print('Exception while saveInSharePrefernece ' + ex.toString());
    return false;
  }
}

Future<bool> saveListInSharePrefernece(String key, List<String> data) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, data);
    return true;
  } catch (ex) {
    print('Exception while saveInSharePrefernece ' + ex.toString());
    return false;
  }
}

Future<List<String>> getListFromSharePrefernece(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(key);
  } catch (ex) {
    print('Exception while saveInSharePrefernece ' + ex.toString());
    return null;
  }
}

Future<String> getValueFromSharePrefernece(String key) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  } catch (ex) {
    print('Exception while getValueFromSharePrefernece ' + ex.toString());
    return null;
  }
}

Future<UserModel> checkLogin() async {
  var userInSP = await getValueFromSharePrefernece('LoggedInUser');
  Map<String, dynamic> userMap;
  if (userInSP != null) {
    userMap = jsonDecode(userInSP) as Map<String, dynamic>;
    return UserModel.fromJSON(userMap);
  } else {
    return null;
  }
}

Future<bool> logOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  loggedInUser = null;
  prefs.remove('LoggedInUser');
  return true;
}

Future<bool> updateUserAddress(UserAddressInputModel inputModel) async {
  try {
    loggedInUser.defaultAddress = new DefaultAddress(
        address: inputModel.address,
        house: inputModel.house,
        latitude: inputModel.latitude,
        longitude: inputModel.longitude,
        tag: '');
    await saveInSharePrefernece('LoggedInUser', loggedInUser.toJson());
    return true;
  } catch (ex) {
    return false;
  }
}
