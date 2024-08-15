import 'package:flutter/material.dart';
import 'package:intern_test/extensions/padding_ext.dart';
import 'package:intern_test/extensions/sized_box_ext.dart';

import '../../../constants/strings/app_strings.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.75,
      padding: context.getPaddingSymmetric(
        horizontal: 0.03,
        vertical: 0.03,
      ),
      decoration: const BoxDecoration(
        color: Color(0XFF2C3491),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0XFF162170),
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            height: screenHeight * 0.3,
            width: double.infinity,
            child: const Image(
              image: AssetImage('assets/dashboard/png/hizb-ur-rahman.png'),
            ),
          ),
          context.sizedBoxHeight(0.02),
          Text(
            KAppTexts.copyRight,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          context.sizedBoxHeight(0.02),
          Text(
            KAppTexts.senFirst,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          context.sizedBoxHeight(0.02),
          Text(
            KAppTexts.senSecond,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          context.sizedBoxHeight(0.02),
          Text(
            KAppTexts.sentThird,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}
