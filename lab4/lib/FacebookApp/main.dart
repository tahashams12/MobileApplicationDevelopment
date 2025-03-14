import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(), // Pushes logo to center
          Center(
            child: Image.asset(
              'assets/facebook_logo.png', // Replace with your actual logo
              width: 100,
              height: 100,
            ),
          ),
          const Spacer(), // Pushes footer to bottom
          Column(
            children: [
              const Text(
                "FACEBOOK",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/social_icons.png', // Replace with your actual icons image
                width: 150,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
