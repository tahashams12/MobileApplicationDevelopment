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
      title: 'About Me',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Me'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Introduction'),
              Tab(icon: Icon(Icons.school), text: 'Education'),
              Tab(icon: Icon(Icons.sports_soccer), text: 'Hobbies'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            IntroductionTab(),
            EducationTab(),
            HobbiesTab(),
          ],
        ),
      ),
    );
  }
}

class IntroductionTab extends StatelessWidget {
  const IntroductionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
                text: 'Hello! My name is ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'Taha Shams. '),
            TextSpan(text: 'I am Flutter developer.'),
          ],
        ),
      ),
    );
  }
}

class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
                text: 'Education: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: 'BSc in Computer Science from Bahria University.'),
          ],
        ),
      ),
    );
  }
}

class HobbiesTab extends StatelessWidget {
  const HobbiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
                text: 'Hobbies: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    'Playing football, reading books, and coding in Flutter!'),
          ],
        ),
      ),
    );
  }
}
