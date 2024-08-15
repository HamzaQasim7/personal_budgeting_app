import 'package:flutter/material.dart';

extension ScreenSizeExtensions on BuildContext {
  // Get the width of the screen
  double get screenWidth => MediaQuery.of(this).size.width;

  // Get the height of the screen
  double get screenHeight => MediaQuery.of(this).size.height;

  // Get the height proportionally
  double heightProportion(double factor) => screenHeight * factor;

  // Get the width proportionally
  double widthProportion(double factor) => screenWidth * factor;

  // Get a SizedBox with a height proportionally
  SizedBox sizedBoxHeight(double factor) {
    return SizedBox(
      height: heightProportion(factor),
    );
  }

  // Get a SizedBox with a width proportionally
  SizedBox sizedBoxWidth(double factor) {
    return SizedBox(
      width: widthProportion(factor),
    );
  }
}
