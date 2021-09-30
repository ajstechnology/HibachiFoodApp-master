import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'saveAddressPage.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key key, this.lat, this.long}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();

  final double lat;
  final double long;
}

class _MyLocationState extends State<MyLocation> {
  Location _location = Location();

  GoogleMapController _controller;

  void _onMapCreated(
    GoogleMapController _cntlr,
  ) {
    _controller = _cntlr;
  }

  @override
  void initState() {
    super.initState();
    if (widget.lat == null && widget.long == null) {
      _setMapToCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select user location"),
      ),
      body: Consumer<AddAddressProviderModel>(
        builder: (context, myModel, child) {
          return Stack(
            children: [
              Container(
                color: Colors.blueGrey.withOpacity(.8),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: widget.lat == null ? myModel.getCameraPosition() : LatLng(widget.lat, widget.long), zoom: 15),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  onTap: _handleTap,
                  markers: myModel.getMarkers(),
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(right: 55, left: 10),
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (myModel.getMarkers().length == 0) {
                        SnackBar snackBar = new SnackBar(
                            content: Text(
                                "Please select the location to drop the Marker for delivery."));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      bool isAdded = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaveAddressPage()),
                      );
                      if (isAdded) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _currentLocation,
        label: Text('My Location'),
        icon: Icon(Icons.location_on),
      ),*/
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17.0,
      ),
    ));
  }

  void _setMapToCurrentLocation() async {
    final GoogleMapController controller = await _controller;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              zoom: 15),
        ),
      );
      _handleTap(LatLng(currentLocation.latitude, currentLocation.longitude));
    } on Exception {
      currentLocation = null;
    }
  }

  _handleTap(LatLng point) {
    Provider.of<AddAddressProviderModel>(context, listen: false)
        .setMarkers(point);
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _currentPosition = await _location.getLocation();
    Provider.of<AddAddressProviderModel>(context, listen: false)
        .setCurrentLocation(_currentPosition);

    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 15),
      ),
    );

    // Later on may be we need
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   Provider.of<AddAddressProviderModel>(context, listen: false)
    //       .setCurrentLocation(_currentPosition);
    //   _getAddress(_currentPosition.latitude, _currentPosition.longitude)
    //       .then((value) {});
    // });
  }
}
