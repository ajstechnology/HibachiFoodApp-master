import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/loader.dart';
import '../widgets/bezierContainer.dart';
import '../../StateManagement/ProviderModels/updatePasswordProviderModel.dart';
import 'package:provider/provider.dart';

class UpdateUserInfoPage extends StatelessWidget {
  final UpdatePasswordProviderModel myModel;
  UpdateUserInfoPage(this.myModel);

  Widget _submitButton(BuildContext context) {
    return Column(
      children: [
        myModel.isUpdating
            ? Center(child: hibachiLoader)
            : Column(
                children: [
                  myModel.errorMessage == ''
                      ? Container()
                      : Text(
                          myModel.errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                  RaisedButton(
                    onPressed: () async {
                      if (await myModel.updateMyInfoPassord()) {
                        Navigator.of(context).pushReplacementNamed('/Pages');
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
                          "Update",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline6.merge(
                              TextStyle(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _title() {
    return Image(
      image: AssetImage("assets/img/logo.png"),
      fit: BoxFit.cover,
      height: 100,
      width: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Update info")),
      ),
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<UpdatePasswordProviderModel>(
                builder: (context, myModel, child) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .21),
                        _title(),
                        SizedBox(height: height * .010),
                        Container(
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    controller: myModel.getNameController(),
                                    onSaved: (input) => input,
                                    validator: (input) => input.length < 3
                                        ? 'Should Be More Than 3 Characters'
                                        : null,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).dividerColor,
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
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    controller: myModel.getEmailController(),
                                    onSaved: (input) => input,
                                    validator: (input) => !input.contains('@')
                                        ? 'Invalid Email format'
                                        : null,
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
                                        )),
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: TextFormField(
                                    controller: myModel.getPasswordController(),
                                    onSaved: (input) => input,
                                    validator: (input) => input.length < 3
                                        ? 'Should Be More Than 3 Characters'
                                        : null,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Theme.of(context).dividerColor,
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
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * .04),
                        _submitButton(context),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
