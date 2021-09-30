class OrderStatusModel {
  int id;
  String name;

  OrderStatusModel({this.id, this.name});
  static fromJsonList(List<dynamic> input) {
    return input.map((job) => new OrderStatusModel.fromJson(job)).toList();
  }

  OrderStatusModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
