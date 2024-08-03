import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intern_test/provider/budget_provider.dart';
import 'package:intern_test/screens/dashboard_screen/dashboard_screen.dart';
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
    return ChangeNotifierProvider(
      create: (context) => BudgetProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Personal Budgeting App',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'MontserratAlternates',
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
            titleMedium: TextStyle(
              fontFamily: 'MontserratAlternates',
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'SourceSans3',
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        home: const Dashboard(),
      ),
    );
  }
}
