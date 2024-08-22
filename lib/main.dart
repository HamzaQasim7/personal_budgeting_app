import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intern_test/coloring.dart';
import 'package:intern_test/provider/budget_provider.dart';
import 'package:intern_test/provider/data_provider.dart';
import 'package:intern_test/provider/post_provider.dart';
import 'package:intern_test/provider/qlbe_saleem_audio_provider.dart';
import 'package:intern_test/screens/dashboard/dashboard_screen.dart';
import 'package:intern_test/screens/dum/dashboard_screen.dart';
import 'package:intern_test/screens/loaded_data_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BudgetProvider>(
          create: (_) => BudgetProvider(),
        ),
        ChangeNotifierProvider<QlbeSaleemAudioProvider>(
          create: (_) => QlbeSaleemAudioProvider(),
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (_) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            titleLarge: const TextStyle(
              fontFamily: 'MontserratAlternates',
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            titleMedium: const TextStyle(
              fontFamily: 'MontserratAlternates',
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
            bodyLarge: const TextStyle(
              fontFamily: 'SourceSans3',
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
            displayMedium: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.035,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        home: const ColorPickerScreen(),
      ),
    );
  }
}
