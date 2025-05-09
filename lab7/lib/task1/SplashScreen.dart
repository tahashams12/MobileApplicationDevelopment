import 'package:flutter/material.dart';
import 'package:lab7/task1/SecondScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Remove the automatic navigation from initState
  @override
  void initState() {
    super.initState();
    // No automatic navigation
  }

  void _navigateToSecondScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onDoubleTap: _navigateToSecondScreen, // Navigate ONLY on double tap
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to My App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                'Double-tap to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
