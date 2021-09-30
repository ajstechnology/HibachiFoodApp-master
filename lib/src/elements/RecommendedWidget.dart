import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import '../pages/widgets/addToCartButtonWidget.dart';
import '../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import '../pages/Products/productDetailsPage.dart';
import '../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../StateManagement/ProviderModels/homePageProviderModel.dart';

class RecommendedWidget extends StatelessWidget {
  final HomePageProviderModel myModel;
  RecommendedWidget(this.myModel);
  Widget build(BuildContext context) {
    return myModel.getRestaurantItemsModel() == null ||
            myModel.getRestaurantItemsModel().recommended.length == 0
        ? Center(
            child: Text("No Items founds"),
          )
        : Container(
            height: 340,
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
                      ? 2
                      : 4,
              children: List.generate(
                myModel.getRestaurantItemsModel().recommended.length,
                (index) {
                  return RecommendedBestTopFoodItem(
                      itemsModel:
                          myModel.getRestaurantItemsModel().recommended[index]);
                },
              ),
            ),
          );
  }
}

class RecommendedBestTopFoodItem extends StatelessWidget {
  const RecommendedBestTopFoodItem({Key key, this.itemsModel})
      : super(key: key);
  final ProductDetailsModel itemsModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Container(
        color: Colors.white,
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
                margin: EdgeInsets.only(left: 5.0, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: CachedNetworkImage(
                          imageUrl: itemsModel.image,
                          width: 80,
                          height: 130,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.error)),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 2,
                      child: Column(
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
                          Visibility(
                            visible: itemsModel.oldPrice != "0.00" &&
                                itemsModel.oldPrice != itemsModel.price,
                            child: Text(
                              "Old Price:" + itemsModel.oldPrice,
                              style: TextStyle(
                                  decoration: TextDecoration
                                      .lineThrough), //Theme.of(context).textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "New Price:" + itemsModel.price,
                            style: Theme.of(context).textTheme.caption,
                            overflow: TextOverflow.ellipsis,
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
                          AddToCartButtonWidget(itemsModel)
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
                    color:
                        favoriteModel.checkFavoriteAndGetQuantity(itemsModel.id)
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                    size: 18,
                  ),
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                  shape: StadiumBorder(),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
