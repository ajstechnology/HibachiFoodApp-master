import '../apiRoutes.dart';

class PromoSliderModel {
  List<MainSlides> mainSlides;
  Object otherSlides;
  PromoSliderModel({this.mainSlides, this.otherSlides});

  PromoSliderModel.fromJson(Map<String, dynamic> json) {
    if (json['mainSlides'] != null) {
      mainSlides = [];
      json['mainSlides'].forEach((v) {
        mainSlides.add(new MainSlides.fromJson(v));
      });
    }
    otherSlides = json['otherSlides'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mainSlides != null) {
      data['mainSlides'] = this.mainSlides.map((v) => v.toJson()).toList();
    }
    data['otherSlides'] = this.otherSlides;
    return data;
  }
}

class MainSlides {
  Data data;
  String url;
  PromoSlider promoSlider;

  MainSlides({this.data, this.url, this.promoSlider});

  MainSlides.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    url = APIRoute.getBaseUrl() + json['url'];
    promoSlider = json['promo_slider'] != null
        ? new PromoSlider.fromJson(json['promo_slider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['url'] = APIRoute.getBaseUrl() + this.url;
    if (this.promoSlider != null) {
      data['promo_slider'] = this.promoSlider.toJson();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String image;
  String model;

  Data({this.id, this.name, this.image, this.model});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = APIRoute.getBaseUrl() + json['image'];
    model = json['model'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = APIRoute.getBaseUrl() + this.image;
    data['model'] = this.model;
    return data;
  }
}

class PromoSlider {
  String size;

  PromoSlider({this.size});

  PromoSlider.fromJson(Map<String, dynamic> json) {
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    return data;
  }
}
