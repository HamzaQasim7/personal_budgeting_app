import 'package:flutter/widgets.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            height: screenHeight * 0.08,
            width: screenWidth * 0.1,
            'assets/dashboard/png/facebook.png',
          ),
          Image.asset(
            height: screenHeight * 0.08,
            width: screenWidth * 0.1,
            'assets/dashboard/png/instagram.png',
          ),
          Image.asset(
            height: screenHeight * 0.08,
            width: screenWidth * 0.1,
            'assets/dashboard/png/web.png',
          ),
          Image.asset(
            height: screenHeight * 0.08,
            width: screenWidth * 0.1,
            'assets/dashboard/png/share.png',
          ),
          Image.asset(
            height: screenHeight * 0.08,
            width: screenWidth * 0.1,
            'assets/dashboard/png/gototop.png',
          ),
        ],
      ),
    );
  }
}
