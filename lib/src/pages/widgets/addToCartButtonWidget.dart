import 'package:flutter/material.dart';
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'package:provider/provider.dart';

import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../../StateManagement/ProviderModels/cartProviderModel.dart';

class AddToCartButtonWidget extends StatelessWidget {
  final ProductDetailsModel itemsModel;
  final double customPadding;

  const AddToCartButtonWidget(this.itemsModel, {Key key, this.customPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddAddressProviderModel>(
      builder: (context, addressModel, child) {
        return Consumer<CartProviderModel>(
          builder: (context, cartModel, child) {
            var quantity = cartModel.checkAndGetQuantity(itemsModel.id);
            return quantity == 0
                ? Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: customPadding ?? 8),
                      child: FlatButton(
                        onPressed: () async {
                          await cartModel.addToCart(
                            itemsModel.id,
                            itemsModel.price,
                            itemsModel.name,
                            int.parse(itemsModel.restaurantId),
                            double.parse(addressModel.addressForOrder.latitude),
                            double.parse(
                                addressModel.addressForOrder.longitude),
                          );
                        },
                        color: Theme.of(context).accentColor.withOpacity(1),
                        shape: StadiumBorder(),
                        child: Center(
                          child: Text(
                            "Add",
                            style: Theme.of(context).textTheme.headline1.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(
                    // decoration: BoxDecoration(border: Border.all()),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                              offset: Offset(2, 2))
                        ]),
                    width: 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // - Icon
                        InkWell(
                          child:
                              Icon(Icons.remove, size: 18, color: Colors.green),
                          onTap: () async {
                            await cartModel.removeFromCart(
                                context, itemsModel.id);
                          },
                        ),

                        // SizedBox(width: 5),
                        Text(
                          quantity.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontSize: 17.0),
                        ),
                        // SizedBox(width: 5),
                        // + icon
                        InkWell(
                          child: Icon(Icons.add, size: 18, color: Colors.green),
                          onTap: () async {
                            await cartModel.addToCart(
                              itemsModel.id,
                              itemsModel.price,
                              itemsModel.name,
                              int.parse(itemsModel.restaurantId),
                              double.parse(
                                  addressModel.addressForOrder.latitude),
                              double.parse(
                                  addressModel.addressForOrder.longitude),
                            );
                          },
                        )
                      ],
                    ),
                  );
          },
        );
      },
    );
  }
}
