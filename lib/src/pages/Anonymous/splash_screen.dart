import 'package:flutter/material.dart';
import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../../StateManagement/ProviderModels/Notifications/notificationProviderModel.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../database/sharedPreference.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    loggedInUser = await checkLogin();
    Timer(Duration(seconds: 3), () {
      if (loggedInUser == null) {
        Navigator.of(context).pushReplacementNamed('/Login');
      } else {
        Provider.of<AddAddressProviderModel>(context, listen: false)
            .getUserAddressFromAPI(context);
        Provider.of<NotificationProviderModel>(context, listen: false)
            .saveUserNotificationToken();
        Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/hibachiBlueBird.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
