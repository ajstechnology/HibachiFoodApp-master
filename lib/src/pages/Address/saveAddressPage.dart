import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../StateManagement/ProviderModels/Addresses/addAddressProviderModel.dart';
import '../widgets/loader.dart';
import 'package:provider/provider.dart';

class SaveAddressPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Widget _submitButton() {
    return Column(
      children: [
        Consumer<AddAddressProviderModel>(
          builder: (context, myModel, child) {
            return myModel.getIsLoading()
                ? Center(child: hibachiLoader)
                : Column(
                    children: [
                      myModel.getErrorMessage() == ''
                          ? Container()
                          : Text(
                              myModel.getErrorMessage(),
                              style: TextStyle(color: Colors.red, fontSize: 20),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await myModel.addAddressOfUser(context);
                            if (myModel.getIsUpdate()) {
                              Navigator.pop(context, true);
                            }
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
                            constraints: BoxConstraints(
                                maxWidth: 200.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Save",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .merge(TextStyle(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Add address")),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          child: Consumer<AddAddressProviderModel>(
            builder: (context, myModel, child) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            //Address
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.addressController,
                                onSaved: (input) => input,
                                validator: (input) {
                                  var val = input.trim();
                                  if (val.length < 3) {
                                    return 'Should Be More Than 3 Characters';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Address',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            //House
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.houseController,
                                onSaved: (input) => input,
                                validator: (input) {
                                  var val = input.trim();
                                  if (val.length < 3) {
                                    return 'Invalid house no should be greater then 2.';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'House',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            SizedBox(height: 25.0),
                            //landmark
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.landmarkController,
                                onSaved: (input) => input,
                                validator: (input) {
                                  var val = input.trim();
                                  if (val.length < 3) {
                                    return 'Invalid landmark, no should be greater then 2.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Landmark',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            //Door No
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.doorNoController,
                                onSaved: (input) => input,
                                validator: (input) {
                                  var val = input.trim();
                                  if (val.length < 1) {
                                    return 'Door no is required.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Door No',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            //Arrival Comment
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.arrivalCommentController,
                                onSaved: (input) => input,
                                validator: (input) {
                                  var val = input.trim();
                                  if (val.length < 1) {
                                    return 'Arrival comment is required.';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Arrival comments',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                            //Tag
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                controller: myModel.tagController,
                                onSaved: (input) => input,
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(context).dividerColor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Tag',
                                  contentPadding: EdgeInsets.all(16.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    _submitButton(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
