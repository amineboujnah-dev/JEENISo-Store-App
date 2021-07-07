import 'package:flutter/material.dart';

class SizeConfig {
  late MediaQueryData _mediaQueryData;
  late double _screenWidth;
  late double _screenHeight;
  //late Orientation _orientation;

  double get screenHeight => _screenHeight;

  double get screenWidth => _screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    //_orientation = _mediaQueryData.orientation;
  }

  double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }
}
