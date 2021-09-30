import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../OrderTracking/order_tracking_page.dart';
import '../../SendHttpCalls/Models/Orders/orderAPIModel.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrdersAPIModel orderModel;
  OrderDetailsPage(this.orderModel);

  @override
  Widget build(BuildContext context) {
    print("OrderID " +
        orderModel.id.toString() +
        " Order No: " +
        orderModel.uniqueOrderId);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Order Details'),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 7),
        child: Container(
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
          child: Column(
            children: <Widget>[
              getListTile('Order No', orderModel.uniqueOrderId, context),
              getListTile(
                  'Order Date Time', orderModel.createdAt.toString(), context),
              getListTile('Address', orderModel.location, context),
              getListTile('Payment Mode', orderModel.paymentMode, context),
              getListTile('Order Comment', orderModel.orderComment, context),
              getListTile(
                  'Coupon Amount', orderModel.couponAmount.toString(), context),
              getListTile('Coupon Name', orderModel.couponName, context),
              getListTile('Sub Total', orderModel.subTotal.toString(), context),
              getListTile('GST', orderModel.taxAmount.toString(), context),
              getListTile('Delivery Charge',
                  orderModel.deliveryCharge.toString(), context),
              getListTile('Total', orderModel.total.toString(), context),
              getListTile('Payable', orderModel.payable.toString(), context),
              getListTile('Outlet', orderModel.restaurant.name, context),
              Column(
                children: [
                  Center(
                    child: Text(
                      'Schedule Delivery',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  getListTile('Date', orderModel.scheduleDelivery, context),
                  getListTile('Time Slot', orderModel.timeslotes, context),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85),
                child: FlatButton(
                  onPressed: () {
                    Get.to(() => OrderTrackingPage(orderModel));
                  },
                  color: Theme.of(context).accentColor.withOpacity(1),
                  shape: StadiumBorder(),
                  child: Center(
                    child: Text(
                      "Track my order",
                      style: Theme.of(context).textTheme.headline1.merge(
                          TextStyle(
                              color:
                                  Theme.of(context).scaffoldBackgroundColor)),
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Order Items',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                height: 250.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: orderModel.orderitems.length,
                        itemBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              OrderPdoduct(
                                  itemsModel: orderModel.orderitems[index]),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getListTile(String key, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                key,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
          Flexible(
            child: Text(
              value ?? 'N/A',
              softWrap: true,
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPdoduct extends StatelessWidget {
  const OrderPdoduct({Key key, this.itemsModel}) : super(key: key);
  final Orderitems itemsModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text(
                'Name',
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Spacer(),
              Text(
                itemsModel.name,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Quantity',
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Spacer(),
              Text(
                itemsModel.quantity,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(
            children: [
              Text(
                'Price',
                style: Theme.of(context).textTheme.bodyText2,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
              Spacer(),
              Text(
                itemsModel.price,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
