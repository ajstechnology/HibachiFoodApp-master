import '../../apiRoutes.dart';

class ProductDetailsModel {
  int id;
  String restaurantId;
  String itemCategoryId;
  String netWeight;
  String grossWeight;
  String name;
  String price;
  String oldPrice;
  String image;
  int isRecommended;
  int isPopular;
  int isNew;
  String desc;
  String placeholderImage;
  int isActive;
  bool isVeg;
  String orderColumn;
  List<String> addonCategories;

  ProductDetailsModel(
      {this.id,
      this.restaurantId,
      this.itemCategoryId,
      this.netWeight,
      this.grossWeight,
      this.name,
      this.price,
      this.oldPrice,
      this.image,
      this.isRecommended,
      this.isPopular,
      this.isNew,
      this.desc,
      this.placeholderImage,
      this.isActive,
      this.isVeg,
      this.orderColumn,
      this.addonCategories});

  ProductDetailsModel.fromJson(Map<String, dynamic> json, isNeedToAddBase) {
    try {
      id = json['id'];
      restaurantId = json['restaurant_id'];
      itemCategoryId = json['item_category_id'];
      netWeight = json['net_weight'];
      grossWeight = json['gross_weight'];
      name = json['name'];
      price = json['price'];
      oldPrice = json['old_price'];
      image = json['image'] == null
          ? ""
          : isNeedToAddBase
              ? APIRoute.getBaseUrl() + json['image']
              : json['image'];
      isRecommended = json['is_recommended'];
      isPopular = json['is_popular'];
      isNew = json['is_new'];
      desc = json['desc'];
      placeholderImage = json['placeholder_image'];
      isActive = json['is_active'];
      isVeg = json['is_veg'];
      orderColumn = json['order_column'];
      if (json['addon_categories'] != null) {
        addonCategories = [];
        json['addon_categories'].forEach((v) {
          //addonCategories.add(new Null.fromJson(v));
        });
      }
    } catch (ex) {
      print("Exception while json" + ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['item_category_id'] = this.itemCategoryId;
    data['net_weight'] = this.netWeight;
    data['gross_weight'] = this.grossWeight;
    data['name'] = this.name;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['image'] = this.image;
    data['is_recommended'] = this.isRecommended;
    data['is_popular'] = this.isPopular;
    data['is_new'] = this.isNew;
    data['desc'] = this.desc;
    data['placeholder_image'] = this.placeholderImage;
    data['is_active'] = this.isActive;
    data['is_veg'] = this.isVeg;
    data['order_column'] = this.orderColumn;
    if (this.addonCategories != null) {
      data['addon_categories'] = [];
      //this.addonCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
