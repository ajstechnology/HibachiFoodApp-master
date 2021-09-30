import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../SendHttpCalls/Models/SearchProductModel.dart';
import '../../../SendHttpCalls/productAPI.dart';

class SearchProductProviderModel extends ChangeNotifier {
  String _searchKeyWord;
  SearchProductModel _searchProductModel;
  StreamController<List<SearchItems>> streamController;

  final _searchKeyController = TextEditingController();

  TextEditingController getSearchKeyController() => _searchKeyController;
  SearchProductProviderModel(String lat, String long) {
    streamController = BehaviorSubject();
    getSearchProducts(lat, long);
  }
  setSearchKeyWord(String lat, String long) async {
    this._searchKeyWord = _searchKeyController.text.trim();
    return await getSearchProducts(lat, long);
  }

  void getSearchProducts(String lat, String long) async {
    List<SearchItems> list = [];
    if (_searchProductModel == null) {
      _searchProductModel = await getProductsFromServerApi(this._searchKeyWord, lat, long);
      if (_searchProductModel != null) {
        list = _searchProductModel.items;
      }
      return streamController.add(list);
    } else {
      _searchProductModel = await getProductsFromServerApi(this._searchKeyWord, lat, long);
      list = _searchProductModel.items
          .where((element) => element.name
              .toLowerCase()
              .contains(this._searchKeyWord.toLowerCase()))
          .toList();
      return streamController.add(list);
    }
  }
}
