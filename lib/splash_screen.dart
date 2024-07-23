import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart'; // Change this to the actual next screen widget you want

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        "assets/lottie/animation - 1719162693554.json", // Ensure the path to the Lottie asset is correct
      ),
      nextScreen: const LoginScreen(), // Change this to your actual next screen widget
      splashIconSize: 300,
      backgroundColor: Colors.yellow,
      duration: 6000, // Duration in milliseconds (3000ms = 3 seconds)
      splashTransition: SplashTransition.fadeTransition, // Optional: specify a transition effect
    );
  }
}