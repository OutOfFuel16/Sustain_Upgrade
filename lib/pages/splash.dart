import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:campus_carbon/pages/auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: AnimatedSplashScreen(
        duration: 3000, // Duration of the splash screen
        backgroundColor: const Color(0xFFFFFFFF), // White background
        splash: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display the image to the left of the text
              Image.asset(
                'lib/assets/images/earth2.png',
                height: height * 0.1, // Adjust the height as needed
                width: width * 0.1,   // Adjust the width as needed
              ),
              const SizedBox(width: 10), // Space between image and text
              // Display the text next to the image
              const Text(
                'SustainX', // App name
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
        nextScreen: const Auth(),
        splashIconSize: 300, // Size of the splash area
      ),
    );
  }
}
