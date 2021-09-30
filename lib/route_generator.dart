import 'package:flutter/material.dart';
import 'src/pages/Anonymous/forgotPasswordScreen.dart';
import 'src/pages/Anonymous/singup.dart';
import 'src/pages/Anonymous/splash_screen.dart';
import 'src/pages/General/ProfilePage.dart';
import 'src/pages/General/mainAboutUsPage.dart';
import 'src/pages/General/settings.dart';
import 'src/pages/Products/product_list.dart';
import 'src/pages/Unused/give_rating.dart';
import 'src/pages/Unused/languages.dart';
import 'src/pages/Orders/myOrdersPage.dart';
import 'src/pages/Anonymous/login.dart';
import 'src/pages/HomePage/pages.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case '/':
        return MaterialPageRoute(builder: (_) => LoginWidget());

      case '/Login':
        return MaterialPageRoute(builder: (_) => LoginWidget());

      case '/Pages':
        return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      case '/Profile':
        return MaterialPageRoute(builder: (_) => ProfilePage());

      case '/ProductList':
        return MaterialPageRoute(builder: (_) => ProductList());
      case '/GiveRating':
        return MaterialPageRoute(builder: (_) => GiveRating());

      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());

      case '/Settings':
        return MaterialPageRoute(builder: (_) => SettingsWidget());
      case '/AboutUs':
        return MaterialPageRoute(builder: (_) => MainAboutUsPage());
      case '/ForgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/OrderListingPage':
        return MaterialPageRoute(builder: (_) => OrdersWidget());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: SafeArea(
                    child:
                        Center(child: Text('Route Error' + settings.name)))));
    }
  }
}
