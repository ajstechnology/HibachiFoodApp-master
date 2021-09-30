import 'package:flutter/material.dart';
import '../pages/Address/myAddressPages.dart';
import '../database/sharedPreference.dart';
import '../SendHttpCalls/Models/settingModel.dart';

ValueNotifier<SettingModel> setting = new ValueNotifier(new SettingModel());

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Profile');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 32,
                    color: Theme.of(context).accentColor.withOpacity(1),
                  ),
                  SizedBox(width: 30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loggedInUser.name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 4,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Pages', arguments: 2);
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAddressPage()),
              );
            },
            leading: Icon(
              Icons.map,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'My addresses',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Orders');
            },
            leading: Icon(
              Icons.panorama_wide_angle,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'My Orders',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/GiveRating');
            },
            leading: Icon(
              Icons.star,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Rating',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          ListTile(
            dense: true,
            title: Text(
              'Application Preferences',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Settings');
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Navigator.of(context).pushNamed('/Languages');
          //   },
          //   leading: Icon(
          //     Icons.translate,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     'Language',
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          // ),
          // ListTile(
          //   onTap: () {
          //     if (Theme.of(context).brightness == Brightness.dark) {
          //       // setBrightness(Brightness.light);
          //       setting.value.brightness.value = Brightness.light;
          //     } else {
          //       setting.value.brightness.value = Brightness.dark;

          //       //  setBrightness(Brightness.dark);
          //     }

          //     print(setting.value.brightness.value);
          //     // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          //     setting.notifyListeners();
          //   },
          //   leading: Icon(
          //     Icons.brightness_6,
          //     color: Theme.of(context).focusColor.withOpacity(1),
          //   ),
          //   title: Text(
          //     Theme.of(context).brightness == Brightness.dark
          //         ? 'Light Mode'
          //         : 'Dark Mode',
          //     style: Theme.of(context).textTheme.headline1,
          //   ),
          // ),

          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/AboutUs');
            },
            leading: Icon(
              Icons.contact_support,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              'About Us',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),

          loggedInUser != null
              ? ListTile(
                  onTap: () async {
                    if (await logOut() == true) {
                      Navigator.of(context).pushReplacementNamed('/Login');
                    } else {
                      print('Uable to logout');
                    }
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'Log out',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                )
              : ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Login');
                  },
                  leading: Icon(
                    Icons.login,
                    color: Theme.of(context).focusColor.withOpacity(1),
                  ),
                  title: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
          // ListTile(
          //   dense: true,
          //   title: Text(
          //     'Version 1.0',
          //     style: Theme.of(context).textTheme.bodyText2,
          //   ),
          //   trailing: Icon(
          //     Icons.remove,
          //     color: Theme.of(context).focusColor.withOpacity(0.3),
          //   ),
          // )
        ],
      ),
    );
  }
}
