import 'package:flutter/material.dart';
import '../widgets/custom_divider_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapLiveWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapLiveWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MapLiveWidgetState createState() => _MapLiveWidgetState();
}

class _MapLiveWidgetState extends State<MapLiveWidget> {
  final double _initFabHeight = 170.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 150.0;
  @override
  void initState() {
    _fabHeight = _initFabHeight;

    super.initState();
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.0,),
            */
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Icon(Icons.fiber_manual_record,
                              color: Theme.of(context).accentColor)),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Pickup',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                              Text('My Current Location',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.subtitle2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey[200]))),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Icon(Icons.location_on, color: Colors.pink)),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Drop-off',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ),
                              Text('105, Chicago, United States',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.subtitle2),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Padding(
                            padding: EdgeInsets.only(top: 18),
                            child: Row(
                              children: [
                                Icon(Icons.search),
                                SizedBox(width: 10),
                                Icon(Icons.map, color: Colors.blue),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomDividerView(dividerHeight: 15.0),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text('POPULAR LOCATIONS',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Icon(Icons.location_on, color: Colors.pink)),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('University of Wasington',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w300))),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Icon(Icons.star_border)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey[200]))),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: Icon(Icons.location_on, color: Colors.pink)),
                    ]),
                  ),
                  SizedBox(width: 8),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('University of Wasington',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .merge(TextStyle(
                                            fontWeight: FontWeight.w300))),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Icon(Icons.star_border)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.grey[200]))),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .80;
    return Scaffold(
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            panelBuilder: (sc) => _panel(sc),
            /**  body:  GoogleMap(
                    mapToolbarEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: _con.cameraPosition,
                    markers: Set.from(_con.allMarkers),
                    onMapCreated: (GoogleMapController controller) {
                      _con.mapController.complete(controller);
                    },
                    onCameraMove: (CameraPosition cameraPosition) {
                      _con.cameraPosition = cameraPosition;
                    },
                    onCameraIdle: () {
                      _con.getMarketsOfArea();
                    },
                    polylines: _con.polylines,
                  ), */
            onPanelSlide: (double pos) => setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
            }),
          ),
          Positioned(
              top: 40.0,
              left: 15,
              child: SafeArea(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  elevation: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(2),
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/img/userImage7.jpeg',
                      ),
                    ),
                  ),
                ),
              )),
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              elevation: 6,
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).backgroundColor,
              ),
              onPressed: () {},
              backgroundColor: Colors.white,
            ),
          ),

          /*Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Colors.blue,
              ),
              onPressed: (){},
              backgroundColor: Colors.white,
            ),
          ),*/
        ],
      ),
    );
  }
}
