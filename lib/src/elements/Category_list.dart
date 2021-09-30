import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../StateManagement/ProviderModels/homePageProviderModel.dart';
import '../pages/Products/itemsByCategory.dart';

// category list
class CategoryList extends StatelessWidget {
  final HomePageProviderModel myModel;
  CategoryList(this.myModel);
  @override
  Widget build(BuildContext context) {
    return myModel.getCategoryList().length == 0
        ? Center(
            child: Text("No categories found"),
          )
        : Container(
            height: 150,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: List<Widget>.generate(myModel.getCategoryList().length,
                  (index) {
                var itemCategory = myModel.getCategoryList()[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          print("Category Id =>" +
                              itemCategory.categoriesIds[0].value.toString());
                          return CategoryItems(
                            itemCategory.id,
                            itemCategory.name,
                            myModel.getItemsByCategoryId(
                                itemCategory.categoriesIds[0].value),
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 05, right: 05, top: 10, bottom: 10),
                            child: CachedNetworkImage(
                              imageUrl: itemCategory.image,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.error)),
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 50,
                                backgroundImage: imageProvider,
                              ),
                              /*imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image:
                                        DecorationImage(image: imageProvider),
                                    borderRadius: BorderRadius.circular(10)),
                              ),*/
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                      offset: Offset(2, 2))
                                ]),
                            child: Text(
                              itemCategory.name,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
