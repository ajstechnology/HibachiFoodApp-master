import 'package:flutter/material.dart';
import '../../StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import 'package:provider/provider.dart';
import '../../elements/favoriteGridItemWidget.dart';

class FavoritesWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  FavoritesWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _FavoritesWidgetState createState() => _FavoritesWidgetState();
}

class _FavoritesWidgetState extends State<FavoritesWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteProductProviderModel>(
        builder: (context, favoriteModel, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      Icons.favorite,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      'Favorite products',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
                favoriteModel.myFavorite.length == 0
                    ? Center(
                        child: Text("No Favorite product found."),
                      )
                    : GridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? 2
                            : 4,
                        // Generate 100 widgets that display their index in the List.
                        children: List.generate(favoriteModel.myFavorite.length,
                            (index) {
                          return FavoriteGridItemWidget(
                              favoriteModel.myFavorite[index]);
                        }),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
