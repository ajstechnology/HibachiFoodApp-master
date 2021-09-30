import '../../apiRoutes.dart';

class ResturantSliderModel {
  int id;
  String name;
  String image;
  String imagePlaceholder;
  String restaurantIds;

  ResturantSliderModel(
      {this.id,
      this.name,
      this.image,
      this.imagePlaceholder,
      this.restaurantIds});
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new ResturantSliderModel.fromJson(job)).toList();
  }

  ResturantSliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = APIRoute.getBaseUrl() + json['image'];
    imagePlaceholder = json['image_placeholder'];
    restaurantIds = json['restaurant_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['image_placeholder'] = this.imagePlaceholder;
    data['restaurant_ids'] = this.restaurantIds;
    return data;
  }
}
