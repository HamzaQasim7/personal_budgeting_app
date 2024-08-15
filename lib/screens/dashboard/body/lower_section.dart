import 'package:flutter/material.dart';
import 'package:intern_test/extensions/padding_ext.dart';
import 'package:intern_test/extensions/sized_box_ext.dart';
import 'package:intern_test/screens/dashboard/body/text_custom_container.dart';

class LowerSection extends StatelessWidget {
  const LowerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.6,
      margin: EdgeInsets.zero,
      width: double.infinity,
      padding: context.getPaddingSymmetric(horizontal: 0.03),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/dashboard/png/gradient.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: screenHeight * 0.08,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dashboard/png/bg-text.png'),
              ),
            ),
            child: Center(
              child: Text(
                'شجرۂ قادریہ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          context.sizedBoxHeight(0.02),
          Text(
            'امام الاولیاء  حضرت پیر سیّد محمّد عبد اللہ شاہ مشہدی قادری رحمة الله تعالى عليه ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
          context.sizedBoxHeight(0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: screenHeight * 0.2,
                height: screenWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Image.asset(
                  'assets/dashboard/png/shajra-nasbia.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: screenHeight * 0.2,
                height: screenWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                ),
                child: Image.asset(
                  'assets/dashboard/png/shajra-hasbia.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          context.sizedBoxHeight(0.02),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_2.png',
                text: 'شجرۂ قادریہ نسبیہ',
              ),
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_3.png',
                text: 'شجرۂ قادریہ نسبیہ',
              ),
            ],
          ),
          context.sizedBoxHeight(0.02),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_4.png',
                text: "شجرۂ قادریہ حسبیہ منظوم مع تضمین ",
              ),
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_5.png',
                text: "شجرۂ قادریہ نسبیہ منظوم مع تضمین ",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
