import '../../apiRoutes.dart';

class RestaurantModel {
  int id;
  String name;
  String description;
  String image;
  String rating;
  String avgRating;
  String deliveryTime;
  String priceRange;
  String slug;
  int isFeatured;
  int isActive;
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new RestaurantModel.fromJson(job)).toList();
  }

  RestaurantModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.rating,
      this.avgRating,
      this.deliveryTime,
      this.priceRange,
      this.slug,
      this.isFeatured,
      this.isActive});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = APIRoute.getBaseUrl() + json['image'];
    rating = json['rating'];
    avgRating = json['avgRating'];
    deliveryTime = json['delivery_time'];
    priceRange = json['price_range'];
    slug = json['slug'];
    isFeatured = json['is_featured'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['avgRating'] = this.avgRating;
    data['delivery_time'] = this.deliveryTime;
    data['price_range'] = this.priceRange;
    data['slug'] = this.slug;
    data['is_featured'] = this.isFeatured;
    data['is_active'] = this.isActive;
    return data;
  }
}
