import 'package:flutter/material.dart';
import '../../elements/timeSlotWidget.dart';

class ScheduleTimePage extends StatelessWidget {
  const ScheduleTimePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back, Logo and Title
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            // Back, logo and Title
            child: Column(
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Image.asset(
                  "assets/img/hibachiBlueBird.png",
                  height: 65,
                ),
                // SizedBox(height: 20),
                //Schedule Delivery'
                Text(
                  'Schedule Delivery',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontFamily: 'Poppins',
                      fontSize: 29,
                      fontWeight: FontWeight.normal,
                      height: 1),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(child: TimeSlotWidget()),
        ],
      ),
    );
  }
}
