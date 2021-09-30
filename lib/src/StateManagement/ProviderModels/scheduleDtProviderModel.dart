import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../SendHttpCalls/timeSlotApi.dart';
import 'cartProviderModel.dart';
import 'package:provider/provider.dart';
import '../../SendHttpCalls/Models/Orders/restaurantTimeSlotApiModel.dart';

class ScheduleTimeProviderModel extends ChangeNotifier {
  List<DateTime> _dateTimeList = [];
  int _selectedDateIndex = -1;

  List<TimeSlotsModel> _timeslotes = [];
  TimeSlotsModel _selectedTimeSlot;

  List<DateTime> getDates() {
    _dateTimeList = [];
    var todayDate = DateTime.now();
    for (var i = 0; i < 7; i++) {
      _dateTimeList.add(todayDate);
      todayDate = todayDate.add(const Duration(days: 1));
    }
    return _dateTimeList;
  }

  List<TimeSlotsModel> getTimeSlots() => _timeslotes;

  int getTimeSlotLength() => _timeslotes.length;

  int getSelectedIndex() => _selectedDateIndex;

  setSelectedIndex(int index) {
    _selectedDateIndex = index;
    notifyListeners();
  }

  clearDeliveryDateTime() {
    _selectedDateIndex = 0;
    _selectedTimeSlot = null;
    notifyListeners();
  }

  String getSelectedTimeSlotId() {
    if (_selectedTimeSlot == null) {
      return "";
    }
    return _selectedTimeSlot.id;
  }

  setSelectedTimeSlot(TimeSlotsModel timeSlotsModel) {
    _selectedTimeSlot = timeSlotsModel;
    notifyListeners();
  }

  Future<List<TimeSlotsModel>> getTimeSlotsFromApi(BuildContext context) async {
    if (_timeslotes.length == 0) {
      try {
        var cartProviderModel =
            Provider.of<CartProviderModel>(context, listen: false);
        print('ResturantId ' +
            cartProviderModel.mycart.first.resturantId.toString());
        _timeslotes = await getResturantTimeSlotFromServer(
            cartProviderModel.mycart.first.resturantId.toString());
      } catch (ex) {
        print("getTimeSlotsFromApi()" + ex.toString());
      }
    }
    return _timeslotes;
  }

  String setDeliveryTime(BuildContext context) {
    if (_selectedDateIndex == -1) {
      return "Please select the date";
    } else if (_selectedTimeSlot == null) {
      return "Please select time slot";
    }
    var cartProviderModel =
        Provider.of<CartProviderModel>(context, listen: false);
    var selectedTime = _selectedTimeSlot.fromtimeslots +
        " " +
        _selectedTimeSlot.fromampm +
        " " +
        _selectedTimeSlot.totimeslote +
        " " +
        _selectedTimeSlot.toampm;
    cartProviderModel.setDeliveryDateTime(
        DateFormat('dd-MM-yyyy').format(_dateTimeList[_selectedDateIndex]),
        selectedTime);

    return "Done";
  }
}
