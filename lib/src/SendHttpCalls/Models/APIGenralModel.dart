class APIGeneraicModel {
  bool success;
  Object data;
  Object runningOrder;

  APIGeneraicModel({this.success, this.data, this.runningOrder});

  APIGeneraicModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'];
    runningOrder = json['running_order'];
  }
}
