import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/addToCartButtonWidget.dart';
import '../../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import '../../SendHttpCalls/Models/Product/productDetailsModel.dart';
import 'package:provider/provider.dart';

import 'productDetailsPage.dart';

class CategoryItems extends StatefulWidget {
  final List<ProductDetailsModel> products;
  final String categoryName;
  final int categoryId;
  CategoryItems(this.categoryId, this.categoryName, this.products);
  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.categoryName + " Items")),
      ),
      body: widget.products.length == 0
          ? Center(
              child: Text("No Items founds"),
            )
          : Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) => Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CategoryFoodItem(
                                itemsModel: widget.products[index]),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class CategoryFoodItem extends StatelessWidget {
  const CategoryFoodItem({Key key, this.itemsModel}) : super(key: key);
  final ProductDetailsModel itemsModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          itemsModel.oldPrice != "0.00" &&
                                  itemsModel.oldPrice != itemsModel.price
                              ? Text(
                                  "Old Price:" + itemsModel.oldPrice,
                                  style: TextStyle(
                                      decoration: TextDecoration
                                          .lineThrough), //Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Container(),
                          Text(
                            "Price:" + itemsModel.price,
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
                        ],
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
                  size: 20,
                ),
                color: Theme.of(context).accentColor.withOpacity(0.5),
                shape: StadiumBorder(),
              ),
            );
          },
        ),
      ],
    );
  }
}
