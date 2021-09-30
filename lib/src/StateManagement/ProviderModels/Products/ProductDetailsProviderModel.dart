import 'package:flutter/material.dart';
import '../../../SendHttpCalls/productAPI.dart';
import '../../../SendHttpCalls/Models/Product/productDetailsModel.dart';

class ProductDetailsProviderModel extends ChangeNotifier {
  int _productId;

  ProductDetailsModel _productDetailsModel;

  ProductDetailsModel getProductDetailsModel() => _productDetailsModel;

  ProductDetailsProviderModel(int id) {
    this._productId = id;
  }

  Future<ProductDetailsModel> getProductDetails() async {
    _productDetailsModel = await getProductDetailsFromServer(this._productId);
    return _productDetailsModel;
  }
}
