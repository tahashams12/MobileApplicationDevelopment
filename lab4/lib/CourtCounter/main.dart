import 'package:flutter/material.dart';
import 'package:lab4/CourtCounter/court_counter_main_screen.dart';

void main() {
  runApp(const CourtCounter());
}

// Theme Setting For The App

ThemeData themeSettings() {
  return ThemeData(
    // Setting primary text color to be black
    primaryColor: Colors.black,
    textTheme: TextTheme(
      bodyMedium: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(Colors.black),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        ), // Rectangle shape,
        backgroundColor: WidgetStatePropertyAll(
            Colors.orange), // background color of the elevated buttons
      ),
    ),
    // Setting the background color of Scaffold
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      backgroundColor: Colors.orange, // background color of app bar
      centerTitle: true, // title of app bar is set to be in the center
      // Styling the title text of app bar
    ),
  );
}

class CourtCounter extends StatelessWidget {
  const CourtCounter({super.key});

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Court Counter"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // So that no debug option is shown
      title: "Court Counter",
      theme: themeSettings(),
      home: Scaffold(
        appBar: buildAppBar(),
        body: Center(child: CourtCounterMainScreen()),
      ),
    );
  }
}
