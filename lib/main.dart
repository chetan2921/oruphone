import 'package:flutter/material.dart';
import 'package:oruphone/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(), // Open Login Page 1 initially
    );
  }
}
