import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markets/src/SendHttpCalls/AddressAPIs.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../../StateManagement/ProviderModels/Addresses/addressApiModel.dart';
import '../widgets/loader.dart';
import 'myLocation.dart';

class MyAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).hintColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Center(
          child: Text(
            'My Address',
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.add, color: Theme.of(context).hintColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLocation()),
              );
            },
          )
        ],
      ),
      body: Consumer<AddAddressProviderModel>(
        builder: (context, myModel, child) {
          var userAddress = myModel.getUserAddress();
          return myModel.getIsLoading()
              ? hibachiLoader
              : userAddress.length == 0
                  ? Center(
                      child: Text(
                        'No address found.',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .merge(TextStyle(letterSpacing: 1.3)),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: userAddress.length,
                            itemBuilder: (context, index) {
                              var item = userAddress[index];
                              return AddressCard(item);
                            },
                          ),
                        ),
                      ],
                    );
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final bool expanded;
  final AddressApiModel addressApiModel;

  AddressCard(
    this.addressApiModel, {
    Key key,
    this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Opacity(
      opacity: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 14),
            padding: EdgeInsets.only(top: 20, bottom: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).focusColor.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Theme(
              data: theme,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    getRow("Address #", addressApiModel.address, context,
                        maxLine: 2),
                    getRow("House No #", addressApiModel.house, context,
                        maxLine: 2),
                    getRow("Door No #", addressApiModel.doorNo, context,
                        maxLine: 2),
                    getRow("Arrival Comment", addressApiModel.arrivalComment,
                        context,
                        maxLine: 2),
                    getRow("Landmark", addressApiModel.landmark, context,
                        maxLine: 2),
                    getRow("Tag", addressApiModel.tag, context),
                    FlatButton(
                      onPressed: () async {
                        Get.dialog(
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                          barrierDismissible: false,
                        );
                        await deleteUserAddress(addressApiModel.id.toString());
                        Provider.of<AddAddressProviderModel>(context, listen: false)
                            .getUserAddressFromAPI(context);
                        Get.back(canPop: false);
                      },
                      child: Text("Delete Address",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .merge(TextStyle(letterSpacing: 1.3))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getRow(String key, String value, BuildContext context,
      {int maxLine = 1}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(width: 60),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                value ?? "N/A",
                overflow: TextOverflow.ellipsis,
                maxLines: maxLine,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
