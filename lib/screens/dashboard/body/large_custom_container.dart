import 'package:flutter/material.dart';
import 'package:intern_test/extensions/sized_box_ext.dart';

class LargeCustomContainer extends StatelessWidget {
  final String imageURl;
  final String heading;
  final String subheading;
  final String authorName;
  const LargeCustomContainer({
    super.key,
    required this.imageURl,
    required this.heading,
    required this.subheading,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageURl),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          context.sizedBoxWidth(0.05),
          SizedBox(
            width: screenWidth * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  heading,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.displayMedium!.apply(
                        fontSizeFactor: 0.045,
                      ),
                ),
                Text(
                  subheading,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.025,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  authorName,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: null,
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
