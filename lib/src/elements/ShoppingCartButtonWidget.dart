import 'package:flutter/material.dart';
import '../pages/Orders/checkoutpage.dart';
import '../StateManagement/ProviderModels/cartProviderModel.dart';
import 'package:provider/provider.dart';

class ShoppingCartButtonWidget extends StatefulWidget {
  const ShoppingCartButtonWidget({
    this.iconColor,
    this.labelColor,
    Key key,
  }) : super(key: key);

  final Color iconColor;
  final Color labelColor;

  @override
  _ShoppingCartButtonWidgetState createState() =>
      _ShoppingCartButtonWidgetState();
}

class _ShoppingCartButtonWidgetState extends State<ShoppingCartButtonWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
        height: 150.0,
        width: 30.0,
        child: new GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CheckoutPage(true);
                },
              ),
            );
          },
          child: new Stack(
            children: <Widget>[
              new IconButton(
                icon: new Icon(
                  Icons.shopping_cart,
                ),
                onPressed: null,
              ),
              new Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1,
                        size: 20.0, color: Colors.green[800]),
                    Positioned(
                      top: 3.0,
                      right: 4.0,
                      child: Center(
                        child: Consumer<CartProviderModel>(
                            builder: (context, cart, child) {
                          return Text(
                            cart.mycart.length.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
