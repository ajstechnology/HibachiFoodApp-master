import 'dart:developer';

import 'package:flutter/material.dart';
import '../../SendHttpCalls/couponsAPI.dart';
import '../../SendHttpCalls/Models/couponsModel.dart';

class CouponsProviderModel extends ChangeNotifier {
  List<CouponsModel> _couponsList = [];
  bool _isLoading = true;

  bool getIsLoading() => _isLoading;
  List<CouponsModel> getCouponsList() => _couponsList;

  Future<List<CouponsModel>> getCoupons(String resturantId) async {
    log("getCoupons - resturantId = ${resturantId}");
    _couponsList = await getCoupnsListFromAPI();
    List<CouponsModel> returnList = [];
    log("getCoupons - _couponsList = ${_couponsList.length}");
    if (_couponsList.length > 0) {
      for (var i = 0; i < _couponsList.length; i++) {
        if (_couponsList[i]
            .restaurants
            .any((element) => element.id == int.parse(resturantId))) {
          returnList.add(_couponsList[i]);
        }
      }
    }
    _isLoading = false;
    return returnList;
  }
}
