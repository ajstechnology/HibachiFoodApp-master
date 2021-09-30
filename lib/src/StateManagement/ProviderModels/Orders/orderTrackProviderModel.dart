import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../SendHttpCalls/Models/Orders/driverDetailsModel.dart';
import '../../../SendHttpCalls/Models/Orders/orderAPIModel.dart';
import '../../../SendHttpCalls/ordersAPIs.dart';

class OrderTrackingProviderModel extends ChangeNotifier {
  @override
  void dispose() {
    timer.cancel();
    _polylines = {};
    _polylineCoordinates = [];
    _markers = {};
    _destinationPlacemark = null;
    super.dispose();
  }

  OrdersAPIModel _currentOrder;

  Set<Marker> _markers = Set<Marker>();
  LatLng _driverPlaceMark = LatLng(28.6466773, 76.813073);
  LatLng _destinationPlacemark;
  GoogleMapController _controller;

  Set<Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];
  String googleAPiKey = "AIzaSyBIcDnHDcIQwSMK-LoRzkKJLDQFWzegudE";
  DriverDetailsModel driverDetailsModel;

  Timer timer;

  OrderTrackingProviderModel(OrdersAPIModel orderModel) {
    _currentOrder = orderModel;
    if (_currentOrder.customerLat != null) {
      _getDriverLocation(false);
    } else {
      _polylines = {};
      _polylineCoordinates = [];
      _markers = {};
    }
    _startTimer();
  }

  _startTimer() {
    timer = Timer.periodic(
        Duration(seconds: 10), (Timer t) => _getDriverLocation(true));
  }

  Set<Polyline> getPolylines() => _polylines;

  onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
  }

  Set<Marker> getMarkers() => _markers;

  GoogleMapController getMapController() => _controller;

  LatLng getCameraPosition() {
    return _driverPlaceMark;
  }

  _getPolyline() async {
    PolylinePoints _polylinePoints = PolylinePoints();
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_driverPlaceMark.latitude, _driverPlaceMark.longitude),
      PointLatLng(
          _destinationPlacemark.latitude, _destinationPlacemark.longitude),
      travelMode: TravelMode.driving,
    );
    _polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    _polylines = {};
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: _polylineCoordinates);
    _polylines.add(polyline);
    notifyListeners();
  }

  // get the driver location from Server
  _getDriverLocation(bool isAnimateCamera) async {
    print("_getDriverLocation() called");
    try {
      if (_currentOrder.customerLat != null &&
          _currentOrder.customerLat != "" &&
          _currentOrder.customerLat != "null") {
        _destinationPlacemark = LatLng(double.parse(_currentOrder.customerLat),
            double.parse(_currentOrder.customerLon));
      } else {
        _destinationPlacemark = LatLng(28.6466773, 76.813073);
      }

      if (_currentOrder.driverId != null || _currentOrder.driverId == "") {
        driverDetailsModel = await getDriverLocationFromAPI(
            _currentOrder.driverId, _currentOrder.id.toString());

        if (driverDetailsModel != null) {
          if (driverDetailsModel.deliveryLat != null &&
              driverDetailsModel.deliveryLat != "" &&
              driverDetailsModel.deliveryLong != null &&
              driverDetailsModel.deliveryLong != "") {
            _driverPlaceMark = LatLng(
                double.parse(driverDetailsModel.deliveryLat),
                double.parse(driverDetailsModel.deliveryLong));
            _setMarkers(isAnimateCamera);
          }
        }
      }
    } catch (ex) {
      print("_getDriverLocation()" + ex.toString());
    }
  }

  _setMarkers(bool isAnimateCamera) {
    _markers.clear();
    _destinationPlacemark =
        LatLng(_destinationPlacemark.latitude, _destinationPlacemark.longitude);
    _markers.add(
      Marker(
        markerId: MarkerId(_driverPlaceMark.toString()),
        position: _driverPlaceMark,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ),
    );
    _markers.add(
      Marker(
        markerId: MarkerId(_destinationPlacemark.toString()),
        position: _destinationPlacemark,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ),
    );

    double miny = (_driverPlaceMark.latitude <= _destinationPlacemark.latitude)
        ? _driverPlaceMark.latitude
        : _destinationPlacemark.latitude;
    double minx =
        (_driverPlaceMark.longitude <= _destinationPlacemark.longitude)
            ? _driverPlaceMark.longitude
            : _destinationPlacemark.longitude;
    double maxy = (_driverPlaceMark.latitude <= _destinationPlacemark.latitude)
        ? _destinationPlacemark.latitude
        : _driverPlaceMark.latitude;
    double maxx =
        (_driverPlaceMark.longitude <= _destinationPlacemark.longitude)
            ? _destinationPlacemark.longitude
            : _driverPlaceMark.longitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

    if (isAnimateCamera) {
      _controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );
    }
    notifyListeners();
    _getPolyline();
  }
}
