import 'dart:convert';

class CartModel {
  int id;
  int quantity;
  double price;
  String name;
  int resturantId;
  int userId;
  double lat;
  double long;

  CartModel(this.userId, this.id, this.quantity, this.price, this.name,
      this.resturantId, this.lat, this.long);
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new CartModel.fromJson(job)).toList();
  }

  static List<CartModel> decode(String cartModel) =>
      (json.decode(cartModel) as List<dynamic>)
          .map<CartModel>((item) => CartModel.fromJson(item))
          .toList();
  static String encode(List<CartModel> cartModel) => json.encode(
        cartModel
            .map<Map<String, dynamic>>(
                (cartModel) => CartModel.toMap(cartModel))
            .toList(),
      );
  static Map<String, dynamic> toMap(CartModel cartModel) => {
        'id': cartModel.id,
        'quantity': cartModel.quantity,
        'price': cartModel.price,
        'name': cartModel.name,
        'resturantId': cartModel.resturantId,
        'userId': cartModel.userId,
        'lat': cartModel.lat,
        'long': cartModel.long,
      };

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    name = json['name'];
    resturantId = json['resturantId'];
    userId = json['userId'];
    lat = json['lat'];
    long = json['long'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['name'] = name;
    data['resturantId'] = resturantId;
    data['userId'] = userId;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
