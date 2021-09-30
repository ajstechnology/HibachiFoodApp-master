import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markets/src/SendHttpCalls/Models/user_info_model.dart';
import 'package:markets/src/SendHttpCalls/api.dart';
import 'package:markets/src/helpers/app_permission_handler.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'update_password.dart';
import '../../StateManagement/ProviderModels/updatePasswordProviderModel.dart';
import 'package:provider/provider.dart';
import 'updateUserInfo.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../database/sharedPreference.dart';
import 'package:getwidget/getwidget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _picker = ImagePicker();
  ValueNotifier vnProfileImagePath = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
  }

  getUserProfileInfo() async {
    try {
      Helper.showLoadingDialog();
      UserInfoModel model = await Api.getUserData();
      log("User avatar = ${model.data.avatar}");
      vnProfileImagePath.value = model.data.avatar;
    } finally {
      Helper.hideLoadingDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserProfileInfo();
    });
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              child: Stack(
                children: <Widget>[
                  // Container on back color
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          color: Colors.transparent,
                          child: ClipPath(
                            clipper: BackClipper(),
                            child: Container(
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ChangeNotifierProvider<UpdatePasswordProviderModel>(
                    create: (_) => UpdatePasswordProviderModel(),
                    child: // Screen UI
                        Container(
                      child: Consumer<UpdatePasswordProviderModel>(
                        builder: (context, myModel, child) {
                          Uint8List myProfilePicture =
                              myModel.getMyProfilePicture();
                          return Column(
                            children: <Widget>[
                              // Profile Image

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 90.0,
                                    width: 90.0,
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(100.0)),
                                    child: ValueListenableBuilder(
                                      valueListenable: vnProfileImagePath,
                                      builder: (context, value, child) => CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: vnProfileImagePath.value == null
                                            ? AssetImage(
                                            'assets/img/userImage5.png')
                                            : NetworkImage("${vnProfileImagePath.value}"),
                                        // : MemoryImage(myProfilePicture),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (await AppPermissionHandler.checkAndRequestPermission(Permission.storage)) {
                                        PickedFile pickedFile =
                                            await showModalBottomSheet<PickedFile>(
                                                context: context,
                                                isDismissible: false,
                                                builder: (BuildContext bc) {
                                                  return _showPicker(context);
                                                });
                                        if (pickedFile == null) {
                                          print("Image Not selected");
                                        } else {
                                          await myModel
                                              .updateMyProfile(pickedFile, loggedInUser.id.toString());
                                        }
                                      }
                                    },
                                    icon: Icon(Icons.edit),
                                    color: Colors.orange,
                                    iconSize: 30,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 5.0,
                              ),
                              //name, updateprofile and Logout button
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        loggedInUser.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .merge(TextStyle(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor)),
                                      ),
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return UpdateUserInfoPage(
                                                      myModel);
                                                },
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Update",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            if (await logOut() == true) {
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/Login');
                                            } else {
                                              print('Uable to logout');
                                            }
                                          },
                                          child: Container(
                                            width: 90.0,
                                            height: 45.0,
                                            child: Center(
                                              child: Icon(
                                                Icons.power_settings_new,
                                                size: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              //Email and phone no
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Email',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  .merge(
                                                    TextStyle(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor),
                                                  ),
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(loggedInUser.email,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .merge(
                                                    TextStyle(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor),
                                                  ),
                                              textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 1.0,
                                      height: 40.0,
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text('Phone',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  .merge(
                                                    TextStyle(
                                                        color: Theme.of(context)
                                                            .scaffoldBackgroundColor),
                                                  ),
                                              textAlign: TextAlign.center),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            loggedInUser.phone,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .merge(
                                                  TextStyle(
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor),
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              //Change password, invite friends, My orders, Support Number, Hibachi Wallet, Setting
                              ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return UpdatePasswordPage(myModel);
                                          },
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Change password',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Icon(
                                            Icons.lock,
                                            color: Colors.grey,
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Share.share(
                                          'https://hibachi.ravinboss.co.in/stores/hibachi-ejUaeyAlGVe6vdG/1');
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Invite Friends',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Icon(Icons.folder_shared,
                                              color: Colors.grey)
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed('/Orders');
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'My Orders',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Icon(Icons.card_giftcard,
                                              color: Colors.grey)
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Support Number',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              _makePhoneCall(
                                                  'tel:+919492363303');
                                            },
                                            child: Icon(
                                              Icons.call,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              var whatsappUrl =
                                                  "whatsapp://send?phone=+91 94923 63303";
                                              await canLaunch(whatsappUrl)
                                                  ? launch(whatsappUrl)
                                                  : print(
                                                      "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                                            },
                                            child: Image.asset(
                                              'assets/img/whatsappIcon.png',
                                              height: 40,
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GFAccordion(
                                    titlePadding: EdgeInsets.all(0),
                                    // collapsedIcon: Container(),
                                    // expandedIcon: Container(),
                                    titleChild: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 17),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Hibachi Wallet',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                      // child: Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceBetween,
                                      //   children: <Widget>[
                                      //     Text(
                                      //       'Hibachi Wallet',
                                      //       style:
                                      //           Theme.of(context).textTheme.headline1,
                                      //     ),
                                      //     // Icon(Icons.payment, color: Colors.grey)
                                      //   ],
                                      // ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                    contentChild: Container(
                                      // height: 20,
                                      // color: Colors.green,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            'assets/img/wallet.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                          // Icon(Icons.payment,size: 35,),
                                          Container(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // ${loggedInUser.walletBalance}
                                              Text(
                                                '₹${loggedInUser.walletBalance}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                'Low Balance',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            '>',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 22),
                                          ),
                                          Container(
                                            width: 12,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            color: Colors.grey[400],
                                            width: 2,
                                          ),
                                          Container(
                                            width: 12,
                                          ),
                                          OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              primary: Colors.teal,
                                              padding: EdgeInsets.all(12),
                                              side: BorderSide(
                                                  color: Colors.green,
                                                  width: 1),
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            child: Text('+Add Money'),
                                            onPressed: () {
                                              print('Pressed');
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  // InkWell(
                                  //   onTap: () {},
                                  //   child: Container(
                                  //     padding: EdgeInsets.symmetric(horizontal: 25),
                                  //     height:
                                  //         MediaQuery.of(context).size.height * 0.07,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: <Widget>[
                                  //         Text(
                                  //           'Hibachi Wallet',
                                  //           style:
                                  //               Theme.of(context).textTheme.headline1,
                                  //         ),
                                  //         Icon(Icons.payment, color: Colors.grey)
                                  //       ],
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       border: Border(
                                  //         bottom: BorderSide(
                                  //           //                   <--- left side
                                  //           color: Colors.grey[200],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/Settings');
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Settings',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1,
                                          ),
                                          Icon(Icons.settings,
                                              color: Colors.grey)
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            //                   <--- left side
                                            color: Colors.grey[200],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showPicker(context) {
    return SafeArea(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () async {
                  Navigator.pop(context, null);
                },
                icon: Icon(Icons.close),
                color: Colors.orange,
                iconSize: 30,
              ),
            ),
            Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library, size: 25),
                    title: Text(
                      'Photo Library',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () async {
                      Navigator.pop(context, await _imgFromGallery());
                    }),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    size: 25,
                  ),
                  title: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                  onTap: () async {
                    Navigator.pop(context, await _imgFromCamera());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<PickedFile> _imgFromCamera() async {
    return await _picker.getImage(source: ImageSource.camera, imageQuality: 30);
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);
    // return await pickedFile.readAsBytes();
    // return base64.encode(await pickedFile.readAsBytes());
  }

  Future<PickedFile> _imgFromGallery() async {
    return await _picker.getImage(source: ImageSource.gallery, imageQuality: 30);
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    // return await pickedFile.readAsBytes();
    // return base64.encode(await pickedFile.readAsBytes());
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class BackClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - size.height / 5);

    var firstControlPoint = Offset(size.width / 2, size.height + 25);
    var firstEndPoint = Offset(size.width, size.height - size.height / 5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, 0.0);

    var secondControlPoint = Offset(size.width / 2, size.height / 5 + 25);
    var secondEndPoint = Offset(0.0, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
