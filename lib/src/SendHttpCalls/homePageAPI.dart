import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Models/promoSliderModel.dart';
import '../database/sharedPreference.dart';
import 'apiRoutes.dart';
import 'Models/HomePage/categoryModel.dart';

Future<PromoSliderModel> getSliderDataForHome() async {
  PromoSliderModel sliders;
  try {
    String url = APIRoute.getPromoSliderURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("getSliderDataForHome() => " + url);
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('getPromoSliderURL ${response.body}');
    if (response.statusCode == 200) {
      print("Promo slider " + response.body);
      sliders = PromoSliderModel.fromJson(jsonDecode(response.body));
    }
  } catch (ex) {
    print("Error in getSliderDataForHome()" + ex.toString());
  }
  return sliders;
}

Future<List<CategoryModel>> getCategoryDataForHome() async {
  List<CategoryModel> categoryList = [];
  try {
    String url = APIRoute.getSliderURLForHomeURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("getSliderURLForHomeURL" + response.body.toString());
    if (response.statusCode == 200) {
      List<dynamic> output = jsonDecode(response.body);
      categoryList = CategoryModel.fromJsonList(output);
    }
  } catch (ex) {
    print("Error in getCategoryDataForHome()" + ex.toString());
  }
  return categoryList;
}
