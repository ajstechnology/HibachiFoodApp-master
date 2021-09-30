import 'package:flutter/material.dart';
import '../../StateManagement/ProviderModels/Anonymous/loginProviderModel.dart';
import '../widgets/loader.dart';
import '../../helpers/helper.dart';
import 'package:provider/provider.dart';
import '../../Animation/FadeAnimation.dart';

class LoginWidget extends StatelessWidget {
  final Map<String, dynamic> dish;

  LoginWidget({this.dish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: LayoutStarts(
        dish: dish,
      ),
    );
  }
}

class LayoutStarts extends StatelessWidget {
  final Map<String, dynamic> dish;

  LayoutStarts({this.dish});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarCarousel(),
        CustomBottomSheet(context: context, dish: dish),
      ],
    );
  }
}

class CarCarousel extends StatefulWidget {
  final Map<String, dynamic> dish;

  CarCarousel({this.dish});

  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // ignore: missing_required_param
          Image(
            image: AssetImage("assets/img/loginhibachibg.png"),
            height: 300,
            width: 550,
            fit: BoxFit.cover,
          ),
          Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 290,
                width: double.infinity,
                child: Container(
                  alignment: Alignment.topLeft,
                  height: 100,
                  /* background black light to dark gradient color */
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      begin: const Alignment(0.0, -1.0),
                      end: const Alignment(0.0, 0.6),
                      colors: <Color>[
                        const Color(0x8A000000).withOpacity(0.0),
                        const Color(0x8A000000).withOpacity(0.55),
                        const Color(0x8A000000).withOpacity(0.7),
                        const Color(0x8A000000).withOpacity(0.8),
                        const Color(0x8A000000).withOpacity(0.9),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 80.0, bottom: 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeAnimation(
                            1,
                            Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 40),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.3,
                            Text(
                              'Welcome to Hibachi Family',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

///////////////////
// ignore: must_be_immutable
class CustomBottomSheet extends StatefulWidget {
  BuildContext context;
  final Map<String, dynamic> dish;

  CustomBottomSheet({this.context, this.dish});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop;

  double minSheetTop = 30;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    double sheetTop = MediaQuery.of(widget.context).size.height * 0.33;
    double minSheetTop = 30;
    controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: animation.value,
      left: 0,
      child: GestureDetector(
        onTap: () {},
        child: SheetContainer(dish: widget.dish),
      ),
    );
  }
}

// ignore: must_be_immutable
class SheetContainer extends StatelessWidget {
  final Map<String, dynamic> dish;

  SheetContainer({this.dish});

  int checkedItem = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Container(
        padding: EdgeInsets.only(top: 25),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: ChangeNotifierProvider<LoginProviderModel>(
                        create: (_) => LoginProviderModel(),
                        child: Consumer<LoginProviderModel>(
                          builder: (context, loginProviderModel, child) {
                            return Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      // Username and Email
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextField(
                                          controller: loginProviderModel
                                              .getUserNameController(),
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Theme.of(context).dividerColor,
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17.0,
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Email / Mobile no',
                                            contentPadding:
                                                EdgeInsets.all(16.0),
                                            prefixIcon: Icon(
                                              Icons.perm_identity,
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(1),
                                            ),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                      SizedBox(height: 25.0),
                                      // Password
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: TextField(
                                          controller: loginProviderModel
                                              .getPasswordController(),
                                          style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Theme.of(context).dividerColor,
                                            hintStyle: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17.0,
                                            ),
                                            border: InputBorder.none,
                                            hintText: 'Password',
                                            contentPadding:
                                                EdgeInsets.all(16.0),
                                            prefixIcon: Icon(
                                              Icons.lock_outline,
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(1),
                                            ),
                                            suffixIcon: Icon(
                                              Icons.remove_red_eye,
                                              color: Theme.of(context)
                                                  .focusColor
                                                  .withOpacity(1),
                                            ),
                                          ),
                                          obscureText: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                FadeAnimation(
                                  1.5,
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/ForgotPassword');
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 25),
                                    shape: StadiumBorder(),
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(context).focusColor,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                loginProviderModel.isLoading
                                    ? Center(
                                        child: hibachiLoader,
                                      )
                                    : Column(
                                        children: [
                                          FlatButton(
                                            onPressed: () async {
                                              await loginProviderModel
                                                  .login(context);
                                              if (loginProviderModel.isLogin) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        '/Pages');
                                              }
                                            },
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 70),
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(1),
                                            shape: StadiumBorder(),
                                            child: Text(
                                              'Login',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .merge(TextStyle(
                                                      color: Theme.of(context)
                                                          .scaffoldBackgroundColor)),
                                            ),
                                          ),
                                          loginProviderModel.isLogin == false
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Center(
                                                    child: Text(
                                                      loginProviderModel
                                                          .errorMessage,
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                )
                                              : Container()
                                        ],
                                      ),
                                SizedBox(
                                  height: 25,
                                ),
                                FlatButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushNamed('/SignUp');
                                  },
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 70),
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    'Don\'t Have an Account?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .merge(TextStyle(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor)),
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
