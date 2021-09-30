import 'package:flutter/material.dart';
import '../widgets/loader.dart';
import '../../SendHttpCalls/Models/Orders/orderAPIModel.dart';
import '../../StateManagement/ProviderModels/Orders/ordersProviderModel.dart';
import 'package:provider/provider.dart';
import '../../elements/orderItemWidget.dart';

class OrdersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Theme.of(context).hintColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My orders',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: ChangeNotifierProvider<OrderProviderModel>(
        create: (_) => OrderProviderModel(),
        child: Consumer<OrderProviderModel>(
          builder: (context, myModel, child) {
            return FutureBuilder<List<OrdersAPIModel>>(
              future: myModel.getMyOrders(), // async work
              builder: (BuildContext context,
                  AsyncSnapshot<List<OrdersAPIModel>> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: hibachiLoader,
                    );
                  default:
                    if (snapshot.hasError) {
                      return Text('Error occur while downloading Orders.');
                    } else if (snapshot.data.length == 0) {
                      return Center(
                        child: Text(
                          'No orders found.',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .merge(TextStyle(letterSpacing: 1.3)),
                        ),
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data[index];
                                return OrderItemWidget(
                                    item,
                                    myModel
                                        .getNameStatusName(item.orderstatusId));
                              },
                            ),
                          ),
                        ],
                      );
                    }
                }
              },
            );
          },
        ),
      ),
    );
  }
}
