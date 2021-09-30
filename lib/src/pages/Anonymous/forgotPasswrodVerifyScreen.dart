import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class ForgotPasswrodVerifyScreen extends StatefulWidget {
  final myModel;
  ForgotPasswrodVerifyScreen(
    this.myModel, {
    Key key,
  }) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<ForgotPasswrodVerifyScreen>
    with TickerProviderStateMixin {
  AnimationController controller1;

  String timerString() {
    Duration duration = controller1.duration * controller1.value;
    String timer =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    if (timer == '0:00') {
      widget.myModel.setVerifyingIsPlaying(false);
    }
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    controller1.reverse(
        from: controller1.value == 0.0 ? 1.0 : controller1.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: widget.myModel.getIsLoading()
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.center,
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: controller1,
                                  builder:
                                      (BuildContext context, Widget child) {
                                    return CustomPaint(
                                        painter: TimerPainter(
                                      animation: controller1,
                                      backgroundColor: Colors.white,
                                      color: Theme.of(context).indicatorColor,
                                    ));
                                  },
                                ),
                              ),
                              Align(
                                alignment: FractionalOffset.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    AnimatedBuilder(
                                        animation: controller1,
                                        builder: (BuildContext context,
                                            Widget child) {
                                          return Text(
                                            timerString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          );
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text("OTP Verification",
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(height: 10.0),
                    Text("Enter the otp send to: " + widget.myModel.getEmail(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400])),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: OTPTextField(
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldWidth: 40,
                                  style: TextStyle(fontSize: 20),
                                  fieldStyle: FieldStyle.underline,
                                  onCompleted: (pin) {
                                    widget.myModel.setPin(pin);
                                  },
                                ),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // Password
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: widget.myModel.getPasswordController(),
                        style: TextStyle(fontSize: 17.0, color: Colors.black),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).dividerColor,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.0,
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          contentPadding: EdgeInsets.all(16.0),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Theme.of(context).focusColor.withOpacity(1),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Dont Recieve OTP? RESEND OTP
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: widget.myModel.getVerifyIsPlaying()
                          ? Container()
                          : GestureDetector(
                              onTap: () async {
                                await widget.myModel.sendOtp();
                                if (!widget.myModel.getIsLoading()) {
                                  widget.myModel.setVerifyingIsPlaying(true);
                                  if (controller1.isAnimating) {
                                    controller1.stop(canceled: true);
                                  } else {
                                    controller1.reverse(
                                        from: controller1.value == 0.0
                                            ? 1.0
                                            : controller1.value);
                                  }
                                }
                              },
                              child: Text(
                                "Don\'t Recieve OTP? RESEND OTP",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                    ),
                    SizedBox(height: 43.0),
                    // Verify Button
                    Column(
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            await widget.myModel.updatePassword();
                            if (widget.myModel.getVerified()) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/Login');
                            }
                          },
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFFc8019),
                                    Color(0xFFFc8019)
                                  ],
                                  begin: Alignment(-2.0, -2.0),
                                  end: Alignment(1.0, 1.0),
                                ),
                                borderRadius: BorderRadius.circular(30.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 200.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text("VERIFY",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .merge(TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor))),
                            ),
                          ),
                        ),
                        widget.myModel.getVerified() == false
                            ? Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Center(
                                  child: Text(
                                    widget.myModel.getErrorMessage(),
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                    SizedBox(height: 80.0),
                  ],
                ),
              ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
