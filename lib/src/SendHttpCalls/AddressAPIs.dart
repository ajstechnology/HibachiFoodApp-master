import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

import '../StateManagement/ProviderModels/Addresses/addressApiModel.dart';
import '../database/sharedPreference.dart';
import 'Models/Address/addressInputModel.dart';
import 'apiRoutes.dart';

Future<bool> addUserAddres(UserAddressInputModel inputModel) async {
  try {
    String url = APIRoute.getSaveAddressURL() +
        "user_id=" +
        inputModel.user_id.toString() +
        "&latitude=" +
        inputModel.latitude.toString() +
        "&longitude=" +
        inputModel.longitude.toString() +
        "&address=" +
        inputModel.address +
        "&house=" +
        inputModel.house +
        '&landmark=' +
        inputModel.landmark +
        '&door_no=' +
        inputModel.doorNo +
        '&arrival_comment=' +
        inputModel.arrivalComment +
        '&tag=' +
        inputModel.tag;
    print("Save Address URL" + url);
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print("save address " + response.body);
      List<dynamic> listOfAddress = jsonDecode(response.body);
      var parseData = AddressApiModel.fromJsonList(listOfAddress);
      if (parseData.length > 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (ex) {
    print(ex.toString());
    return false;
  }
}

Future<List<AddressApiModel>> getUserAddresFromServer() async {
  try {
    String url = APIRoute.getAddressURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("$url getUserAddresFromServer() " + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> listOfAddress = jsonDecode(response.body);
      var parseData = AddressApiModel.fromJsonList(listOfAddress);
      return parseData;
    } else {
      return [];
    }
  } catch (ex) {
    print(ex.toString());
    return [];
  }
}

Future<bool> deleteUserAddress(String addressId) async {
  try {
    String url = APIRoute.getDeleteAddressURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("deleteUserAddress - addressId = $addressId");
    print("deleteUserAddress - user_id = ${loggedInUser.id.toString()}");
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "address_id": addressId,
        "user_id": loggedInUser.id.toString(),
      },
    );
    print("$url deleteUserAddress() " + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> listOfAddress = jsonDecode(response.body);
      var parseData = AddressApiModel.fromJsonList(listOfAddress);
      return true;
    } else {
      return false;
    }
  } catch (ex) {
    print(ex.toString());
    return false;
  }
}

/*Future<void> deleteUserAddress(String addressId) async {
  log("URL = ${APIRoute.getDeleteAddressURL()}");
  FormData formData = FormData.fromMap(
    {
      "address_id": addressId,
      "user_id": loggedInUser.id,
    },
  );
  log("Request = ${formData.fields}");
  try {
    Response response = await Dio(
      BaseOptions(
        headers: {
          "Authorization":
              "Bearer ${loggedInUser == null ? '' : loggedInUser.apiToken}"
        },
      ),
    ).post(APIRoute.getDeleteAddressURL(), data: formData);
    log("Response statusCode = ${response.statusCode}");
    if (response.statusCode == HttpStatus.ok) {
      if (response.data != null) {
        log("Response data = ${response.data}");
        return;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } on Exception catch (e) {
    log("Error deleteUserAddress = $e");
  }
  return null;
}*/
