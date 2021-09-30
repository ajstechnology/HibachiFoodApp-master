import 'package:flutter/material.dart';
import '../SendHttpCalls/Models/Orders/orderAPIModel.dart';

class ProductOrderItemWidget extends StatelessWidget {
  final Orderitems item;
  const ProductOrderItemWidget({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/img/hibachiBlueBird.png',
              height: 60.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Wrap(
                        children: List.generate(1, (index) {
                          return Text(
                            'Quantiy',
                            style: Theme.of(context).textTheme.caption,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(item.price,
                        style: Theme.of(context).textTheme.subtitle1),
                    Text(
                      item.quantity,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
