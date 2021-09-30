import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../pages/widgets/loader.dart';
import '../pages/Payment/payment_option_page.dart';
import '../SendHttpCalls/Models/Orders/restaurantTimeSlotApiModel.dart';
import '../StateManagement/ProviderModels/scheduleDtProviderModel.dart';
import 'package:provider/provider.dart';

class TimeSlotWidget extends StatelessWidget {
  const TimeSlotWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleTimeProviderModel>(
      create: (_) => ScheduleTimeProviderModel(),
      child: Consumer<ScheduleTimeProviderModel>(
        builder: (context, myModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Month and Year
                Text(
                  DateFormat('MMMM yyyy').format(DateTime.now()),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(54, 54, 54, 1),
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                // 7 days List view
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: myModel.getDates().length,
                        itemBuilder: (context, index) {
                          var currentDate = myModel.getDates()[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(left: index == 0 ? 0 : 16.0),
                            child: GestureDetector(
                              onTap: () {
                                myModel.setSelectedIndex(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Colors.white,
                                  color: index == myModel.getSelectedIndex()
                                      // ? Colors.orange.shade900
                                      ? Theme.of(context).accentColor
                                      : Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width / 7,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        DateFormat('EEEE')
                                            .format(currentDate)
                                            .substring(0, 3),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: index ==
                                                    myModel.getSelectedIndex()
                                                ? Colors.white
                                                : Color.fromRGBO(54, 54, 54, 1),
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      DateFormat('d').format(currentDate),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: index ==
                                                  myModel.getSelectedIndex()
                                              ? Colors.white
                                              : Color.fromRGBO(54, 54, 54, 1),
                                          fontFamily: 'Roboto',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Available Time Slots
                Text(
                  'Available Time Slots',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(54, 54, 54, 1),
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                // Time Slot
                myModel.getTimeSlotLength() > 0
                    ? TimeSlotGridView(myModel.getTimeSlots(), myModel)
                    : FutureBuilder<List<TimeSlotsModel>>(
                        future:
                            myModel.getTimeSlotsFromApi(context), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TimeSlotsModel>> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: hibachiLoader,
                              );
                            default:
                              if (snapshot.hasError) {
                                return Text(
                                    'Error occur while downloading time slots.');
                              } else if (snapshot.data.length == 0) {
                                return Center(
                                  child: Text(
                                    'No time slots found.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .merge(TextStyle(letterSpacing: 1.3)),
                                  ),
                                );
                              } else {
                                return TimeSlotGridView(snapshot.data, myModel);
                              }
                          }
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
                // Confirm Button
                Center(
                  child: GestureDetector(
                    onTap: () {
                      String response = myModel.setDeliveryTime(context);
                      if (response == "Done") {
                        // Navigate to Payment.
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PaymentOptionPage(),
                          ),
                        );
                      } else {
                        SnackBar snackBar = new SnackBar(
                            content: Text(
                          response,
                          style: TextStyle(color: Colors.red),
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade600,
                                offset: Offset(0, 3),
                                blurRadius: 5),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'Confirm Schedule Delivery',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                height: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class TimeSlotGridView extends StatelessWidget {
  final List<TimeSlotsModel> list;
  final ScheduleTimeProviderModel myModel;
  const TimeSlotGridView(this.list, this.myModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        childAspectRatio: 9 / 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.symmetric(horizontal: 10),
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 2 : 4,
        children: List.generate(
          list.length,
          (index) {
            var item = list[index];
            return GestureDetector(
              onTap: () {
                myModel.setSelectedTimeSlot(item);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                decoration: BoxDecoration(
                  color: myModel.getSelectedTimeSlotId() == item.id
                      ? Theme.of(context).accentColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    Icon(Icons.timer),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.fromtimeslots +
                                " " +
                                item.fromampm +
                                " " +
                                item.totimeslote +
                                " " +
                                item.toampm,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                height: 1,
                                color:
                                    myModel.getSelectedTimeSlotId() == item.id
                                        ? Colors.white
                                        : Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
