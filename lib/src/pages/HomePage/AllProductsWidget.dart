import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/addToCartButtonWidget.dart';
import '../../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../../StateManagement/ProviderModels/homePageProviderModel.dart';
import 'package:provider/provider.dart';

import '../Products/productDetailsPage.dart';

class AllProductsSlider extends StatelessWidget {
  final ScrollController controller;
  final HomePageProviderModel myModel;
  AllProductsSlider(this.myModel, this.controller);
  @override
  Widget build(BuildContext context) {
    return myModel.getAllProducts().length == 0
        ? Center(
            child: Text("No Items founds"),
          )
        : Container(
            height: 700,
            child: GridView.count(
              childAspectRatio: 0.60,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              primary: false,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.symmetric(horizontal: 20),
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 4
                      : 4,
              children: List.generate(
                myModel.getAllProducts().length,
                // myModel.getRestaurantItemsModel().recommended.length,
                (index) {
                  return AllFoodItem(
                      itemsModel: myModel.getAllProducts()[index]);
                },
              ),
            ),
          );
  }
}

class AllFoodItem extends StatelessWidget {
  const AllFoodItem({Key key, this.itemsModel}) : super(key: key);
  final ProductDetailsModel itemsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProductDetailsPage(itemsModel.id);
                    },
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: CachedNetworkImage(
                              imageUrl: itemsModel.image,
                              fit: BoxFit.fitHeight,
                              width: 105,
                              height: 90,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            itemsModel.name,
                            style: Theme.of(context).textTheme.headline1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 2),
                          itemsModel.oldPrice == "0.00" ||
                                  itemsModel.oldPrice == itemsModel.price
                              ? Text(
                                  "Price:" + itemsModel.price,
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Old Price:" + itemsModel.oldPrice,
                                      style: TextStyle(
                                          decoration: TextDecoration
                                              .lineThrough), //Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "New Price:" + itemsModel.price,
                                      style:
                                          Theme.of(context).textTheme.caption,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                          Text(
                            "Net wt:" + "${itemsModel.netWeight}",
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Gross wt:" + "${itemsModel.grossWeight}",
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          AddToCartButtonWidget(itemsModel),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<FavoriteProductProviderModel>(
              builder: (context, favoriteModel, child) {
                return Container(
                  margin: EdgeInsets.all(10),
                  width: 30,
                  height: 30,
                  child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      favoriteModel.saveUnsaveFavorite(itemsModel);
                    },
                    child: Icon(
                      Icons.favorite,
                      color: favoriteModel
                              .checkFavoriteAndGetQuantity(itemsModel.id)
                          ? Colors.red
                          : Theme.of(context).primaryColor,
                      size: 20,
                    ),
                    color: Theme.of(context).accentColor.withOpacity(0.5),
                    shape: StadiumBorder(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
