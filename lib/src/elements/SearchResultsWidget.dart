import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../pages/widgets/loader.dart';
import '../StateManagement/ProviderModels/Products/searchProductProviderModel.dart';
import '../pages/Products/productDetailsPage.dart';
import 'package:provider/provider.dart';

class SearchResultWidget extends StatefulWidget {
  final String heroTag;

  SearchResultWidget({Key key, this.heroTag}) : super(key: key);

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddAddressProviderModel addressModel = Provider.of<AddAddressProviderModel>(context);

    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ChangeNotifierProvider<SearchProductProviderModel>(
          create: (_) => SearchProductProviderModel(addressModel.getUserAddress().first.latitude, addressModel.getUserAddress().first.longitude),
          child: Consumer<SearchProductProviderModel>(
            builder: (context, searchModel, child) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: searchModel.getSearchKeyController(),
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        hintText: 'Search for Products',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            .merge(TextStyle(fontSize: 14)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          color: Theme.of(context).hintColor,
                          onPressed: () async {
                            Get.dialog(Center(child: CircularProgressIndicator(),), barrierDismissible: false);
                            await searchModel.setSearchKeyWord(addressModel.getUserAddress().first.latitude, addressModel.getUserAddress().first.longitude);
                            Get.back(canPop: false);
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.1))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.3))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.1))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: searchModel.streamController.stream,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return Center(
                              child: hibachiLoader,
                            );
                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Unable to load the search result"),
                              );
                            } else {
                              return snapshot.data.length == 0
                                  ? Center(
                                      child: Text("No products founds"),
                                    )
                                  : ListView(
                                      children: <Widget>[
                                        ListView.separated(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: snapshot.data.length,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(height: 10);
                                          },
                                          itemBuilder: (context, index) {
                                            var itemModel =
                                                snapshot.data[index];
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Container(
                                                height: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              itemModel.image,
                                                          width: 80,
                                                          height: 80,
                                                          fit: BoxFit.cover,
                                                          placeholder: (context,
                                                                  url) =>
                                                              Center(
                                                                  child:
                                                                      CircularProgressIndicator()),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Center(
                                                                  child: Icon(Icons
                                                                      .error)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return ProductDetailsPage(
                                                                  itemModel.id);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                          child: Text(
                                                            itemModel.name,
                                                            style:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .subtitle2
                                                                    .merge(
                                                                      TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    );
                            }
                        }
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
