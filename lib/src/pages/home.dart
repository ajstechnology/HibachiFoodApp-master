import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:markets/src/pages/Address/address_listing_page.dart';
import 'package:provider/provider.dart';

import '../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../StateManagement/ProviderModels/homePageProviderModel.dart';
import '../elements/category_list.dart';
import '../elements/homeSliderWidget.dart';
import '../elements/recommendedWidget.dart';
import 'Blog/blogSliderWidget.dart';
import 'HomePage/allProductsWidget.dart';
import 'HomePage/newProductsSlider.dart';
import 'widgets/loader.dart';
import 'widgets/resturantDiscountSlider.dart';
import 'widgets/resturantSlider.dart';

class HomeWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  HomeWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  ScrollController controller = new ScrollController();
  Location locationService = Location();
  BuildContext _buildContext;

  @override
  void initState() {
    super.initState();
    //getProducts();

    controller.addListener(() {
      setState(() {});
    });
  }

  // getProducts() async {
  //   if (await getLoc()) {
  //     Provider.of<HomePageProviderModel>(context, listen: false)
  //         .getResturantProducts(false);
  //   }
  // }

  void scroll() {
    if (controller.offset == controller.position.maxScrollExtent) {
      controller.animateTo(0,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    } else {
      controller.animateTo(controller.offset + 320,
          duration: Duration(milliseconds: 1000), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageProviderModel>(
      create: (_) => HomePageProviderModel(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.location_on, color: Theme.of(context).hintColor),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          title: InkWell(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddressListingPage()),
              );
              /*await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyLocation()),
              );*/
            },
            child: Consumer<AddAddressProviderModel>(
              builder: (context, myModel, child) {
                bool isNeedToLoadProduct = false;
                if (myModel.addressForOrder != null) {
                  isNeedToLoadProduct = true;
                } else if (myModel.addressForOrder == null &&
                    !myModel.getIsLoading()) {
                  isNeedToLoadProduct = true;
                }
                if (isNeedToLoadProduct) {
                  Provider.of<HomePageProviderModel>(context, listen: false)
                      .getResturantProducts(
                          true,
                          false,
                          myModel.addressForOrder.latitude,
                          myModel.addressForOrder.longitude,);
                }
                return myModel.getIsLoading()
                    ? hibachiLoader
                    : Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  myModel.addressForOrder == null
                                      ? 'Pick Your Delivery Location'
                                      : myModel.addressForOrder.address,
                                  style: Theme.of(context).textTheme.headline1),
                              myModel.addressForOrder == null
                                  ? Container()
                                  : Text(
                                      myModel.addressForOrder == null
                                          ? ''
                                          : myModel.addressForOrder.house,
                                      style:
                                          Theme.of(context).textTheme.caption),
                            ],
                          ),
                          Expanded(child: Container())
                        ],
                      );
              },
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Consumer<AddAddressProviderModel>(
              builder: (context, myModel, child) {
                Provider.of<HomePageProviderModel>(context, listen: false)
                    .getResturantProducts(
                  true,
                  true,
                  myModel.addressForOrder.latitude,
                  myModel.addressForOrder.longitude,);
                return;
              },
            );
            return;
          },
          child: Consumer<AddAddressProviderModel>(
            builder: (context, addressModel, child) {
              return Consumer<HomePageProviderModel>(
                builder: (context, myModel, child) {
                  _buildContext = context;
                  return myModel.getLoadingProducts()
                      ? hibachiLoader
                      : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                    EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    child: Container(
                      color: myModel.getAllProducts().isNotEmpty ? Colors.blueGrey.shade50 : null,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: myModel.getAllProducts().isNotEmpty ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 10),
                          HomeSliderWidget(myModel),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              'Meat You May Like',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset(
                                'assets/animations/swipe-right-arrows.json',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          RecommendedWidget(myModel),
                          SizedBox(height: 15),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              "Categories",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset(
                                'assets/animations/swipe-right-arrows.json',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CategoryList(myModel),
                          SizedBox(height: 10),
                          ResturantSliderWidget(
                              myModel.getRestaurantSlider()),
                          SizedBox(height: 10),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              "Hibachi's Best Price",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset(
                                'assets/animations/swipe-right-arrows.json',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          NewProductsSlider(myModel),
                          SizedBox(height: 10),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              'Hot Deals %',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset(
                                'assets/animations/swipe-right-arrows.json',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ResturantDiscountSliderWidget(
                              myModel.getRestaurantDiscountSlider()),
                          SizedBox(height: 10),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              'Blogs',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          BlogSliderWidget(myModel.getBlogsList()),
                          SizedBox(height: 10),
                          ListTile(
                            dense: true,
                            tileColor: Colors.blueGrey.shade100,
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                            leading:
                            Image.asset("assets/img/hibachiBlueBird.png"),
                            title: Text(
                              'All Products',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            trailing: Container(
                              height: 80,
                              width: 80,
                              child: Lottie.asset(
                                'assets/animations/swipe-right-arrows.json',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          AllProductsSlider(myModel, controller),
                        ],
                      ) : Center(child: Text("No products available")),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

// Future<bool> _getLoc() async {
//   bool _serviceEnabled;
//   PermissionStatus _permissionGranted;

//   _serviceEnabled = await locationService.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await locationService.requestService();
//     if (!_serviceEnabled) {
//       return false;
//     }
//   }

//   _permissionGranted = await locationService.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await locationService.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       return false;
//     }
//   }

//   userCurrentPosition = await locationService.getLocation();

//   return true;
// }
}
