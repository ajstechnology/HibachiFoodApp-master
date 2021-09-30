import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/loader.dart';
import '../../StateManagement/ProviderModels/updatePasswordProviderModel.dart';

class UpdatePasswordPage extends StatelessWidget {
  final UpdatePasswordProviderModel myModel;
  UpdatePasswordPage(this.myModel);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Update Password',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Center(
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
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextField(
                                      controller:
                                          myModel.getPasswordController(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.password,
                                          color: Theme.of(context)
                                              .focusColor
                                              .withOpacity(1),
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
                                    ),
                                  ),
                                  SizedBox(height: 25.0),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: TextField(
                                      controller:
                                          myModel.getRePasswordController(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Theme.of(context).dividerColor,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13.0,
                                        ),
                                        border: InputBorder.none,
                                        hintText: 'Re-Password',
                                        contentPadding: EdgeInsets.all(16.0),
                                        prefixIcon: Icon(
                                          Icons.password,
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
                            myModel.isUpdating
                                ? Center(
                                    child: hibachiLoader,
                                  )
                                : Column(
                                    children: [
                                      FlatButton(
                                        onPressed: () async {
                                          if (await myModel
                                              .updateMyPassword()) {
                                            Navigator.of(context)
                                                .pushReplacementNamed('/Pages');
                                          }
                                        },
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 70),
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(1),
                                        shape: StadiumBorder(),
                                        child: Text(
                                          'Update Password',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .merge(
                                                TextStyle(
                                                    color: Theme.of(context)
                                                        .scaffoldBackgroundColor),
                                              ),
                                        ),
                                      ),
                                      myModel.isUpdate == false
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Center(
                                                child: Text(
                                                  myModel.errorMessage,
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
