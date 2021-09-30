import 'dart:convert';
import 'package:http/http.dart' as http;
import '../database/sharedPreference.dart';
import 'Models/Orders/restaurantTimeSlotApiModel.dart';
import 'apiRoutes.dart';

Future<List<TimeSlotsModel>> getResturantTimeSlotFromServer(
    String resturantId) async {
  try {
    String url = APIRoute.getRestaurantInfoByIdURL() + resturantId;
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("getResturantTimeSlotFromServer()" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var parseData =
          RestaurantTimeSlotApiModel.fromJson(jsonDecode(response.body));
      return parseData.timeslotes;
    } else {
      return [];
    }
  } catch (ex) {
    print("getResturantTimeSlotFromServer() " + ex.toString());
    return [];
  }
}
