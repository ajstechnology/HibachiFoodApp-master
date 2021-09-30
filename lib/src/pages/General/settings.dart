import 'package:flutter/material.dart';
import '../../StateManagement/ProviderModels/updatePasswordProviderModel.dart';
import 'package:provider/provider.dart';
import 'updateUserInfo.dart';
import '../../database/sharedPreference.dart';
import '../../helpers/helper.dart';
import '../Address/myLocation.dart';

class SettingsWidget extends StatelessWidget {
  final String address = loggedInUser.defaultAddress == null
      ? 'Pick Your Delivery Location'
      : loggedInUser.defaultAddress.address ??
          '' + loggedInUser.defaultAddress.house ??
          '' + loggedInUser.defaultAddress.tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          loggedInUser.name,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          loggedInUser.email,
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  ChangeNotifierProvider<UpdatePasswordProviderModel>(
                    create: (_) => UpdatePasswordProviderModel(),
                    child: // Screen UI
                        Container(
                      child: Consumer<UpdatePasswordProviderModel>(
                        builder: (context, myModel, child) {
                          return TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateUserInfoPage(myModel);
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      'Profile settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  gerRow('Full name', loggedInUser.name, context),
                  gerRow('Email', loggedInUser.email, context),
                  gerRow('Phone', loggedInUser.phone, context),
                  gerRow(
                      'Address',
                      loggedInUser.defaultAddress == null
                          ? 'No Address found'
                          : loggedInUser.defaultAddress.address,
                      context,
                      maxLine: 5),
                  gerRow(
                      'About',
                      loggedInUser.defaultAddress == null
                          ? 'No bio found'
                          : loggedInUser.bio ?? Helper.limitString('bio'),
                      context),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).hintColor.withOpacity(0.15),
                      offset: Offset(0, 3),
                      blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'App settings',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyLocation()),
                      );
                    },
                    dense: true,
                    title: Row(
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          size: 22,
                          color: Theme.of(context).focusColor,
                        ),
                        SizedBox(width: 10),
                        loggedInUser.defaultAddress == null
                            ? Container(
                                child: Center(
                                  child: Text('Pick Your Delivery Location'),
                                ),
                              )
                            : Expanded(
                                child: Text(
                                  address,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )
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

  Widget gerRow(String key, String value, BuildContext context,
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
