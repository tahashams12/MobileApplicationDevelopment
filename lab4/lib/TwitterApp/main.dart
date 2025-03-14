import 'package:flutter/material.dart';

void main() {
  runApp(const TwitterHome());
}

class TwitterHome extends StatelessWidget {
  const TwitterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blue, // Twitter blue background
        body: Center(
          child:
              Image.asset('assets/twitter_logo.png', width: 100, height: 100),
        ),
      ),
    );
  }
}
