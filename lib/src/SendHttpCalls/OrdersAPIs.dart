import 'dart:convert';
import 'Models/couponOutputModel.dart';
import '../database/sharedPreference.dart';
import 'Models/Orders/placeOrderModel.dart';
import 'Models/Orders/applyCouponInputModel.dart';
import 'Models/Orders/chargesAndTaxModel.dart';
import 'Models/Orders/driverDetailsModel.dart';
import 'Models/Orders/placeOrderOutputModel.dart';
import 'Models/orderStatusModel.dart';
import 'apiRoutes.dart';

import 'Models/Orders/orderAPIModel.dart';
import 'package:http/http.dart' as http;

// get order status
Future<List<OrderStatusModel>> getOrderStatusFromAPI() async {
  List<OrderStatusModel> orderStatuses = [];
  try {
    String url = APIRoute.getOrderStatusURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print('getOrderStatusURL ${response.body}');
    if (response.statusCode == 200) {
      print("order status " + response.body);
      List<dynamic> ouptut = jsonDecode(response.body);
      orderStatuses = OrderStatusModel.fromJsonList(ouptut);
    }
  } catch (ex) {
    print("getOrderStatusFromAPI" + ex.toString());
  }
  return orderStatuses;
}

Future<List<OrdersAPIModel>> getUserOrdersFromAPI() async {
  List<OrdersAPIModel> orders = [];
  try {
    String url = APIRoute.getMyOrdersURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      var values = jsonDecode(response.body)['data'];
      orders = OrdersAPIModel.fromJsonList(values) as List<dynamic>;
      print('all done $orders');

      print("response body my orders  " + response.body);
      Map<String, dynamic> ouptut = jsonDecode(response.body);
      orders = OrdersAPIModel.fromJsonList(ouptut['data']);
    }
  } catch (ex) {
    print("getMyOrders() " + ex.toString());
  }
  return orders;
}

//git reset --soft d2566bd75c8b2d9881752ed07e61c7a09c5f4463

Future<CouponOutputModel> applyCouponAPI(
    int restaurantId, String couponCode, int subtotal) async {
  CouponOutputModel couponOutputModel;
  try {
    String url = APIRoute.getApplyCouponURL();

    ApplyCouponInputModel inputModel = new ApplyCouponInputModel(
        restaurantId.toString(), couponCode, subtotal.toString());

    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var jsonBody = jsonEncode(inputModel);
    print("applyCouponAPI()" + jsonBody);
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonBody);
    print("getApplyCouponURL" + response.body.toString());
    print(url);
    if (response.statusCode == 200) {
      couponOutputModel = CouponOutputModel.fromJson(jsonDecode(response.body));
      print('Success of applyCouponAPI()' + response.body.toString());
    } else {
      print('Failed applyCouponAPI() status Code' +
          response.statusCode.toString());
    }
  } catch (ex) {
    print("applyCouponAPI" + ex.toString());
  }
  return couponOutputModel;
}

Future<PlaceOrderOutputModel> placeOrders(
    PlaceOrderModel orderInputModel) async {
  try {
    String url = APIRoute.getPlaceOrderURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var jsonBody = jsonEncode(orderInputModel);
    print("Place order API " + jsonBody.toString());
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonBody);
    print("getPlaceOrderURL" + response.body.toString());
    if (response.statusCode == 200) {
      print('placeOrders() 200');
      return PlaceOrderOutputModel.fromJson(jsonDecode(response.body));
    }
  } catch (ex) {
    print("placeOrders()" + ex.toString());
  }
  return null;
}

/*Future<DriverDetailsModel> getDriverLocationFromAPI(String driverId, String orderId) async {
  try {
    String url = APIRoute.getDriverDetailsURL() + "/$driverId" + "/$orderId";
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("getDriverLocationFromAPI() token $token URL $url");
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("getDriverLocation() " + response.body);
    if (response.statusCode == 200) {
      return DriverDetailsModel.fromJson(jsonDecode(response.body));
    }
  } catch (ex) {
    print("getDriverLocation " + ex.toString());
  }
  return null;
}*/

Future<DriverDetailsModel> getDriverLocationFromAPI(String driverId, String orderId) async {
  try {
    String url = APIRoute.getDriverDetailsURL() + "/$driverId/$orderId";
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("getDriverLocationFromAPI() token $token URL $url");
    var response = await http.post(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("getDriverLocation() " + response.body);
    if (response.statusCode == 200) {
      return DriverDetailsModel.fromJson(jsonDecode(response.body));
    }
  } catch (ex) {
    print("getDriverLocation " + ex.toString());
  }
  return null;
}

Future<ChargesAndTaxModel> getChargesAndGstFromServer(int _resturantId) async {
  try {
    String url = APIRoute.getResturantChargesURL();
    var jsonBody = jsonEncode({"restaurant_id": _resturantId});

    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    print("getChargesAndGstFromServer() " + url);
    var response = await http.post(
      Uri.parse(url),
      body: jsonBody,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print("getChargesAndGstFromServer() " + response.body.toString());

    if (response.statusCode == 200) {
      return ChargesAndTaxModel.fromJson(jsonDecode(response.body.toString()));
    } else {
      return null;
    }
  } catch (ex) {
    print("getChargesAndGstFromServer()" + ex.toString());
  }
  return null;
}
