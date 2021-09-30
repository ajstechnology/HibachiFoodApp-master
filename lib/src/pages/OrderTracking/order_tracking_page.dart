import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../SendHttpCalls/Models/Orders/orderAPIModel.dart';
import '../../StateManagement/ProviderModels/Orders/orderTrackProviderModel.dart';
import 'package:provider/provider.dart';

class OrderTrackingPage extends StatelessWidget {
  final OrdersAPIModel orderModel;
  const OrderTrackingPage(this.orderModel, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OrderTrackingProviderModel>(
      create: (_) => OrderTrackingProviderModel(orderModel),
      child: Consumer<OrderTrackingProviderModel>(
        builder: (context, myModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Track your Order')),
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            floatingActionButton: getBottomSheet(myModel, context),
            body: Container(
              color: Colors.blueGrey.withOpacity(.8),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: myModel.getCameraPosition(), zoom: 15),
                mapType: MapType.normal,
                onMapCreated: myModel.onMapCreated,
                markers: myModel.getMarkers(),
                polylines: Set<Polyline>.of(myModel.getPolylines()),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getBottomSheet(
      OrderTrackingProviderModel myModel, BuildContext context) {
    return myModel.driverDetailsModel == null
        ? Container(
            height: 0,
          )
        : Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width - 70,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: new BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Delivery Guy Name - ' +
                              myModel.driverDetailsModel.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Vehicle No - ' +
                              myModel.driverDetailsModel.vehicleNumber,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Mobile - ' + myModel.driverDetailsModel.phone,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Delivery pin - ' +
                              myModel.driverDetailsModel.deliveryPin,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
