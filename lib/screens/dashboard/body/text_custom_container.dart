import 'package:flutter/material.dart';

class TextCustomContainer extends StatelessWidget {
  final String imageURL;
  final String text;
  final double? width;
  const TextCustomContainer({
    super.key,
    required this.imageURL,
    required this.text,
    double? width,
  }) : width = width ?? 0.22;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenHeight * 0.2,
      height: screenWidth * 0.22,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageURL),
        ),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
