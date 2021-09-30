import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:lottie/lottie.dart';
import 'package:markets/src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'package:markets/src/helpers/app_permission_handler.dart';
import 'package:markets/src/pages/Address/MyLocation.dart';
import 'package:markets/src/pages/widgets/loader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

final searchScaffoldKey = GlobalKey<ScaffoldState>();
const kGoogleApiKey = "AIzaSyBo106ZFk5bxlVZkU4R6WQ92W4UAvXkrm8";

class AddressListingPage extends StatelessWidget {
  const AddressListingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Address"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                readOnly: true,
                onTap: () => Get.to(() => CustomSearchScaffold()),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(12),
                  hintText: 'Search for Address',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .caption
                      .merge(TextStyle(fontSize: 14)),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    color: Theme.of(context).hintColor,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.1))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.3))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).focusColor.withOpacity(0.1))),
                ),
              ),
            ),
            GFListTile(
              titleText: 'Current location',
              subTitleText: 'Using GPS',
              avatar: Icon(Icons.my_location),
              onTap: () async {
                /*if (await AppPermissionHandler.checkAndRequestPermission(
                    Permission.location)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLocation()),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg:
                          "Location permission is required to use this feature");
                }*/
                goToMapScreen();
              },
            ),
            Consumer<AddAddressProviderModel>(
              builder: (context, model, child) {
                var userAddress = model.getUserAddress();
                return Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
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
                                style:
                                    TextStyle(color: Colors.lightBlue.shade900),
                              ),
                            ],
                          ),
                        ),
                        model.getIsLoading()
                            ? Center(
                                child: hibachiLoader,
                              )
                            : userAddress.length == 0
                                ? Text('No address found.')
                                : ListView.builder(
                                    itemCount: userAddress.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => GFListTile(
                                      titleText:
                                          userAddress[index]?.address ?? "",
                                      subTitleText: userAddress[index].house ??
                                          'No House',
                                      avatar: Icon(Icons.location_on_sharp),
                                      onTap: () {
                                        Navigator.pop(context);
                                        model.updateAddress(userAddress[index]);
                                      },
                                    ),
                                    /*itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(userAddress[index]?.address ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                          SizedBox(height: 5),
                                          Text(
                                            userAddress[index].house ?? 'No House',
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .merge(TextStyle(
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

goToMapScreen([double lat, double long]) async {
  if (await AppPermissionHandler.checkAndRequestPermission(
      Permission.location)) {
    Get.to(() => MyLocation(
      lat: lat,
      long: long,
    ));
  } else {
    Fluttertoast.showToast(
        msg: "Location permission is required to use this feature");
  }
}

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "in")],
          types: [],
          strictbounds: false,
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState);
      },
      logo: Container(
        child: Center(
          child: Row(
            children: [Text("No Result Found")],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      /*searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );*/
    }
  }
}

Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
  if (p != null) {
    // get detail (lat/lng)
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    Get.back();
    goToMapScreen(lat, lng);

    /*scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );*/
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
