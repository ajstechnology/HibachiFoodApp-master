import 'dart:developer';

import 'package:flutter/material.dart';
import '../../SendHttpCalls/blogAPIs.dart';
import '../../SendHttpCalls/Models/blogApiModel.dart';
import '../../SendHttpCalls/Models/HomePage/resturantSliderModel.dart';
import '../../SendHttpCalls/Models/HomePage/categoryModel.dart';
import '../../SendHttpCalls/Models/promoSliderModel.dart';
import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../../SendHttpCalls/Models/Product/restaurantItemsModel.dart';
import '../../SendHttpCalls/Models/Product/restaurantModel.dart';
import '../../SendHttpCalls/productAPI.dart';
import '../../SendHttpCalls/homePageAPI.dart';

class HomePageProviderModel extends ChangeNotifier {
  PromoSliderModel _sliderModel;
  List<CategoryModel> _categoryList = [];
  List<RestaurantModel> _restaurantList = [];
  RestaurantItemsModel _restaurantItemsModel;
  List<ProductDetailsModel> _spotlight = [];
  List<ProductDetailsModel> _allItems = [];
  List<ResturantSliderModel> _resturantSliderList = [];
  List<ResturantSliderModel> _resturantDiscountSliderList = [];
  List<BlogModel> _blogsList = [];
  bool _isLoadingProducts = true;

  PromoSliderModel getSliderModels() => _sliderModel;
  List<CategoryModel> getCategoryList() => _categoryList;

  bool getLoadingProducts() => _isLoadingProducts;

  RestaurantItemsModel getRestaurantItemsModel() => _restaurantItemsModel;
  List<ResturantSliderModel> getRestaurantSlider() => _resturantSliderList;
  List<ResturantSliderModel> getRestaurantDiscountSlider() =>
      _resturantDiscountSliderList;
  List<BlogModel> getBlogsList() => _blogsList;

  List<ProductDetailsModel> getSpotlightModel() {
    _spotlight = [];
    if (_restaurantItemsModel != null) {
      _spotlight.addAll(_restaurantItemsModel.itemList);
    }
    return _spotlight;
  }

  List<ProductDetailsModel> getAllProducts() {
    _allItems = [];
    if (_restaurantItemsModel != null) {
      _allItems.addAll(_restaurantItemsModel.recommended);
      _allItems.addAll(_restaurantItemsModel.itemList);
    }
    return _allItems;
  }

  List<ProductDetailsModel> getItemsByCategoryId(int categoryId) {
    List<ProductDetailsModel> list = [];

    for (var i = 0; i < _allItems.length; i++) {
      var item = list.firstWhere((element) => element.id == _allItems[i].id,
          orElse: () => null);

      if (item == null &&
          int.parse(_allItems[i].itemCategoryId) == categoryId) {
        list.add(_allItems[i]);
      }
    }
    return list;
  }

  _getSliderData() async {
    _sliderModel = await getSliderDataForHome();
    _categoryList = await getCategoryDataForHome();
  }

  Future<void> getResturantProducts(isRefresh, bool isNotify, String ulat, String ulong) async {
    log("getResturantProducts - ulat = $ulat | ulong = $ulong");
    try {
      // need to fix this once API ready
      _getBlogsFromServer();
      _restaurantItemsModel =
          new RestaurantItemsModel(itemList: [], recommended: []);
      this._getSliderData();

      if (isRefresh ||
          _restaurantList.length == 0 ||
          _restaurantItemsModel.recommended.length == 0) {
        _isLoadingProducts = true;
        if (isNotify) {
          notifyListeners();
        }

        _restaurantList = await getDeliveryRestaurants(lat: ulat, long: ulong);
        print("Resturant List " + _restaurantList.length.toString());
        if (_restaurantList.length > 0) {
          for (int i = 0; i < _restaurantList.length; i++) {
            // to download the Resturant Slider
            this.getResturantSlider(_restaurantList[i].id.toString(),
                type: "store-slider");
            //coupon-slider
            this.getResturantDiscountSlider(_restaurantList[i].id.toString(),
                type: "coupon-slider");
            var resturant =
                await getRestaurantsProducts(_restaurantList[i].slug);
            if (resturant != null) {
              _restaurantItemsModel = resturant;
            }
          }
          if (_restaurantItemsModel != null) {
            print("_restaurantItemsModel.recommended count" +
                _restaurantItemsModel.recommended.length.toString());
            print("_restaurantItemsModel.items count" +
                _restaurantItemsModel.itemList.length.toString());
          }
        }
        _isLoadingProducts = false;
        notifyListeners();
      }
    } catch (ex) {
      print("getProducts() error" + ex.toString());
      _isLoadingProducts = false;
      notifyListeners();
    }
    return;
  }

  getResturantSlider(String resturantId, {String type = ""}) async {
    _resturantSliderList =
        await getResturantSliderFromServerApi(resturantId, type: type);
  }

  getResturantDiscountSlider(String resturantId, {String type}) async {
    _resturantDiscountSliderList =
        await getResturantSliderFromServerApi(resturantId, type: type);
  }

  _getBlogsFromServer() async {
    _blogsList = await getBlogsListFromServer();
  }
}
