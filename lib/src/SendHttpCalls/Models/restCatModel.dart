class AllRestaurantCategoryModel {
  int id;
  String name;
  String isActive;
  String createdAt;
  String updatedAt;

  AllRestaurantCategoryModel(
      {this.id, this.name, this.isActive, this.createdAt, this.updatedAt});

  static fromJsonList(List<dynamic> input) {
    return input
        .map((job) => new AllRestaurantCategoryModel.fromJson(job))
        .toList();
  }

  factory AllRestaurantCategoryModel.fromJson(Map<String, dynamic> json) {
    return AllRestaurantCategoryModel(
      id: json["id"],
      name: json['name'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
