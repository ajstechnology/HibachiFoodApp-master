import 'package:flutter/material.dart';
import '../widgets/loader.dart';
import '../../StateManagement/ProviderModels/forgotPasswordProviderModel.dart';
import 'package:provider/provider.dart';

import 'forgotPasswrodVerifyScreen.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordProviderModel>(
      create: (_) => ForgotPasswordProviderModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Consumer<ForgotPasswordProviderModel>(
            builder: (context, myModel, child) {
              return myModel.getIsLoading()
                  ? Center(
                      child: hibachiLoader,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email Your Email',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextField(
                          controller: myModel.getEmailController(),
                          style: TextStyle(fontSize: 17.0, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.mail,
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: myModel.getErrorMessage() != '',
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              myModel.getErrorMessage(),
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ),
                        ),
                        // Send Email
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              var response = await myModel.sendOtp();
                              if (response) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ForgotPasswrodVerifyScreen(
                                          myModel);
                                    },
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        offset: Offset(0, 3),
                                        blurRadius: 5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Send Email',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Login Button
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        offset: Offset(0, 3),
                                        blurRadius: 5),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
