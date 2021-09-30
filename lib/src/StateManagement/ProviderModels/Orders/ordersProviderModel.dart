import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../SendHttpCalls/Models/orderStatusModel.dart';
import '../../../SendHttpCalls/Models/Orders/orderAPIModel.dart';
import '../../../SendHttpCalls/ordersAPIs.dart';

class OrderProviderModel extends ChangeNotifier {
  List<OrdersAPIModel> _orders = [];
  List<OrdersAPIModel> getOrders() => _orders;
  List<OrderStatusModel> _orderStatus = [];

  String getNameStatusName(int id) {
    var status = _orderStatus.firstWhere((element) => element.id == id,
        orElse: () => null);
    if (status == null) {
      return "No found";
    } else {
      return status.name;
    }
  }

  Future<List<OrdersAPIModel>> getMyOrders() async {
    _orderStatus = await getOrderStatusFromAPI();
    _orders = await getUserOrdersFromAPI();
    _orders.sort((a, b) {
      return b.id.compareTo(a.id);
    });

    return _orders;
  }
}
