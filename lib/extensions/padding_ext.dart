import 'package:flutter/material.dart';

extension PaddingExtensions on BuildContext {
  // Returns EdgeInsets with padding applied based on screen width and height
  EdgeInsets getPadding({
    double top = 0.0,
    double bottom = 0.0,
    double left = 0.0,
    double right = 0.0,
    double vertical = 0.0,
    double horizontal = 0.0,
  }) {
    final double screenWidth = MediaQuery.of(this).size.width;
    final double screenHeight = MediaQuery.of(this).size.height;

    return EdgeInsets.only(
      top: screenHeight * top + vertical,
      bottom: screenHeight * bottom + vertical,
      left: screenWidth * left + horizontal,
      right: screenWidth * right + horizontal,
    );
  }

  // Convenience methods for common padding scenarios
  EdgeInsets getPaddingTop(double factor) =>
      EdgeInsets.only(top: MediaQuery.of(this).size.height * factor);
  EdgeInsets getPaddingBottom(double factor) =>
      EdgeInsets.only(bottom: MediaQuery.of(this).size.height * factor);
  EdgeInsets getPaddingLeft(double factor) =>
      EdgeInsets.only(left: MediaQuery.of(this).size.width * factor);
  EdgeInsets getPaddingRight(double factor) =>
      EdgeInsets.only(right: MediaQuery.of(this).size.width * factor);
  EdgeInsets getPaddingAll(double factor) =>
      EdgeInsets.all(MediaQuery.of(this).size.width * factor);

  // Returns EdgeInsets with symmetric padding based on screen width and height
  EdgeInsets getPaddingSymmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  }) {
    final double screenWidth = MediaQuery.of(this).size.width;
    final double screenHeight = MediaQuery.of(this).size.height;

    return EdgeInsets.symmetric(
      vertical: screenHeight * vertical + vertical,
      horizontal: screenWidth * horizontal + horizontal,
    );
  }

  // Convenience methods for symmetric padding scenarios
  EdgeInsets getSymmetricPaddingVertical(double factor) =>
      EdgeInsets.symmetric(vertical: MediaQuery.of(this).size.height * factor);
  EdgeInsets getSymmetricPaddingHorizontal(double factor) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(this).size.width * factor);
}
