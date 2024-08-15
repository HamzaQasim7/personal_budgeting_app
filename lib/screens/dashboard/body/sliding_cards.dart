import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intern_test/extensions/sized_box_ext.dart';

class SlidingCardsView extends StatefulWidget {
  const SlidingCardsView({super.key});

  @override
  State<SlidingCardsView> createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8, initialPage: 2);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight * 0.3,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: 5,
        itemBuilder: (context, index) {
          // double offset = pageOffset - index;
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow((pageOffset.abs() - 0.5), 2) / 0.08));
              return Transform.translate(
                offset: Offset(-32 * gauss * pageOffset.sign, 0),
                child: Container(
                  padding: EdgeInsets.only(top: screenHeight * 0.025),
                  width: double.infinity,
                  clipBehavior: Clip.none,
                  margin: EdgeInsets.only(
                    left: screenWidth * 0.01,
                    right: screenWidth * 0.01,
                    bottom: screenWidth * 0.02,
                  ),
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      screenWidth * 0.02,
                    ),
                    image: const DecorationImage(
                      image:
                          AssetImage('assets/dashboard/png/darbar-shareef.png'),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(8, 20),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: screenWidth * 0.02),
                        height: screenHeight * 0.06,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/dashboard/png/bg-text.png'),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'فهرست مجالس',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      context.sizedBoxHeight(0.02),
                      Text(
                        'امام الاولیاء حضرت پیر سیّد محمّد عبد الله شاہ مشہدی قادر\nی رحمة الله تعالى عليه',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
