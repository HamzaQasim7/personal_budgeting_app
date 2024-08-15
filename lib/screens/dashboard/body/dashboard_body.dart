import 'package:flutter/material.dart';
import 'package:intern_test/extensions/padding_ext.dart';
import 'package:intern_test/extensions/sized_box_ext.dart';
import 'package:intern_test/screens/dashboard/body/large_custom_container.dart';
import 'package:intern_test/screens/dashboard/body/lower_section.dart';
import 'package:intern_test/screens/dashboard/body/sliding_cards.dart';
import 'package:intern_test/screens/dashboard/body/small_custom_container.dart';
import 'package:intern_test/screens/dashboard/body/social_media.dart';
import 'package:intern_test/screens/dashboard/body/text_custom_container.dart';

import '../../../constants/strings/app_strings.dart';
import 'bottom_container.dart';

class BodyDashBoardScreen extends StatelessWidget {
  const BodyDashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.05),
          const SlidingCardsView(),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmallCustomContainer(
                  text: KAppTexts.munqibat,
                  bgImage: 'assets/dashboard/png/manqabat_1.png',
                ),
                SmallCustomContainer(
                  text: KAppTexts.isharTashakkor,
                  bgImage: 'assets/dashboard/png/izhar_1.png',
                ),
                SmallCustomContainer(
                  text: KAppTexts.muqadima_kitab,
                  bgImage: 'assets/dashboard/png/muqadma_1.png',
                ),
                SmallCustomContainer(
                  text: KAppTexts.paysh_alfaz,
                  bgImage: 'assets/dashboard/png/paish-lafz_1.png',
                ),
              ],
            ),
          ),
          context.sizedBoxHeight(0.02),
          Padding(
            padding: context.getSymmetricPaddingHorizontal(0.03),
            child: const Column(
              children: [
                LargeCustomContainer(
                  imageURl: 'assets/dashboard/png/1.png',
                  heading: 'سوانح حیات',
                  subheading: 'از رشحاتِ قلم:',
                  authorName: 'حضرت سیّد محمد ظفر مشہدی قادری رحمة الله عليه',
                ),
                LargeCustomContainer(
                  imageURl: 'assets/dashboard/png/2.png',
                  heading: 'قلب سلیم',
                  subheading: 'از رشحاتِ قلم:',
                  authorName: 'سیّد محمد فراز شاہ مشہدی قادری عفی عنہ',
                ),
                LargeCustomContainer(
                  imageURl: 'assets/dashboard/png/3.png',
                  heading: 'اقوال و ارشاداتِ عالیہ',
                  subheading:
                      'امام الاولیاء حضرت پیر سیّد محمّد عبد  الله  شاہ',
                  authorName: 'مشہدی قادری رحمة الله تعالى عليه',
                ),
                LargeCustomContainer(
                  imageURl: 'assets/dashboard/png/4.png',
                  heading: 'الفراق',
                  subheading: 'از رشحاتِ قلم',
                  authorName: 'حضرت سیّد محمد ظفر قادری رحمة الله ليه',
                ),
              ],
            ),
          ),
          context.sizedBoxHeight(0.02),
          const LowerSection(),
          context.sizedBoxHeight(0.02),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_7.png',
                text: 'شجرۂ قادریہ نسبیہ',
              ),
              TextCustomContainer(
                imageURL: 'assets/dashboard/png/bg_text_6.png',
                text: 'شجرۂ قادریہ نسبیہ',
              ),
            ],
          ),
          context.sizedBoxHeight(0.02),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            width: double.infinity,
            height: screenWidth * 0.20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dashboard/png/bg_text_9.png'),
              ),
            ),
            child: Center(
              child: Text(
                'شجرۂ قادریہ نسبیہ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          context.sizedBoxHeight(0.02),
          const BottomContainer(),
          context.sizedBoxHeight(0.02),
          const SocialMedia(),
          context.sizedBoxHeight(0.02),
        ],
      ),
    );
  }
}
