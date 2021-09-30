import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';

class Thankyou extends StatefulWidget {
  final String orderNo;
  Thankyou(this.orderNo);
  @override
  ThankyouState createState() => new ThankyouState();
}

class ThankyouState extends State<Thankyou>
    with SingleTickerProviderStateMixin {
  // AudioPlayer advancedPlayer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    //loadMusic();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 50, 8, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'THANK YOU',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20),
              child: Lottie.asset(
                'assets/animations/order-scussess.json',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.width - 100,
              ),
            ),
            Container(
              child: Text(
                'Your request is booked successfully with order no ' +
                    widget.orderNo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
