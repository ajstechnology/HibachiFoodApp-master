import '../apiRoutes.dart';

class BlogApiModel {
  bool status;
  List<BlogModel> blogList = [];

  BlogApiModel({this.status, this.blogList});

  BlogApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['blog_list'] != null) {
      blogList = [];
      json['blog_list'].forEach((v) {
        blogList.add(new BlogModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.blogList != null) {
      data['blog_list'] = this.blogList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BlogModel {
  String id = "";
  String title = "";
  String description = "";
  String image = "";
  String createdAt = "";

  BlogModel(this.id, this.title, this.description, this.image, this.createdAt);

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = APIRoute.getBaseUrl() + json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
