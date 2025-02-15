import 'dart:async';
import 'package:flutter/material.dart';
import 'package:last_try/login_pages/generate_otp.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Loginpage1Widget(
                  userName: '',
                )), // Navigate to login page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/animations/Splash.json',
          width: 300,
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
