import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/addToCartButtonWidget.dart';
import '../../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../../StateManagement/ProviderModels/homePageProviderModel.dart';
import 'package:provider/provider.dart';

import '../Products/productDetailsPage.dart';

class NewProductsSlider extends StatelessWidget {
  final HomePageProviderModel myModel;
  NewProductsSlider(this.myModel);
  @override
  Widget build(BuildContext context) {
    return myModel.getSpotlightModel().length == 0
        ? Center(
            child: Text("No Items founds"),
          )
        : Container(
            height: 300,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: myModel.getSpotlightModel().length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardsliderList(
                    itemsModel: myModel.getSpotlightModel()[index]);
              },
            ),
          );
  }
}

class CardsliderList extends StatelessWidget {
  const CardsliderList({Key key, this.itemsModel}) : super(key: key);
  final ProductDetailsModel itemsModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Container(
          width: 250,
          padding: const EdgeInsets.only(left: 20, right: 05),
          child: InkWell(
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.05),
                        offset: Offset(0, 5),
                        blurRadius: 1)
                  ],
                  color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: CachedNetworkImage(
                      imageUrl: itemsModel.image,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Center(child: Icon(Icons.error)),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 50,
                        backgroundImage: imageProvider,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Text(itemsModel.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: itemsModel.oldPrice == "0.00" ||
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
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  AddToCartButtonWidget(
                    itemsModel,
                    customPadding: 70,
                  )
                ],
              ),
            ),
          ),
        ),
        Consumer<FavoriteProductProviderModel>(
            builder: (context, favoriteModel, child) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Container(
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
                  size: 20,
                ),
                color: Theme.of(context).accentColor.withOpacity(0.5),
                shape: StadiumBorder(),
              ),
            ),
          );
        })
      ],
    );
  }
}
