import 'package:flutter/material.dart';

final String assetName = 'assets/animations/loading-animation.json';

/*final Widget hibachiLoader = Center(
  child: Lottie.asset(
    assetName,
    fit: BoxFit.fill,
  ),
);*/

final Widget hibachiLoader = Center(
  child: CircularProgressIndicator(),
);
