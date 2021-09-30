import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../../SendHttpCalls/Models/Address/addressInputModel.dart';
import '../../../SendHttpCalls/addressAPIs.dart';
import '../../../database/sharedPreference.dart';
import 'addressApiModel.dart';

class AddAddressProviderModel extends ChangeNotifier {
  bool _isUpdate;
  bool _isLoading = false;
  String _errorMessage = '';
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

  AddressApiModel addressForOrder;
  UserAddressInputModel _inputModel = UserAddressInputModel();
  Set<Marker> _markers = Set<Marker>();

  bool getIsLoading() => _isLoading;
  bool getIsUpdate() => _isUpdate;
  String getErrorMessage() => _errorMessage;
  TextEditingController addressController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController doorNoController = TextEditingController();
  TextEditingController arrivalCommentController = TextEditingController();
  TextEditingController tagController = TextEditingController();

  List<AddressApiModel> _userAddresses = [];
  List<AddressApiModel> getUserAddress() => _userAddresses;

  setCurrentLocation(LocationData currentPosition) {
    _inputModel.latitude = currentPosition.latitude;
    _inputModel.longitude = currentPosition.longitude;

    _initialcameraposition =
        LatLng(currentPosition.latitude, currentPosition.longitude);
    notifyListeners();
  }

  setAddressAndHouse(String address, String house) {
    addressController.text = address;
    houseController.text = house;
  }

  setMarkers(LatLng point) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ),
    );
    _inputModel.latitude = point.latitude;
    _inputModel.longitude = point.longitude;
    _initialcameraposition = LatLng(point.latitude, point.longitude);
    notifyListeners();
  }

  LatLng getCameraPosition() => _initialcameraposition;

  Set<Marker> getMarkers() => _markers;

  addAddressOfUser(BuildContext context) async {
    if (_inputModel.latitude == null) {
      _errorMessage = "Please select the location.";
      _isLoading = false;
      notifyListeners();
      return;
    }
    _inputModel.user_id = loggedInUser.id;
    _inputModel.address = addressController.text;
    _inputModel.house = houseController.text;
    _inputModel.landmark = landmarkController.text;
    _inputModel.doorNo = doorNoController.text;
    _inputModel.arrivalComment = arrivalCommentController.text;
    _inputModel.tag = tagController.text;

    _isLoading = true;
    notifyListeners();
    bool isAdded = await addUserAddres(_inputModel);

    if (!isAdded) {
      _isUpdate = false;
      _errorMessage = "Unable to save your address.";
    } else {
      await updateUserAddress(_inputModel);
      _isUpdate = true;
      _errorMessage = '';
      addressController.text = "";
      houseController.text = "";
      landmarkController.text = "";
      arrivalCommentController.text = "";
      doorNoController.text = "";
      houseController.text = "";
      tagController.text = "";
      _markers = Set<Marker>();
    }
    _isLoading = false;
    notifyListeners();
    await getUserAddressFromAPI(context);
  }

  addAddressOfUserUsingData(BuildContext context) async {
    if (_inputModel.latitude == null) {
      _errorMessage = "Please select the location.";
      _isLoading = false;
      notifyListeners();
      return;
    }
    _inputModel.user_id = loggedInUser.id;
    _inputModel.address = addressController.text;
    _inputModel.house = houseController.text;
    _inputModel.landmark = landmarkController.text;
    _inputModel.doorNo = doorNoController.text;
    _inputModel.arrivalComment = arrivalCommentController.text;
    _inputModel.tag = tagController.text;

    _isLoading = true;
    notifyListeners();
    bool isAdded = await addUserAddres(_inputModel);

    if (!isAdded) {
      _isUpdate = false;
      _errorMessage = "Unable to save your address.";
    } else {
      await updateUserAddress(_inputModel);
      _isUpdate = true;
      _errorMessage = '';
      addressController.text = "";
      houseController.text = "";
      landmarkController.text = "";
      arrivalCommentController.text = "";
      doorNoController.text = "";
      houseController.text = "";
      tagController.text = "";
      _markers = Set<Marker>();
    }
    _isLoading = false;
    notifyListeners();
    await getUserAddressFromAPI(context);
  }

  getUserAddressFromAPI(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    _userAddresses = await getUserAddresFromServer();

    if (_userAddresses.length > 0) {
      addressForOrder = _userAddresses.first;
    }
    _isLoading = false;
    notifyListeners();
  }

  updateAddress(AddressApiModel item) async {
    _userAddresses.remove(item);
    // to make it on top
    _userAddresses.insert(0, item);
    log("updateAddress - new address to update = ${item.toJson()}");
    addressForOrder = item;

    _inputModel.user_id = item.id;
    _inputModel.address = item.address;
    _inputModel.house = item.house;
    _inputModel.landmark = item.landmark;
    _inputModel.doorNo = item.doorNo;
    _inputModel.arrivalComment = item.arrivalComment;
    _inputModel.tag = item.tag;

    await addUserAddres(_inputModel);
    notifyListeners();
  }
}
