import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(this.username, {super.key});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[700],
      padding: const EdgeInsets.all(2),
      height: 78,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const SizedBox(width: 30),
            const Icon(
              Icons.account_circle,
              size: 40,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(username),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text('User Profiles'),
      ),
      body: Container(
        color: Colors.grey[700],
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: const [
            ProfileCard('Ali Khan'),
            ProfileCard('Zain Ahmed'),
            ProfileCard('Hassan Raza'),
            ProfileCard('Bilal Tariq'),
            ProfileCard('Fahad Malik'),
            ProfileCard('Usman Qureshi'),
            ProfileCard('Hina Sheikh'),
            ProfileCard('Areeba Javed'),
            ProfileCard('Farhan Anwar'),
            ProfileCard('Waleed Akram'),
            ProfileCard('Tariq Mehmood'),
            ProfileCard('Noman Iqbal'),
            ProfileCard('Shabbir Hussain'),
          ],
        ),
      ),
    );
  }
}
