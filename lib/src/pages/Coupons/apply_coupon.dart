import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/loader.dart';
import '../../StateManagement/ProviderModels/cartProviderModel.dart';
import '../../SendHttpCalls/Models/couponsModel.dart';
import '../../StateManagement/ProviderModels/couponsProviderModel.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_divider_view.dart';

class ApplyCoupon extends StatelessWidget {
  final String resturantId;
  ApplyCoupon(this.resturantId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Coupons")),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider<CouponsProviderModel>(
            create: (_) => CouponsProviderModel(),
            child: Flexible(
              flex: 8,
              child: Consumer<CouponsProviderModel>(
                builder: (context, myModel, child) {
                  return FutureBuilder<List<CouponsModel>>(
                    future: myModel.getCoupons(resturantId), // async work
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CouponsModel>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: hibachiLoader,
                          );
                        default:
                          if (snapshot.hasError)
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Sorry! Error occur while downloading Coupons.',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            );
                          else if (snapshot.data.length == 0) {
                            log("Coupon Element = ${snapshot.data.length}");
                            snapshot.data.forEach((element) {
                              log("Coupon Element = ${element.name}");
                            });
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Sorry! no coupons found.',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ],
                            );
                          } else
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return couponCard(snapshot.data[index]);
                              },
                            );
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget couponCard(CouponsModel data) {
    return Consumer<CartProviderModel>(
      builder: (context, cartModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                          width: 60,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.orange[100],
                          ),
                          child: Icon(Icons.card_giftcard,
                              color: Colors.deepOrange)),
                      Container(
                        margin: EdgeInsets.only(left: 55),
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Colors.orange[100],
                        ),
                        child: Center(
                          child: Text(
                            data.code,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  cartModel.isApplyCoupon()
                      ? Center(
                          child: hibachiLoader,
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (await cartModel.applyCoupon(data.code)) {
                              SnackBar snackBar = new SnackBar(
                                  content: Text(
                                "Coupon " +
                                    data.code +
                                    " has been applied with amount " +
                                    cartModel.appliedCouponAmount.toString(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            } else {
                              SnackBar snackBar = new SnackBar(
                                  content: Text("Unable to apply the coupon."));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            'APPLY',
                            style: Theme.of(context).textTheme.bodyText1.merge(
                                TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.w900)),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
              child: Text(
                data.name ?? "N/A",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: CustomDividerView(
                dividerHeight: 1.0,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text(
                data.description ?? "N/A",
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        );
      },
    );
  }
}
