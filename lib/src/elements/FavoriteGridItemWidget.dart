import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../pages/Products/productDetailsPage.dart';
import '../SendHttpCalls/Models/Product/productDetailsModel.dart';
import '../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import 'package:provider/provider.dart';

class FavoriteGridItemWidget extends StatelessWidget {
  final ProductDetailsModel itemsModel;
  const FavoriteGridItemWidget(this.itemsModel, {Key key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
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
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: itemsModel.image,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),
              ),
              SizedBox(height: 5),
              Text(
                itemsModel.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                itemsModel.desc,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            ],
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
                    color: Colors.red,
                    size: 18,
                  ),
                  color: Theme.of(context).accentColor.withOpacity(0.9),
                  shape: StadiumBorder(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
