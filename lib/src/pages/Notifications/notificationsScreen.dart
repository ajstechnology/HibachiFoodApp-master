import 'package:flutter/material.dart';
import 'package:markets/src/SendHttpCalls/Models/Notification/notification_model_new.dart';
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../../SendHttpCalls/Models/Notification/notificationModel.dart';
import '../widgets/loader.dart';
import '../../StateManagement/ProviderModels/Notifications/notificationProviderModel.dart';
import 'package:provider/provider.dart';
import '../../elements/notificationItemWidget.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myModel = Provider.of<NotificationProviderModel>(context);
    AddAddressProviderModel addressModel = Provider.of<AddAddressProviderModel>(context);
    return FutureBuilder<List<NotificationModelNew>>(
      future: myModel.getNotificationData(
        lat: addressModel.getUserAddress().first.latitude,
        long: addressModel.getUserAddress().first.longitude,
      ), // async work
      builder: (BuildContext context,
          AsyncSnapshot<List<NotificationModelNew>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: hibachiLoader,
            );
          default:
            if (snapshot.hasError) {
              return Text('Error occur while downloading Notifications.');
            } else if (snapshot.data.length == 0) {
              return Center(
                child: Text(
                  'No Notifications found.',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .merge(TextStyle(letterSpacing: 1.3)),
                ),
              );
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 10),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      leading: Icon(
                        Icons.notifications,
                        color: Theme.of(context).hintColor,
                      ),
                      title: Text(
                        'Notifications',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 15);
                    },
                    itemBuilder: (context, index) {
                      return NotificationItemWidget(
                        snapshot.data[index],
                      );
                    },
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
