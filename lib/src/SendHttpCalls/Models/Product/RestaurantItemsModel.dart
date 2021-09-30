import 'productDetailsModel.dart';

class RestaurantItemsModel {
  List<ProductDetailsModel> recommended = [];
  List<ProductDetailsModel> itemList = [];

  RestaurantItemsModel({this.recommended, this.itemList});

  RestaurantItemsModel.fromJson(Map<String, dynamic> json) {
    if (json['recommended'] != null) {
      recommended = [];
      json['recommended'].forEach((v) {
        recommended.add(new ProductDetailsModel.fromJson(v, true));
      });
    }
    if (json['restaurant_items'] != null) {
      itemList = [];
      json['restaurant_items'].forEach((v) {
        itemList.add(new ProductDetailsModel.fromJson(v, true));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recommended != null) {
      data['recommended'] = this.recommended.map((v) => v.toJson()).toList();
    }
    if (this.itemList != null) {
      data['restaurant_items'] = this.itemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
