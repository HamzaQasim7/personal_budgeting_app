import 'package:flutter/material.dart';

class SmallCustomContainer extends StatelessWidget {
  final String text;
  final String bgImage;
  const SmallCustomContainer(
      {super.key, required this.text, required this.bgImage});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          bgImage,
          height: screenHeight * 0.15,
          width: screenWidth * 0.2,
        ),
        Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
