import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'route_generator.dart';
import 'src/StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import 'src/StateManagement/ProviderModels/Notifications/notificationProviderModel.dart';
import 'src/StateManagement/ProviderModels/cartProviderModel.dart';
import 'src/StateManagement/ProviderModels/favoriteProductProviderModel.dart';
import 'src/database/sharedPreference.dart';
import 'src/elements/drawerWidget.dart';

String notificationRoute;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  Fluttertoast.showToast(
      msg: 'Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AddAddressProviderModel>(
          create: (_) => AddAddressProviderModel(),
        ),
        ChangeNotifierProvider<NotificationProviderModel>(
          create: (_) => NotificationProviderModel(),
        ),
        ChangeNotifierProvider<CartProviderModel>(
          create: (_) => CartProviderModel(),
        ),
        ChangeNotifierProvider<FavoriteProductProviderModel>(
          create: (_) => FavoriteProductProviderModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
//  /// Supply 'the Controller' for this application.
//  MyApp({Key key}) : super(con: Controller(), key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging;

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      userNotificationToken = value;
      log("Firebase generated push notification token = $value");
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print("getInitialMessage() " + message.toString());
        notificationRoute = "/OrderListingPage";
        /*Get.to(() => HomeWidget());
        Get.to(() => OrdersWidget());*/
        // Fluttertoast.showToast(msg: "getInitialMessage() " + message.toString(), toastLength: Toast.LENGTH_LONG);
      } else {
        // Fluttertoast.showToast(msg: "getInitialMessage() is null", toastLength: Toast.LENGTH_LONG);
        print("getInitialMessage() is null");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      if (notification != null) {
        // print("onMessage notification.title " +
        //         notification.title +
        //         " notification.body " +
        //         notification.body ??
        //     "Body is null");
        Provider.of<NotificationProviderModel>(context, listen: false)
            .setAddNotification();
      } else {
        print("onMessage but notification is null ");
        Provider.of<NotificationProviderModel>(context, listen: false)
            .setAddNotification();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      if (notification != null) {
        // print("onMessageOpenedApp notification.title " +
        //         notification.title +
        //         " notification.body " +
        //         notification.body ??
        //     "Body is null");
        Provider.of<NotificationProviderModel>(context, listen: false)
            .setAddNotification();
      } else {
        print("onMessage but notification is null ");
        Provider.of<NotificationProviderModel>(context, listen: false)
            .setAddNotification();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: setting,
      builder: (context, _setting, _) {
        return GetMaterialApp(
          navigatorKey: navigatorKey,
          title: 'Hibachi',
          initialRoute: '/Splash',
          // initialRoute: notificationRoute,
          onGenerateRoute: RouteGenerator.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: _setting.brightness.value == Brightness.light
              ? ThemeData(
                  fontFamily: 'proximanova-regular',
                  primaryColor: Colors.white,
                  disabledColor: Colors.grey,
                  cardColor: Colors.lightBlue[50],
                  // cardColor: Colors.red,
                  appBarTheme: AppBarTheme(
                    color: Colors.white,
                  ),
                  secondaryHeaderColor: Color(0xFF043832).withOpacity(1),
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                      elevation: 0, foregroundColor: Colors.white),
                  brightness: Brightness.light,
                  backgroundColor: Colors.black,
                  accentColor: Color(0xFFFc8019),
                  dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
                  focusColor: Color(0xFF8c98a8).withOpacity(1),
                  primaryColorDark: Color(0xFFFc8019),
                  textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 22.0,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.3),
                    headline4: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.3),
                    headline3: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.3),
                    headline2: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFc8019).withOpacity(1),
                        height: 1.4),
                    headline1: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.4),
                    subtitle1: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8c98a8).withOpacity(1),
                        height: 1.3),
                    subtitle2: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.2),
                    headline6: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFc8019).withOpacity(1),
                        height: 1.3),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8c98a8).withOpacity(1),
                        height: 1.2),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF043832).withOpacity(1),
                        height: 1.3),
                    caption: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF8c98a8).withOpacity(1),
                        height: 1.7),
                  ),
                )
              : ThemeData(
                  fontFamily: 'proximanova-regular',
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Color(0xFF2C2C2C),
                  appBarTheme: AppBarTheme(
                    color: Colors.white,
                  ),
                  accentColor: Color(0xFFFc8019),
                  backgroundColor: Colors.white.withOpacity(1),
                  dividerColor: Color(0xFF8c98a8).withOpacity(0.1),
                  hintColor: Color(0xFFcccdd).withOpacity(1),
                  focusColor: Colors.white.withOpacity(1),
                  textTheme: TextTheme(
                    headline5: TextStyle(
                        fontSize: 22.0,
                        color: Color(0xFFcccdd).withOpacity(1),
                        height: 1.3),
                    headline4: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(1),
                        height: 1.3),
                    headline3: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(1),
                        height: 1.3),
                    headline2: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.4),
                    headline1: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(1),
                        height: 1.4),
                    subtitle1: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(1),
                        height: 1.3),
                    subtitle2: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(1),
                        height: 1.2),
                    headline6: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(1),
                        height: 1.3),
                    bodyText2: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(1),
                        height: 1.2),
                    bodyText1: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(1),
                        height: 1.3),
                    caption: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.6),
                        height: 1.5),
                  ),
                ),
        );
      },
    );
  }
}
