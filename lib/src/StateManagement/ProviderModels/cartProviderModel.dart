import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'package:provider/provider.dart';
import '../../SendHttpCalls/Models/Orders/chargesAndTaxModel.dart';
import '../../SendHttpCalls/Models/Orders/placeOrderOutputModel.dart';
import '../../SendHttpCalls/ordersAPIs.dart';
import '../../SendHttpCalls/Models/Orders/placeOrderModel.dart';
import '../../database/sharedPreference.dart';
import '../../SendHttpCalls/Models/cartModel.dart';
import '../../SendHttpCalls/Models/couponOutputModel.dart';

class CartProviderModel extends ChangeNotifier {
  String cartKey = "MyCart";
  PlaceOrderModel orderInputModel;
  List<CartModel> mycart = [];
  double totalItemAmount = 0.0;
  double totalBillAmount = 0.0;
  double deliveryFee = 0;
  double gstFee = 0;
  double _discount = 0.0;
  double appliedCouponAmount = 0.0;
  CouponOutputModel couponOutputModel;
  PlaceOrderOutputModel placeOrderOutputModel;
  bool _isApplyCoupon = false;
  bool _isPlacingOrder = false;
  TextEditingController _commentController;
  String _deliveryDate = "";
  String _timeslotes = "";

  CartProviderModel() {
    _commentController = new TextEditingController();
    // this.fetchFromStorage(context);
  }
  setDeliveryDateTime(String deliveryDate, String timeslotes) {
    _deliveryDate = deliveryDate;
    _timeslotes = timeslotes;
    print('Delivery Date has been set ' + _deliveryDate);
    print('Delivery Time has been set ' + _timeslotes);
  }

  bool isApplyCoupon() => _isApplyCoupon;
  bool isPlacingOrder() => _isPlacingOrder;
  TextEditingController getCommetController() => _commentController;

  clearCart() {
    _isApplyCoupon = false;
    _discount = 0;
    appliedCouponAmount = 0;
    _calculateTotal();
    _commentController.text = "";
    _deliveryDate = "";
    _timeslotes = "";

    mycart.clear();
    _saveInStorage();
    _calculateTotal();
  }

  void fetchFromStorage(BuildContext context) async {
    mycart.clear();
    var cartInDB = await getListFromSharePrefernece(cartKey);
    if (cartInDB != null) {
      for (var i = 0; i < cartInDB.length; i++) {
        var item = CartModel.fromJson(json.decode(cartInDB[i]));
        if (item.userId == loggedInUser.id && item.lat == Provider.of<AddAddressProviderModel>(context, listen: false).addressForOrder.latitude && item.long == Provider.of<AddAddressProviderModel>(context, listen: false).addressForOrder.latitude) {
          log("fetchFromStorage - item = ${item.toJson()}");
          mycart.add(item);
        }
      }
    }
    _calculateTotal();
    notifyListeners();
  }

  void changeCartItemForDifferentAddress(String lat, String long) async {
    mycart.clear();
    var cartInDB = await getListFromSharePrefernece(cartKey);
    log("changeCartItemForDifferentAddress - lat - $lat");
    log("changeCartItemForDifferentAddress - long - $long");
    log("changeCartItemForDifferentAddress - cartInDB - $cartInDB");
    if (cartInDB != null) {
      for (var i = 0; i < cartInDB.length; i++) {
        var item = CartModel.fromJson(json.decode(cartInDB[i]));
        if (item.userId == loggedInUser.id && item.lat.toString() == lat && item.long.toString() == long) {
          mycart.add(item);
        }
      }
    }
    _calculateTotal();
    notifyListeners();
  }

  void _saveInStorage() async {
    List<String> _list = [];
    for (var i = 0; i < mycart.length; i++) {
      _list.add(json.encode(mycart[i].toJson()));
    }
    await saveListInSharePrefernece(cartKey, _list);
  }

  addToCart(int id, String price, String name, int resturantId, double latitude, double longitude) async {
    CartModel itemInCart =
        mycart.firstWhere((element) => element.id == id, orElse: () => null);

    var _resutrant = mycart.firstWhere(
        (element) => element.resturantId == resturantId,
        orElse: () => null);
    // if any item already added from another resturant then clear it.
    if (mycart.length > 0) {
      if (_resutrant.resturantId != resturantId) {
        return mycart.clear();
      }
    }

    if (itemInCart == null) {
      itemInCart = new CartModel(
          loggedInUser.id, id, 1, double.parse(price), name, resturantId, latitude, longitude);
      log("addToCart - item to add in cart - ${itemInCart.toJson()}");
      mycart.add(itemInCart);
    } else {
      itemInCart.quantity += 1;
    }

    await _saveInStorage();
    _calculateTotal();
    notifyListeners();
  }

  removeFromCart(BuildContext context, int id) async {
    CartModel itemInCart =
        mycart.firstWhere((element) => element.id == id, orElse: () => null);
    if (itemInCart != null) {
      itemInCart.quantity -= 1;
      if (itemInCart.quantity == 0) {
        mycart.remove(itemInCart);
      }
      await _saveInStorage();
      _calculateTotal();
      notifyListeners();
    }
    if (mycart.length == 0) {
      clearCart();
    }
  }

  int checkAndGetQuantity(int id) {
    CartModel itemInCart =
        mycart.firstWhere((element) => element.id == id, orElse: () => null);
    if (itemInCart != null) {
      return itemInCart.quantity;
    } else {
      return 0;
    }
  }

  _calculateTotal() async {
    await getDeliveryFeeAndCharges();
    if (mycart.length == 0) {
      totalItemAmount = 0;
      totalBillAmount = 0;
    } else {
      totalItemAmount = 0;
      for (var i = 0; i < mycart.length; i++) {
        totalItemAmount += mycart[i].price * mycart[i].quantity;
      }
      totalBillAmount = totalItemAmount + deliveryFee + gstFee;
      double afterDiscount = 0;
      if (_discount > 0.0) {
        if (couponOutputModel.discountType == "AMOUNT") {
          appliedCouponAmount = _discount;
          afterDiscount = totalBillAmount - appliedCouponAmount;
        } else {
          appliedCouponAmount = (_discount / 100) * totalItemAmount;
          afterDiscount = appliedCouponAmount;
        }
      } else {
        afterDiscount = totalBillAmount;
      }
      totalBillAmount = afterDiscount;
    }
  }

  Future<PlaceOrderOutputModel> placeOrderToApi(BuildContext context,
      int addressId, String address, String house, paymentMethod) async {
    _isPlacingOrder = true;
    notifyListeners();
    orderInputModel = new PlaceOrderModel();
    orderInputModel.addressId = addressId.toString();
    orderInputModel.token = "";
    orderInputModel.pendingPayment =
        double.parse(totalBillAmount.toStringAsFixed(2));
    orderInputModel.method = paymentMethod;
    orderInputModel.location = address;
    orderInputModel.paymentToken = "";
    orderInputModel.deliveryType = 1;
    orderInputModel.dis = _discount.toInt();
    orderInputModel.tipAmount = 0;
    orderInputModel.orderComment = _commentController.text;
    orderInputModel.partialWallet = false;
    orderInputModel.scheduleDelivery = _deliveryDate;
    orderInputModel.timeslotes = _timeslotes;
    if (couponOutputModel != null) {
      orderInputModel.coupon = new OrderCoupon(code: couponOutputModel.code);
    }
    List<OrderItems> orderItems = [];
    mycart.forEach((val) {
      //creating new ItemsModel objects and adding to the updatedList
      orderItems.add(OrderItems(
          restaurantId: val.resturantId,
          id: val.id,
          quantity: val.quantity,
          name: val.name,
          price: val.price.toString()));
    });
    orderInputModel.orderItems = orderItems;
    orderInputModel.orderUser = new OrderUser(
      data: new UserData(
        defaultAddress: DefaultAddress(address: address, house: house),
      ),
    );
    placeOrderOutputModel = await placeOrders(orderInputModel);
    _isPlacingOrder = false;
    notifyListeners();
    if (placeOrderOutputModel == null) {
      return null;
    } else if (placeOrderOutputModel.success == false) {
      return null;
    } else if (placeOrderOutputModel.success) {
      clearCart();
      return placeOrderOutputModel;
    } else {
      return null;
    }
  }

  Future<bool> applyCoupon(String couponCode) async {
    if (mycart.length == 0) {
      return false;
    }
    _isApplyCoupon = true;
    notifyListeners();
    couponOutputModel = await applyCouponAPI(
        mycart.first.resturantId, couponCode, totalBillAmount.toInt());

    _isApplyCoupon = false;
    if (couponOutputModel.code == null) {
      print('couponOutputModel.code == null');
      notifyListeners();
      return false;
    } else {
      _discount = double.parse(couponOutputModel.discount);
      print('Discount amount' + _discount.toString());
      _calculateTotal();
      notifyListeners();
      return true;
    }
  }

  getDeliveryFeeAndCharges() async {
    if (mycart.length > 0) {
      ChargesAndTaxModel chargesAndTaxModel =
          await getChargesAndGstFromServer(mycart.first.resturantId);
      if (chargesAndTaxModel.success) {
        if (chargesAndTaxModel.data != null) {
          deliveryFee = double.parse(chargesAndTaxModel.data.deliveryCharges);
          gstFee = double.parse(chargesAndTaxModel.data.taxPercentage);
          print("getDeliveryFeeAndCharges success");
          notifyListeners();
        } else {
          print("Delivery charges  is null");
        }
      } else {
        print("Delivery charges status is not true");
      }
    } else {
      deliveryFee = 0.0;
      gstFee = 0.0;
      print("getDeliveryFeeAndCharges cart is empty");
      notifyListeners();
    }
  }
}
