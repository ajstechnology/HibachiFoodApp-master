import 'dart:convert';
import 'dart:developer';
import '../database/sharedPreference.dart';
import 'Models/couponsModel.dart';
import 'apiRoutes.dart';
import 'package:http/http.dart' as http;

Future<List<CouponsModel>> getCoupnsListFromAPI() async {
  List<CouponsModel> couponsList = [];
  try {
    String url = APIRoute.getCouponsURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      List<dynamic> ouptut = jsonDecode(response.body);
      couponsList = CouponsModel.fromJsonList(ouptut);
    }
    log('getCoupnsListFromAPI called ' + response.body);
  } catch (ex) {
    log("getCoupnsListFromAPI" + ex.toString());
  }
  return couponsList;
}
