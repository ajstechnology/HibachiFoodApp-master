import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../StateManagement/ProviderModels/Anonymous/signUpProviderModel.dart';
import '../widgets/bezierContainer.dart';
import 'package:provider/provider.dart';
import '../../Animation/FadeAnimation.dart';
import 'otp_verification.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0, top: 20.0, bottom: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeAnimation(
                    0.01,
                    Text(
                      'Register',
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                    0.01,
                    Text(
                      'Hibachi Welcomes You !!!',
                      style: TextStyle(fontSize: 18),
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

  Widget _submitButton(SignUpProviderModel myModel) {
    return Container(
      child: myModel.getIsLoading()
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                myModel.getIsRegister() == false
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          myModel.getErrorMessage(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      )
                    : Container(),
                RaisedButton(
                  onPressed: () async {
                    await myModel.registor();
                    if (myModel.getIsRegister()) {
                      String mobileNo = myModel.getMobileNoController().text;
                      String email = myModel.getEmailController().text;

                      Fluttertoast.showToast(
                          msg: "You are successfully registered.");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return OtpVerification(mobileNo, email);
                          },
                        ),
                      );
                    }
                  },
                  shape: StadiumBorder(),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFFc8019), Color(0xFFFc8019)],
                          begin: Alignment(-2.0, -2.0),
                          end: Alignment(1.0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.merge(
                            TextStyle(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _logo() {
    return Image(
      image: AssetImage("assets/img/hibachiBlueBird.png"),
      fit: BoxFit.cover,
      height: 100,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpProviderModel>(
      create: (_) => SignUpProviderModel(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -MediaQuery.of(context).size.height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 80),
                      _backButton(),
                      SizedBox(height: 20),
                      _logo(),
                      SizedBox(height: 10),
                      Consumer<SignUpProviderModel>(
                        builder: (context, signUpProviderModel, child) {
                          return Container(
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  // Username
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: signUpProviderModel
                                          .getUserNameController(),
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Name',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.perm_identity,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(1),
                                        ),
                                      ),
                                      keyboardType: TextInputType.name,
                                      maxLength: 50,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  //email
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: signUpProviderModel
                                          .getEmailController(),
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                      onSaved: (input) => input,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Email',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(1),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      maxLength: 50,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  // Mobile no
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: signUpProviderModel
                                          .getMobileNoController(),
                                      onChanged: (val) {
                                        if (val == "") {
                                          signUpProviderModel.resetMobileText();
                                        }
                                      },
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                      onSaved: (input) => input,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 15,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Mobile',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.phone_android,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  // password
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextFormField(
                                      controller: signUpProviderModel
                                          .getPasswordController(),
                                      style: TextStyle(
                                          fontSize: 17.0, color: Colors.black),
                                      onSaved: (input) => input,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      maxLength: 50,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Submit button
                                  _submitButton(signUpProviderModel),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // Sign up link
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacementNamed('/Login');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
