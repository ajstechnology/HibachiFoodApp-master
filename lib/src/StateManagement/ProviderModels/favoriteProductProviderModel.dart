import 'dart:convert';

import 'package:flutter/material.dart';
import '../../database/sharedPreference.dart';
import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';

class FavoriteProductProviderModel extends ChangeNotifier {
  String favoriteKey = "MyFavorite";

  List<ProductDetailsModel> myFavorite = [];

  FavoriteProductProviderModel() {
    this.fetchFavoriteFromStorage();
  }

  void fetchFavoriteFromStorage() async {
    var favoriteInDB = await getListFromSharePrefernece(favoriteKey);
    if (favoriteInDB != null) {
      for (var i = 0; i < favoriteInDB.length; i++) {
        myFavorite.add(
            ProductDetailsModel.fromJson(json.decode(favoriteInDB[i]), false));
      }
    }
    notifyListeners();
  }

  void _saveFavoriteInStorage() async {
    List<String> _list = [];
    for (var i = 0; i < myFavorite.length; i++) {
      _list.add(json.encode(myFavorite[i].toJson()));
    }
    await saveListInSharePrefernece(favoriteKey, _list);
  }

  saveUnsaveFavorite(ProductDetailsModel item) async {
    ProductDetailsModel itemInCart = myFavorite
        .firstWhere((element) => element.id == item.id, orElse: () => null);
    if (itemInCart == null) {
      myFavorite.add(item);
    } else {
      myFavorite.remove(itemInCart);
    }
    await _saveFavoriteInStorage();
    notifyListeners();
  }

  bool checkFavoriteAndGetQuantity(int id) {
    ProductDetailsModel itemInCart = myFavorite
        .firstWhere((element) => element.id == id, orElse: () => null);
    if (itemInCart != null) {
      return true;
    } else {
      return false;
    }
  }
}
