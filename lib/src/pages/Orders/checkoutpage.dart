import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:markets/src/database/sharedPreference.dart';
import 'package:provider/provider.dart';

import '../../SendHttpCalls/Models/cartModel.dart';
import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../../StateManagement/ProviderModels/Addresses/addressApiModel.dart';
import '../../StateManagement/ProviderModels/cartProviderModel.dart';
import '../../elements/timeConfirmationPopUp.dart';
import '../Address/myLocation.dart';
import '../Coupons/apply_coupon.dart';
import '../Payment/payment_option_page.dart';
import '../widgets/custom_divider_view.dart';
import '../widgets/loader.dart';
import 'scheduleTimePage.dart';

class CheckoutPage extends StatefulWidget {
  final bool showAppBar;

  CheckoutPage(this.showAppBar);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Consumer<AddAddressProviderModel>(
      builder: (context, addressModel, child) {
        Provider.of<CartProviderModel>(context, listen: false)
            .changeCartItemForDifferentAddress(
                addressModel.addressForOrder.latitude,
                addressModel.addressForOrder.longitude);
        return Consumer<CartProviderModel>(
          builder: (context, cart, child) {
            return Scaffold(
              appBar: widget.showAppBar
                  ? AppBar(
                      title: Center(child: Text("Check out")),
                    )
                  : null,
              bottomNavigationBar: Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(cart.totalBillAmount.toString(),
                              style: Theme.of(context).textTheme.bodyText1),
                          Text(
                            'TOTAL BILL',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    cart.totalItemAmount == 0
                        ? Container()
                        : Consumer<AddAddressProviderModel>(
                            builder: (context, addressModel, child) {
                              return addressModel.getUserAddress().length == 0
                                  ? Container()
                                  : Consumer<AddAddressProviderModel>(
                                      builder: (context, addressModel, child) {
                                        return Expanded(
                                          flex: 8,
                                          child: InkWell(
                                            onTap: () async {
                                              String response =
                                                  await showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder: (context) {
                                                  return TimeConfirmationPopUp();
                                                },
                                              );
                                              if (response == "0") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PaymentOptionPage(),
                                                  ),
                                                );
                                              } else if (response == "1") {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ScheduleTimePage(),
                                                  ),
                                                );
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(
                                                  'PROCEED TO PAY',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .merge(
                                                        TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .scaffoldBackgroundColor),
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                            },
                          ),
                  ],
                ),
              ),
              body: Consumer<AddAddressProviderModel>(
                builder: (context, value, child) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            FilmContent(
                              lat: double.parse(value.addressForOrder.latitude),
                              long:
                                  double.parse(value.addressForOrder.longitude),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class FilmContent extends StatefulWidget {
  const FilmContent({Key key, this.lat, this.long}) : super(key: key);

  @override
  _FilmContentState createState() => _FilmContentState();
  final double lat;
  final double long;
}

class _FilmContentState extends State<FilmContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProviderModel>(
      builder: (context, cart, child) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add Address
                Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: AddressCardForOrder(),
                ),

                // Items
                Padding(
                  padding: EdgeInsets.all(10),
                  child: cart.mycart.length == 0
                      ? Text(
                          "Your cart is empty, please add some items from menu",
                          style: TextStyle(color: Colors.orange, fontSize: 15),
                        )
                      : DropdownSearch<CartModel>(
                          mode: Mode.DIALOG,
                          showSelectedItem: true,
                          items: cart.mycart,
                          label: "Cart Items",
                          hint: "Select Cart Item",
                          dropdownBuilder: (context, item, itemAsString) => Row(
                            children: <Widget>[
                              // Dot Container and Name of Product
                              Expanded(
                                flex: 4,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.brown,
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.brown,
                                          shape: BoxShape.circle,
                                        ),
                                        width: 6.0,
                                        height: 6.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text(
                                        item?.name ?? "Name",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Quantity - 1 +
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  height: 30.0,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      InkWell(
                                        child: Icon(Icons.remove,
                                            size: 18, color: Colors.green),
                                        onTap: () async {
                                          await cart.removeFromCart(
                                              context, item?.id ?? "Id");
                                        },
                                      ),
                                      Spacer(),
                                      Text(
                                        item?.quantity?.toString() ??
                                            "Quantity",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(fontSize: 16.0),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        child: Icon(Icons.add,
                                            size: 18, color: Colors.green),
                                        onTap: () async {
                                          await cart.addToCart(
                                            item?.id ?? "Id",
                                            item?.price?.toString() ?? "Price",
                                            item?.name ?? "Name",
                                            item?.resturantId ?? "ResId",
                                            widget.lat,
                                            widget.long,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              // Price
                              Expanded(
                                child: Text(
                                  item?.price?.toString() ?? "Price",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            ],
                          ),
                          popupItemBuilder: (context, item, isSelected) =>
                              Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
                            child: Row(
                              children: <Widget>[
                                // Dot Container and Name of Product
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.brown,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.brown,
                                            shape: BoxShape.circle,
                                          ),
                                          width: 6.0,
                                          height: 6.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          item?.name ?? "Name",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Quantity - 1 +
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    height: 30.0,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        InkWell(
                                          child: Icon(Icons.remove,
                                              size: 18, color: Colors.green),
                                          onTap: () async {
                                            await cart.removeFromCart(
                                                context, item?.id ?? "Id");
                                          },
                                        ),
                                        Spacer(),
                                        Text(
                                          item?.quantity?.toString() ??
                                              "Quantity",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(fontSize: 16.0),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          child: Icon(Icons.add,
                                              size: 18, color: Colors.green),
                                          onTap: () async {
                                            await cart.addToCart(
                                                item?.id ?? "Id",
                                                item?.price?.toString() ??
                                                    "Price",
                                                item?.name ?? "Name",
                                                item?.resturantId ?? "ResId",
                                                widget.lat,
                                              widget.long,
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Price
                                Expanded(
                                  child: Text(
                                    item?.price?.toString() ?? "Price",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          compareFn: (item, selectedItem) {
                            return item == selectedItem;
                          },
                          selectedItem:
                              cart.mycart.length > 0 ? cart.mycart[0] : null,
                        ),
                ),
                SizedBox(height: 10),
                CustomDividerView(dividerHeight: 15.0),
                // Apply coupons
                GestureDetector(
                  onTap: () {
                    if (cart.couponOutputModel == null) {
                      if (cart.mycart.length > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyCoupon(
                                  cart.mycart[0].resturantId.toString())),
                        );
                      }
                    } else if (cart.couponOutputModel != null) {
                      cart.couponOutputModel = null;
                      if (cart.mycart.length > 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplyCoupon(
                                  cart.mycart[0].resturantId.toString())),
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    color: Colors.brown.shade50,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          child: Lottie.asset(
                            'assets/animations/offerIcon.json',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Offers',
                            style: Theme.of(context).textTheme.bodyText1),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                CustomDividerView(dividerHeight: 15.0),
                // Bill details
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Bill Details',
                          style: Theme.of(context).textTheme.bodyText1),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Items total',
                              style: Theme.of(context).textTheme.subtitle2),
                          Text(cart.totalItemAmount.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.subtitle2),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Delivery Fee',
                                        style: TextStyle(color: Colors.blue)),
                                    Text(cart.deliveryFee.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ],
                                ),
                                SizedBox(height: 5),
                                CustomDividerView(
                                    dividerHeight: 1.0,
                                    color: Theme.of(context).dividerColor),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Taxes and Charges',
                                        style: TextStyle(color: Colors.blue)),
                                    Text(cart.gstFee.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2),
                                  ],
                                ),
                                Visibility(
                                  visible: cart.appliedCouponAmount > 0,
                                  child: CustomDividerView(
                                      dividerHeight: 1.0,
                                      color: Theme.of(context).dividerColor),
                                ),
                                Visibility(
                                  visible: cart.appliedCouponAmount > 0,
                                  child: SizedBox(height: 10),
                                ),
                                Visibility(
                                  visible: cart.appliedCouponAmount > 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Discount Amount',
                                          style: TextStyle(color: Colors.blue)),
                                      Text(
                                          "-" +
                                              cart.appliedCouponAmount
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CustomDividerView(
                          dividerHeight: 1.0,
                          color: Theme.of(context).dividerColor),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Text(
                              'To Pay',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Spacer(),
                            Text(
                              cart.totalBillAmount.toStringAsFixed(2),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomDividerView(dividerHeight: 25.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddressCardForOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddAddressProviderModel>(
      builder: (context, model, child) {
        var userAddress = model.getUserAddress();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyLocation()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Lottie.asset(
                        'assets/animations/location.json',
                      ),
                    ),
                    Text(
                      'Select Delivery Location',
                      style: TextStyle(color: Colors.lightBlue.shade900),
                    ),
                  ],
                ),
              ),
            ),
            model.getIsLoading()
                ? Center(
                    child: hibachiLoader,
                  )
                : userAddress.length == 0
                    ? Text('No address found.')
                    : DropdownSearch<AddressApiModel>(
                        mode: Mode.DIALOG,
                        showSelectedItem: true,
                        items: userAddress,
                        label: "Delivery Address",
                        hint: "Select Delivery Address",
                        dropdownBuilder: (context, item, itemAsString) =>
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Delivery Address",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(item?.address ?? "",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                  SizedBox(height: 5),
                                  Text(
                                    item.house ?? 'No House',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                        popupItemBuilder: (context, item, isSelected) =>
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Delivery Address",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text(item.address,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                  SizedBox(height: 5),
                                  Text(
                                    item.house ?? 'No House',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ),
                        compareFn: (item, selectedItem) {
                          return item == selectedItem;
                        },
                        onChanged: (value) {
                          Provider.of<CartProviderModel>(context, listen: false)
                              .changeCartItemForDifferentAddress(
                                  value.latitude, value.longitude);
                        },
                        selectedItem: userAddress[0])
          ],
        );
      },
    );
  }
}
