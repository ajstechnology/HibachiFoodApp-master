import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markets/main.dart';
import 'package:markets/src/pages/Orders/myOrdersPage.dart';
import '../../StateManagement/ProviderModels/Notifications/notificationProviderModel.dart';
import 'package:provider/provider.dart';
import '../../elements/shoppingCartButtonWidget.dart';
import '../../elements/searchResultsWidget.dart';
import '../Favorite/favoritesPage.dart';
import '../../elements/drawerWidget.dart';
import '../../helpers/helper.dart';
import '../home.dart';
import '../Orders/checkoutpage.dart';
import '../Notifications/notificationsScreen.dart';

// ignore: must_be_immutable
class PagesWidget extends StatefulWidget {
  dynamic currentTab;

  Widget currentPage = HomeWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesWidget({
    Key key,
    this.currentTab,
  }) {
    currentTab = 2;
  }

  @override
  _PagesWidgetState createState() {
    return _PagesWidgetState();
  }
}

class _PagesWidgetState extends State<PagesWidget> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(PagesWidget oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = NotificationsScreen();
          break;
        case 1:
          widget.currentPage = SearchResultWidget();
          break;
        case 2:
          widget.currentPage =
              HomeWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 3:
          widget.currentPage = CheckoutPage(false);
          break;
        case 4:
          widget.currentPage = FavoritesWidget();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(notificationRoute != null){
        Get.to(() => OrdersWidget());
      }
    });
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                child: Image.asset('assets/img/hibachiBlueBird.png',
                    fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Hibachi'),
              ),
            ],
          ),
          actions: <Widget>[
            ShoppingCartButtonWidget(
                iconColor: Theme.of(context).hintColor,
                labelColor: Theme.of(context).accentColor),
          ],
        ),
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Consumer<NotificationProviderModel>(
                builder: (context, myModel, child) {
                  return Stack(
                    children: [
                      Icon(Icons.notifications),
                      myModel.getNotificationCount() == 0
                          ? Container(height: 0, width: 0)
                          : Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 12,
                                  minHeight: 12,
                                ),
                                child: Text(
                                  myModel.getNotificationCount().toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                    ],
                  );
                },
              ),
              // ignore: deprecated_member_use
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              // ignore: deprecated_member_use
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              // ignore: deprecated_member_use
              title: Container(height: 5.0),
              icon: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      blurRadius: 40,
                      offset: Offset(0, 15),
                    ),
                    BoxShadow(
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      blurRadius: 13,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Image.asset("assets/img/whiteLogo.png",
                    color: Theme.of(context).primaryColor),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              // ignore: deprecated_member_use
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              // ignore: deprecated_member_use
              title: Container(height: 0.0),
            ),
          ],
        ),
      ),
    );
  }
}
