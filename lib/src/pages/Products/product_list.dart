import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  int dropDownValue = 0;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 300,
              color: Color(0xff737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RadioButtonPart(),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Container(
              height: MediaQuery.of(context).size.width * 0.15,
              color: Colors.transparent,
              child: Center(
                child: Card(
                  elevation: 5,
                  shape: StadiumBorder(),
                  color: Colors.blueAccent,
                  child: FlatButton(
                      onPressed: () {
                        showModal();
                      },
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                      color: Colors.blueAccent,
                      shape: StadiumBorder(),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.local_dining,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              size: 17,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            'BROWSE MENU',
                            style: Theme.of(context).textTheme.caption.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      )),
                ),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      /*floatingActionButton: FloatingActionButton(

        onPressed:(){},

        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

       */
      bottomNavigationBar: new Container(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 6,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Wrap(children: [
                        Text('1 item',
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text('|',
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Text('50',
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor))),
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Wrap(alignment: WrapAlignment.end, children: [
                        Text('VIEW CART',
                            style: Theme.of(context).textTheme.subtitle2.merge(
                                TextStyle(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor))),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Icon(Icons.local_mall,
                            size: 17,
                            color: Theme.of(context).scaffoldBackgroundColor)
                      ]),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 27.0),
              /*child:ListTile(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {},
                ),
                title:Text('Order Confirmation',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style:Theme.of(context)
                      .textTheme
                      .headline4
                      .merge(TextStyle(color: Theme.of(context).scaffoldBackgroundColor)
                  ),

                ),
                trailing:  IconButton(
                  icon: Icon(Icons.add),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  onPressed: () {},
                ),
                onTap: () {

                },
              ),*/
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      color: Theme.of(context).backgroundColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      'Product List',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: 6,
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.only(top: 16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10),
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Colors.grey[200])),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 10),
                                            Wrap(children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  shape: BoxShape.circle,
                                                ),
                                                width: 10.0,
                                                height: 10.0,
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Icon(Icons.star,
                                                    color: Colors.orange,
                                                    size: 17),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              Text(
                                                'Best Seller',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .merge(TextStyle(
                                                        color: Colors.orange,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                              ),
                                            ]),
                                            Text('Ice Creame land Classic',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1),
                                            SizedBox(height: 10),
                                            Wrap(
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 0),
                                                    child: Text('719',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption),
                                                  ),
                                                ]),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8, top: 6),
                                              child: Container(
                                                child: Text('2 Pcs',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(children: [
                                      Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: Image.asset(
                                                'assets/img/facial.jpg',
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                          /*Container(
                                                  width:100,
                                                  height:30,
                                                  color:Colors.yellow
                                                ),*/
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                padding: EdgeInsets.all(3),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 1,
                                                      blurRadius: 7,
                                                      offset: Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                /*child:Text('ADD',
                                                    textAlign: TextAlign.center,
                                                    style:Theme.of(context).textTheme.headline6
                                                    ),

                                                     */
                                                child: Wrap(
                                                    alignment:
                                                        WrapAlignment.center,
                                                    children: [
                                                      Icon(Icons.remove,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Text('2',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1
                                                                .merge(TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor))),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.022,
                                                      ),
                                                      Icon(Icons.add,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class RadioButtonPart extends StatefulWidget {
  @override
  _RadioButtonPartState createState() => _RadioButtonPartState();
}

class _RadioButtonPartState extends State<RadioButtonPart> {
  // Declare this variable
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.rectangle,
            border: Border(
                bottom: BorderSide(
              color: Colors.grey[200],
              width: 1,
            ))),
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Grilled Chicken Peppers Fry',
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.left,
              ),
            )),
      ),
      SizedBox(height: 10),
      Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                '* Quantity',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.left,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.brown,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    shape: BoxShape.circle,
                  ),
                  width: 6.0,
                  height: 6.0,
                ),
              ),
              Radio(
                  value: 1,
                  groupValue: selectedRadio,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    print("Radio val");
                    setSelectedRadio(val);
                  }),
              new RichText(
                text: new TextSpan(
                    text: 'Half',
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      new TextSpan(
                        text: '      0',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ]),
              ),
            ]),
            SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.brown,
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 0),
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    shape: BoxShape.circle,
                  ),
                  width: 6.0,
                  height: 6.0,
                ),
              ),
              Radio(
                  value: 2,
                  groupValue: selectedRadio,
                  activeColor: Colors.blue,
                  onChanged: (val) {
                    print("Radio $val");
                    setSelectedRadio(val);
                  }),
              new RichText(
                text: new TextSpan(
                    text: 'Full',
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      new TextSpan(
                        text: '      719',
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ]),
              ),
            ]),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey[200],
                width: 1,
              ))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 5, bottom: 5),
              child: Text(
                'Half',
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.left,
              ),
            ),
          ])),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
        child: Container(
          child: FlatButton(
            onPressed: () {
              /*Navigator.of(context).pushNamed('/Login');*/
            },
            padding: EdgeInsets.all(15),
            color: Theme.of(context).accentColor.withOpacity(1),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: new RichText(
                      text: new TextSpan(
                          text: 'Item Total',
                          style: Theme.of(context).textTheme.bodyText1.merge(
                              TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                          children: [
                            new TextSpan(
                              text: ' 719',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .merge(TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor)),
                            )
                          ]),
                    ),
                  ),
                  Container(
                      child: Text(
                    'ADD ITEM',
                    style: Theme.of(context).textTheme.bodyText1.merge(
                        TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor)),
                  )),
                ]),
          ),
        ),
      ),
    ]);
  }
}
