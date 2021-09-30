import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../../StateManagement/ProviderModels/Products/productDetailsProviderModel.dart';
import '../../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import '../../elements/shoppingCartButtonWidget.dart';
import '../Orders/checkoutpage.dart';
import '../widgets/addToCartButtonWidget.dart';
import '../widgets/loader.dart';

class ProductDetailsPage extends StatelessWidget {
  final int productId;

  ProductDetailsPage(this.productId, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailsProviderModel>(
      create: (_) => ProductDetailsProviderModel(productId),
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Product Details'),
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 50,
          child: RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CheckoutPage(true);
                  },
                ),
              );
            },
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Proceed to Checkout",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        body: Consumer<ProductDetailsProviderModel>(
          builder: (context, productDetailModel, child) {
            return FutureBuilder<ProductDetailsModel>(
              future: productDetailModel.getProductDetails(), // async work
              builder: (BuildContext context,
                  AsyncSnapshot<ProductDetailsModel> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [hibachiLoader],
                    );
                  default:
                    if (snapshot.hasError)
                      return Column(
                        children: [
                          Text('Error occured while loading product details.'),
                        ],
                      );
                    if (!snapshot.hasData)
                      return Column(
                        children: [
                          Center(child: Text('Unable to product details.')),
                        ],
                      );
                    else
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(vertical: 7),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.15),
                                  offset: Offset(0, 3),
                                  blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Stack(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            children: [
                                              Container(
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot.data.image,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                ),
                                              ),
                                              Consumer<
                                                  FavoriteProductProviderModel>(
                                                builder: (context,
                                                    favoriteModel, child) {
                                                  return Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 30,
                                                    height: 30,
                                                    child: FlatButton(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      onPressed: () {
                                                        favoriteModel
                                                            .saveUnsaveFavorite(
                                                                snapshot.data);
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: favoriteModel
                                                                .checkFavoriteAndGetQuantity(
                                                                    snapshot
                                                                        .data
                                                                        .id)
                                                            ? Colors.red
                                                            : Theme.of(context)
                                                                .primaryColor,
                                                        size: 20,
                                                      ),
                                                      color: Theme.of(context)
                                                          .accentColor
                                                          .withOpacity(0.5),
                                                      shape: StadiumBorder(),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Center(
                                              child: Text(
                                                snapshot.data.name,
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AddToCartButtonWidget(
                                snapshot.data,
                                customPadding: 125,
                              ),
                              snapshot.data.oldPrice == "0.00" ||
                                      snapshot.data.oldPrice ==
                                          snapshot.data.price
                                  /*? ListTile(
                                    dense: true,
                                    title: Text(
                                      'Price',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    trailing: Text(
                                      snapshot.data.price,
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                                  )*/
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Price',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                            Text(
                                              snapshot.data.price,
                                              style: TextStyle(
                                                      color: Theme.of(context)
                                                          .focusColor)
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /*ListTile(
                                        dense: true,
                                        title: Text(
                                          'Old Price',
                                          style:
                                          Theme.of(context).textTheme.bodyText2,
                                        ),
                                        trailing: Text(
                                          snapshot.data.oldPrice,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        ),
                                      ),*/
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Old Price',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot.data.oldPrice,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Price',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                Text(
                                                  snapshot.data.price,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Net wt',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data.netWeight ?? "N/A",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Gross wt',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(color: Colors.black),
                                      ),
                                      Text(
                                        snapshot.data.grossWeight ?? "N/A",
                                        style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor)
                                            .copyWith(color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: Text(
                                              'Description',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 20,
                                                  height: 1),
                                            ),
                                          ),
                                          Html(
                                            data: snapshot.data.desc,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
