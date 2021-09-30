import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../pages/Orders/orderDetailPage.dart';
import '../SendHttpCalls/Models/Orders/orderAPIModel.dart';
import 'productOrderItemWidget.dart';

class OrderItemWidget extends StatelessWidget {
  final bool expanded;
  final OrdersAPIModel orderModel;
  final String status;
  OrderItemWidget(
    this.orderModel,
    this.status, {
    Key key,
    this.expanded,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return OrderDetailsPage(orderModel);
            },
          ),
        );
      },
      child: Stack(
        children: <Widget>[
          Opacity(
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
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Row(
                        children: [
                          Column(
                            children: <Widget>[
                              Text('Order ID: ' + orderModel.uniqueOrderId),
                              Text(
                                orderModel.createdAt,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            child: Lottie.asset(
                              'assets/animations/swipe-up.json',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(orderModel.subTotal.toString(),
                              style: Theme.of(context).textTheme.headline4),
                          Text(
                            orderModel.paymentMode,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      children: <Widget>[
                        Column(
                            children: List.generate(
                          orderModel.orderitems.length,
                          (indexProduct) {
                            return ProductOrderItemWidget(
                              item: orderModel.orderitems[indexProduct],
                            );
                          },
                        )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Delivery Fee',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  Text(orderModel.deliveryCharge,
                                      style:
                                          Theme.of(context).textTheme.subtitle1)
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      '10%)',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Total',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   child: Wrap(
                //     alignment: WrapAlignment.end,
                //     children: <Widget>[
                //       FlatButton(
                //         onPressed: () {},
                //         textColor: Theme.of(context).hintColor,
                //         child: Wrap(
                //           children: <Widget>[Text('View')],
                //         ),
                //         padding: EdgeInsets.symmetric(horizontal: 0),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 28,
            width: 140,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Theme.of(context).accentColor),
            alignment: AlignmentDirectional.center,
            child: Text(
              status,
              maxLines: 1,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.caption.merge(
                  TextStyle(height: 1, color: Theme.of(context).primaryColor)),
            ),
          ),
        ],
      ),
    );
  }
}
