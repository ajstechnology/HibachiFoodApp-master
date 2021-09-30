import '../../apiRoutes.dart';

class CategoryModel {
  int id;
  String name;
  String image;
  String imagePlaceholder;
  List<CategoriesIds> categoriesIds;

  CategoryModel(
      {this.id,
      this.name,
      this.image,
      this.imagePlaceholder,
      this.categoriesIds});

  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new CategoryModel.fromJson(job)).toList();
  }

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = APIRoute.getBaseUrl() + json['image'];
    imagePlaceholder = json['image_placeholder'];
    if (json['categories_ids'] != null) {
      categoriesIds = [];
      json['categories_ids'].forEach((v) {
        categoriesIds.add(new CategoriesIds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['image_placeholder'] = this.imagePlaceholder;
    if (this.categoriesIds != null) {
      data['categories_ids'] =
          this.categoriesIds.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoriesIds {
  int value;
  String label;

  CategoriesIds({this.value, this.label});

  CategoriesIds.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}
