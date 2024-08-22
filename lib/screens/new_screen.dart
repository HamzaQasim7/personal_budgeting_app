import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String cardName;
  final String holderName;
  final String cardNumber;
  final String? backgroundImagePath;
  final Color cardColor;
  final String cardType;
  final String expiryDate;

  const AccountCard({
    super.key,
    required this.cardName,
    required this.holderName,
    required this.cardNumber,
    this.backgroundImagePath,
    required this.cardColor,
    required this.cardType,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth;
        double cardHeight = cardWidth * 0.63; // Standard card aspect ratio

        return Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(backgroundImagePath ?? ''),
              fit: BoxFit.cover,
              // colorFilter: ColorFilter.mode(
              //   cardColor.withOpacity(0.8),
              //   BlendMode.overlay,
              // ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(cardWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cardName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: cardWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      cardType,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: cardWidth * 0.04,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/chip.png',
                      width: cardWidth * 0.1,
                      height: 60,
                    ),
                    const SizedBox(width: 15),
                    Image.asset(
                      'assets/images/contact_less.png',
                      width: cardWidth * 0.05,
                      height: 60,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'XXXX XXXX XXXX ${cardNumber.substring(cardNumber.length - 4)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: cardWidth * 0.045,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: cardHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          holderName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: cardWidth * 0.035,
                          ),
                        ),
                        Text(
                          'Expires $expiryDate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: cardWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AccountCardsCarousel extends StatelessWidget {
  final List<AccountCardData> cards;

  const AccountCardsCarousel({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: cards.map((card) {
        return Builder(
          builder: (BuildContext context) {
            return AccountCard(
              cardName: card.cardName,
              holderName: card.holderName,
              cardNumber: card.cardNumber,
              backgroundImagePath: card.backgroundImagePath,
              cardColor: card.cardColor,
              cardType: card.cardType,
              expiryDate: card.expiryDate,
            );
          },
        );
      }).toList(),
    );
  }
}

class AccountCardData {
  final String cardName;
  final String holderName;
  final String cardNumber;
  final String backgroundImagePath;
  final Color cardColor;
  final String cardType;
  final String expiryDate;

  AccountCardData({
    required this.cardName,
    required this.holderName,
    required this.cardNumber,
    required this.backgroundImagePath,
    required this.cardColor,
    required this.cardType,
    required this.expiryDate,
  });
}
