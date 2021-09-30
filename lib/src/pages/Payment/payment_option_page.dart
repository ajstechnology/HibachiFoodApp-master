import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getwidget/getwidget.dart';
import '../../StateManagement/ProviderModels/Addresses/addressApiModel.dart';
import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../widgets/loader.dart';
import '../../SendHttpCalls/Models/Orders/placeOrderOutputModel.dart';
import '../../StateManagement/ProviderModels/cartProviderModel.dart';
import '../Orders/thankyou.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../widgets/custom_divider_view.dart';

class PaymentOptionPage extends StatefulWidget {
  const PaymentOptionPage({Key key}) : super(key: key);

  @override
  _PaymentOptionPageState createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  Razorpay razorpay;

  // String uniqueOrderId;
  bool paymentComplete = false;
  PlaceOrderOutputModel placeOrderOutputModel;

  @override
  void initState() {
    razorpay = null;
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  CartProviderModel cart;
  AddAddressProviderModel addressModel;

  succseusFxn(AddressApiModel addressModel) async {
    placeOrderOutputModel = await cart.placeOrderToApi(
      context,
      addressModel.id,
      addressModel.address,
      addressModel.house,
      'Razorpay',
    );
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    succseusFxn(addressModel.addressForOrder);
    if (placeOrderOutputModel != null) {
      // Need to show Toast
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              Thankyou(placeOrderOutputModel.data.uniqueOrderId),
        ),
      );
    }

    print("Pament success ${paymentComplete}");

    Fluttertoast.showToast(msg: "Pament success ${paymentComplete}");
  }

  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Pament error" + "${response}");
    Fluttertoast.showToast(msg: "Pament error");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External Wallet");
  }

  void openCheckout(double totalBillAmount) {
    var options = {
      "key": "rzp_live_3TtsgEgdzjULoJ",
      "amount": "${totalBillAmount * 100}",
      // "name": "Sohit App",
      "description": "Payment for the some random product",

      "prefill": {"contact": "", "email": ""},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    var cartProviderModel =
        Provider.of<CartProviderModel>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Payment Option"),
                Text(
                  "${cartProviderModel.mycart.length} Item, to pay: ₹${cartProviderModel.totalBillAmount}",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        body: Consumer<CartProviderModel>(builder: (context, cart, child) {
          return Consumer<AddAddressProviderModel>(
            builder: (context, addressModel, child) {
              return addressModel.getUserAddress().length == 0
                  ? Container()
                  : Consumer<AddAddressProviderModel>(
                      builder: (context, addressModel, child) {
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            //PAY ON DELIVERY
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text('PAY ON DELIVERY',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            SizedBox(height: 2),
                            CustomDividerView(
                                dividerHeight: 1.0,
                                color: Theme.of(context).dividerColor),
                            GFAccordion(
                              titlePadding: EdgeInsets.only(right: 20),
                              margin: EdgeInsets.all(0),
                              titleChild: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/img/wallet.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Cash',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                              contentChild: Container(
                                child: cart.isPlacingOrder()
                                    ? Center(child: hibachiLoader)
                                    : ElevatedButton(
                                        onPressed: () async {
                                          PlaceOrderOutputModel
                                              placeOrderOutputModel = await cart
                                                  .placeOrderToApi(
                                                      context,
                                                      addressModel
                                                          .addressForOrder.id,
                                                      addressModel
                                                          .addressForOrder
                                                          .address,
                                                      addressModel
                                                          .addressForOrder
                                                          .house,
                                                      'COD');
                                          if (placeOrderOutputModel != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    Thankyou(
                                                        placeOrderOutputModel
                                                            .data
                                                            .uniqueOrderId),
                                              ),
                                            );
                                          }
                                        },
                                        child: Text('Pay Cash on Delivery'),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orange),
                                      ),
                              ),
                            ),
                            SizedBox(height: 30),
                            // PAY ON ONLINE
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.only(left: 15),
                              child: Text('PAY ON ONLINE',
                                  style: Theme.of(context).textTheme.bodyText1),
                            ),
                            SizedBox(height: 2),
                            CustomDividerView(
                                dividerHeight: 1.0,
                                color: Theme.of(context).dividerColor),
                            GFAccordion(
                              margin: EdgeInsets.all(0),
                              titlePadding: EdgeInsets.only(right: 20),
                              titleChild: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/img/razorpay.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text('RazorPay',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                    // Spacer(),
                                    // Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                                  ],
                                ),
                              ),
                              contentChild: Container(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    openCheckout(
                                        cartProviderModel.totalBillAmount);
                                    succseusFxn(addressModel.addressForOrder);
                                    // if (paymentComplete == true) {
                                    //   placeOrderOutputModel =
                                    //       await cart.placeOrder(
                                    //           addressModel
                                    //               .addressForOrder.address,
                                    //           addressModel
                                    //               .addressForOrder.house,
                                    //           'Razorpay');
                                    //   if (placeOrderOutputModel != null) {
                                    //     // Need to show Toast
                                    //     Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (BuildContext context) =>
                                    //             Thankyou(placeOrderOutputModel
                                    //                 .data.uniqueOrderId),
                                    //       ),
                                    //     );
                                    //   } else {
                                    //     //

                                    //   }
                                    //   setState(() {
                                    //     paymentComplete = false;
                                    //   });
                                    // }

                                    // if (placeOrderOutputModel == null) {
                                    //   // Need to show Toast
                                    // } else {

                                    // }
                                  },
                                  child: Text('Pay from Razor Pay'),
                                  style: ElevatedButton.styleFrom(
                                      //  onPrimary: Colors.orange
                                      primary: Colors.orange),
                                ),
                              ),
                            ),
                            GFAccordion(
                              margin: EdgeInsets.all(0),
                              titlePadding: EdgeInsets.only(right: 20),
                              titleChild: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/img/paytm.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    SizedBox(width: 10),
                                    Text('PayTM',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                              contentChild: Container(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    PlaceOrderOutputModel
                                        placeOrderOutputModel = await cart
                                            .placeOrderToApi(
                                                context,
                                                addressModel.addressForOrder.id,
                                                addressModel
                                                    .addressForOrder.address,
                                                addressModel
                                                    .addressForOrder.house,
                                                'Paytm');
                                    if (placeOrderOutputModel == null) {
                                      // Need to show Toast
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Thankyou(placeOrderOutputModel
                                                  .data.uniqueOrderId),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('Pay from PayTM'),
                                  style: ElevatedButton.styleFrom(
                                      //  onPrimary: Colors.orange
                                      primary: Colors.orange),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
            },
          );
        }));
  }
}
