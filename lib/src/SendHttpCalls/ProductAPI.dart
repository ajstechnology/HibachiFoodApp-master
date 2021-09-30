import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'package:provider/provider.dart';

import '../database/sharedPreference.dart';
import 'Models/HomePage/resturantSliderModel.dart';
import 'Models/Product/productDetailsModel.dart';
import 'Models/Product/restaurantItemsModel.dart';
import 'Models/Product/restaurantModel.dart';
import 'Models/SearchProductModel.dart';
import 'apiRoutes.dart';

Future<ProductDetailsModel> getProductDetailsFromServer(int id) async {
  try {
    String url = APIRoute.getProductDetailsURL() + "id=" + id.toString();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('getProductDetailsURL ${response.body}');
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      return ProductDetailsModel.fromJson(jsonBody, true);
    }
  } catch (ex) {
    print("Error getProductDetails()" + ex.toString());
  }
  return null;
}

Future<List<RestaurantModel>> getDeliveryRestaurants(
    {String lat = null, String long = null}) async {
  List<RestaurantModel> list = [];
  lat == "null" ? lat = null : "";
  long == "null" ? long = null : "";
  try {
    //TODO: need to enable this
    if (lat == null) {
      lat = "17.4930461";
    }
    if (long == null) {
      long = "78.3963763";
    }

    String url = APIRoute.getDeliveryResturantDetailsURL() +
        "latitude=" +
        lat +
        "&longitude=" +
        long;
    print("getDeliveryRestaurants() URL => " + url);
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("Token " + token);
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      List<dynamic> ouptut = jsonDecode(response.body);
      list = RestaurantModel.fromJsonList(ouptut);
    }
  } catch (ex) {
    print("Error getDeliveryRestaurants()" + ex.toString());
  }
  return list;
}

Future<RestaurantItemsModel> getRestaurantsProducts(String slug) async {
  RestaurantItemsModel list;
  try {
    String url = APIRoute.getResturantItemsURL() + "/" + slug;
    print("getRestaurantsProducts() URL => " + url);
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('getResturantItemsURL ${response.body}');
    if (response.statusCode == 200) {
      var ouptut = jsonDecode(response.body);
      list = RestaurantItemsModel.fromJson(ouptut);
    }
  } catch (ex) {
    print("Error getRestaurantsProducts()" + ex.toString());
  }
  return list;
}

Future<SearchProductModel> getProductsFromServerApi(String searchText, String lat, String long) async {
  try {
    String url;
    log("getProductsFromServerApi - searchText = $searchText");
    searchText == null
        ? url = APIRoute.searchProductsURL()
        : url = APIRoute.searchProductsURL() + "q=" + searchText;
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("getProductsFromServerApi() $url\nToken $token");
    // Get.dialog(Center(child: CircularProgressIndicator(),), barrierDismissible: true);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        // 'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        "latitude": lat,
        "longitude": long,
      }
    );
    print('searchProductsURL ${response.body}');
    if (response.statusCode == 200) {
      print("search product " + response.body);
      var jsonBody = jsonDecode(response.body);
      return SearchProductModel.fromJson(jsonBody);
    }
  } catch (ex) {
    print("Error getProductsFromServerApi() - " + ex.toString());
  } finally{
    // Get.back(canPop: false);
  }
  return null;
}

Future<List<ResturantSliderModel>> getResturantSliderFromServerApi(
    String resturantId,
    {String type = ""}) async {
  try {
    String url = APIRoute.getResturantSliderURL() +
        "restaurant_id=$resturantId&type=$type";
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('getResturantSliderFromServerApi $url body=> ${response.body}');
    if (response.statusCode == 200) {
      print("getResturantSliderFromServerApi " + response.body);
      var jsonBody = jsonDecode(response.body);
      return ResturantSliderModel.fromJsonList(jsonBody);
    }
  } catch (ex) {
    print("Error getResturantSliderFromServerApi()" + ex.toString());
  }
  return [];
}
