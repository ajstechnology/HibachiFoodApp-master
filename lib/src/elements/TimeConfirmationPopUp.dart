import 'package:flutter/material.dart';
import '../StateManagement/ProviderModels/cartProviderModel.dart';
import 'package:provider/provider.dart';

class TimeConfirmationPopUp extends StatelessWidget {
  const TimeConfirmationPopUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProviderModel>(
      builder: (context, myModel, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: contentBox(context),
        );
      },
    );
  }

  Widget contentBox(context) {
    double avatarRadius = 60;
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: 10,
            top: avatarRadius,
            right: 10,
          ),
          margin: EdgeInsets.only(top: avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Just One more Step',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(27, 28, 32, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Select your type of Delivery !!!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(110, 140, 160, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  right: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "0");
                      },
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Demand Delivery',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(73, 80, 87, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Less than 2 hrs',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromRGBO(73, 80, 87, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    height: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      child: VerticalDivider(
                        thickness: 2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, "1");
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: Text(
                              'Schedule Delivery',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color.fromRGBO(67, 100, 247, 1),
                                  fontFamily: 'Montserrat',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  height: 1),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: avatarRadius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(avatarRadius)),
              child: Image.asset(
                'assets/img/hibachiBlueBird.png',
                height: 60.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
