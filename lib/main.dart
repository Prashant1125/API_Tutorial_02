import 'package:api_tutorial_2/home.dart';
import 'package:flutter/material.dart';
import 'screens/api_example3.dart';
import 'screens/api_example4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "API Tutorial",
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: const HomeScreen(),
      // home: const ApiExample3(),
      home: const ApiExample4(),
    );
  }
}
