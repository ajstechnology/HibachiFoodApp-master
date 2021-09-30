import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import '../widgets/custom_divider_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final double _initFabHeight = 170.0;
  double _fabHeight;
  double _panelHeightOpen;
  double _panelHeightClosed = 150.0;
  @override
  void initState() {
    super.initState();
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeLeft: true,
      removeRight: true,
      child: Container(
          color: Theme.of(context).primaryColor,
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
                child: GFAccordion(
                  title: 'Watch a netflix trailer while you food arrives',
                  textStyle: TextStyle(color: Colors.redAccent),
                  expandedTitleBackgroundColor: Theme.of(context).dividerColor,
                  collapsedTitleBackgroundColor: Theme.of(context).dividerColor,
                  contentBackgroundColor: Theme.of(context).dividerColor,
                  //contentPadding: EdgeInsets.only(left:0,right:0),

                  expandedIcon: Container(
                      child: Row(
                    children: [
                      Text('PLAY',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w900)),
                      SizedBox(width: 5),
                      Icon(Icons.play_circle_filled, color: Colors.red),
                    ],
                  )),
                  collapsedIcon: Container(
                      child: Row(
                    children: [
                      Text('PLAY',
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.w900)),
                      SizedBox(width: 5),
                      Icon(Icons.play_circle_filled, color: Colors.red),
                    ],
                  )),
                  contentChild: Column(
                    children: [
                      Container(
                          child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Icon(Icons.receipt),
                              ),
                              Container(
                                  height: 15,
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(3),
                                  child: Center(
                                      child: Text(
                                    'LIVE',
                                    style: TextStyle(
                                        fontSize: 7,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ))),
                            ],
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Text(
                                  'Order is Received',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          )),
                        ],
                      )),
                      SizedBox(height: 20),
                      Container(
                          child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Icon(Icons.receipt),
                              ),
                              Container(
                                  height: 15,
                                  color: Colors.blue,
                                  padding: EdgeInsets.all(3),
                                  child: Center(
                                      child: Text(
                                    'LIVE',
                                    style: TextStyle(
                                        fontSize: 7,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ))),
                            ],
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10),
                                child: Text(
                                  'Food is being prepared',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ],
                          )),
                        ],
                      )),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 18, right: 18, bottom: 18),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Icon(Icons.card_membership),
                          ),
                          Container(
                              height: 15,
                              color: Colors.blue,
                              padding: EdgeInsets.all(3),
                              child: Center(
                                  child: Text(
                                'LIVE',
                                style: TextStyle(
                                    fontSize: 7,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                              ))),
                        ],
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 30),
                            child: Text(
                              'Order Picked Up',
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Text(
                              'Pittsburgh is a city in the state of Pennsylvania in the United States, and is the county',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Image(
                          image: AssetImage(
                            'assets/img/userImage6.jpeg',
                          ),
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  )),
              CustomDividerView(dividerHeight: 15.0),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Bill Details',
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Item total',
                            style: Theme.of(context).textTheme.subtitle2),
                        Text('129.00',
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
                                  Text('54.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Your Delivery Partner is travelling long distance to deliver your order',
                                  style: Theme.of(context).textTheme.caption),
                              SizedBox(height: 10),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Delivery Tip',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                  Text('Add tip',
                                      style: TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Taxes and Charges',
                                      style: TextStyle(color: Colors.blue)),
                                  Text('54.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      height: 60.0,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'To Pay',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Spacer(),
                          Text(
                            '210.00',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .95;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        /**  leading: _con.currentMarket?.latitude == null
            ? new IconButton(
                icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
                onPressed: () => widget.parentScaffoldKey.currentState.openDrawer(),
              )
            : IconButton(
                icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
                onPressed: () => Navigator.of(context).pushNamed('/Pages', arguments: 2),
              ), */
        title: Text(
          'Maps Explorer',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              widget.parentScaffoldKey.currentState.openEndDrawer();
            },
          ),
        ],
      ),
      body: Stack(
//        fit: StackFit.expand,
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            panelBuilder: (sc) => _panel(sc),
            /**   body: _con.cameraPosition == null
                ? CircularLoadingWidget(height: 0)
                : GoogleMap(
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
              right: 20.0,
              bottom: _fabHeight,
              child: Container(
                  padding: EdgeInsets.all(5),
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black),
                  child: Column(
                    children: [
                      Text('foodd'),
                      SizedBox(height: 6),
                      Text('13 mins',
                          style: Theme.of(context).textTheme.subtitle2.merge(
                              TextStyle(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(3),
                          color: Theme.of(context).primaryColor,
                          width: 100,
                          child: Center(
                            child: Text(
                              'ON TIME',
                              style: Theme.of(context).textTheme.caption.merge(
                                  TextStyle(
                                      color:
                                          Theme.of(context).backgroundColor)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}
