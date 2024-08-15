import 'package:flutter/material.dart';

import 'DetailScreen.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(50.0),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            'شجرہ قادریہ حسینیہ',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'NotoNaskhArabic',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            color: Colors.white,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'ابو رحمت اللہ علیہ کا شجرہ حسب حال اکابرین (رح) و اسلافین سے بیاں کرتا ہوں۔ محبوب خدا حضرت سیدنا احمد مجتبیٰ محمد مصطفیٰ، صلی اللہ علیہ و آلہ وسلم سے لے کر',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'اس کی پوری تفصیل ملاحظہ فرمائیں:',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'NotoNaskhArabic',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CardWidget(
                        imagePath: 'assets/images/masjid.jpg',
                        title: 'خاتم النبیین حضرت سیدنا محمد رسول اللہ',
                        description: 'صلی اللہ علیہ و آلہ و سلم',
                        index: '1',
                      ),
                      ConnectorLine(),
                      CardWidget(
                        imagePath: 'assets/images/masjid2.jpg',
                        title: 'حضرت سیدنا علی المرتضیٰ',
                        description: 'کرم اللہ تعالٰی وجہہ الکریم',
                        index: '2',
                      ),
                      ConnectorLine(),
                      CardWidget(
                        imagePath: 'assets/images/masjid3.jpg',
                        title: 'حضرت سیدنا علی المرتضیٰ',
                        description: 'کرم اللہ تعالٰی وجہہ الکریم',
                        index: '3',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String index;

  const CardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.blue,
          child: Text(
            index,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const ConnectorLine(),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  title: title,
                  description: description,
                ),
              ),
            );
          },
          child: SizedBox(
            width: 400,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 4,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                    child: Image.asset(imagePath, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          description,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'NotoNaskhArabic',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConnectorLine extends StatelessWidget {
  const ConnectorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 2,
      color: Colors.grey,
      margin: const EdgeInsets.only(left: 40, right: 40),
    );
  }
}
