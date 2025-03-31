import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.userName, {super.key});
  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.all(4),
      height: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(width: 25),
            const Icon(
              Icons.account_circle,
              size: 42,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(userName),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('User Profiles'),
      ),
      body: Container(
        color: Colors.teal,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: const [
            ProfileCard('Ali Khan'),
            ProfileCard('Zain Malik'),
            ProfileCard('Hassan Tariq'),
            ProfileCard('Usman Farooq'),
            ProfileCard('Bilal Ahmed'),
            ProfileCard('Faisal Riaz'),
            ProfileCard('Ayesha Noor'),
            ProfileCard('Sana Rafiq'),
            ProfileCard('Kamran Iqbal'),
            ProfileCard('M. Arslan'),
            ProfileCard('Umar Siddique'),
            ProfileCard('Salman Javed'),
            ProfileCard('Naveed Akram'),
          ],
        ),
      ),
    );
  }
}
