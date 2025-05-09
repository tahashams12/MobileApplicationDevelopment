import 'package:flutter/material.dart';
import 'package:lab7/task1/ThirdScreen.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToThirdScreen(String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ThirdScreen(title: title, content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taha Shams'), // Replace with your actual name
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'About Me'),
            Tab(icon: Icon(Icons.home), text: 'Hometown'),
            Tab(icon: Icon(Icons.school), text: 'Student Life'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // About Me Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onLongPress: () {
                    _navigateToThirdScreen(
                        'About Me',
                        'Detailed information about me:\n\n'
                            'I am a passionate developer with interests in mobile app development, '
                            'particularly using Flutter. I enjoy creating user-friendly and '
                            'responsive applications.\n\n'
                            'Skills:\n'
                            '- Flutter & Dart\n'
                            '- Mobile UI/UX Design\n'
                            '- Problem Solving\n'
                            '- Team Collaboration\n\n'
                            'I am constantly learning new technologies and techniques to improve my skills.');
                  },
                  child: const Text(
                    'Hello! I am a mobile app developer specializing in Flutter. '
                    'Long press for more details about me.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          // Hometown Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/hometown.jpg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onLongPress: () {
                    _navigateToThirdScreen(
                        'Islamabad',
                        'Detailed information about my hometown:\n\n'
                            'Islamabad is a stunning city nestled in the foothills of the Margalla Hills. '
                            'Known for its serene environment, modern infrastructure, and rich cultural heritage, '
                            'it offers a perfect blend of nature and urban living. The city stands out for its cleanliness, '
                            'organized layout, and welcoming community.\n\n'
                            'Notable places to visit include:\n'
                            '- Iconic historical monuments and landmarks\n'
                            '- Beautiful parks and botanical gardens such as Daman-e-Koh and Shakarparian\n'
                            '- Bustling local markets showcasing traditional crafts and handmade goods\n'
                            '- A wide array of restaurants and food stalls offering mouth-watering local cuisine\n\n'
                            'The weather in Islamabad remains pleasant for most of the year, with lush greenery and blooming flowers '
                            'adding to its charm, especially during spring. The city also hosts vibrant cultural festivals, music events, '
                            'and art exhibitions throughout the year, making it an engaging place to explore.\n\n'
                            'What I love most about Islamabad is its natural beauty, peaceful atmosphere, and the warmth and hospitality of its people.');
                  },
                  child: const Text(
                    'My hometown is a beautiful place with rich culture and history. '
                    'Long press to learn more about it.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),

          // Student Life Tab
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/university.jpg',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onLongPress: () {
                    _navigateToThirdScreen(
                        'Student Life at Bahria University',
                        'Detailed information about my student life at Bahria University:\n\n'
                            'Being a student at Bahria University has been an amazing journey of learning and growth. '
                            'The university provides excellent facilities and opportunities for students to excel in their fields.\n\n'
                            'Activities and experiences:\n'
                            '- Participating in tech competitions\n'
                            '- Working on real-world projects\n'
                            '- Attending workshops and seminars\n'
                            '- Being part of student societies\n\n'
                            'The faculty members are highly qualified and supportive, always ready to guide students in their academic and professional endeavors.');
                  },
                  child: const Text(
                    'My journey at Bahria University has been full of learning and growth. '
                    'Long press to read about my university experiences.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
