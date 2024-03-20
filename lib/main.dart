import 'package:flutter/material.dart';
import 'package:flutter_test_application/provider/categoryprovider.dart';
import 'package:flutter_test_application/provider/mealsprovider.dart';
import 'package:flutter_test_application/screens/mainscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>  CategoryProvide()),
        ChangeNotifierProvider(create: (context) => MealsProvider())
        ],
        child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true
          ),
          home: const MainScreen(),
        ),
        );
  }
}

