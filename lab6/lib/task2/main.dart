import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final messages = [
      {"content": "Hello Alex", "sentByUser": false},
      {"content": "Hey Sam!", "sentByUser": true},
      {"content": "What are we coding today?", "sentByUser": false},
      {"content": "A sleek chat interface!", "sentByUser": true},
      {"content": "Sounds interesting!", "sentByUser": false},
      {"content": "Yes, it’ll be fun!", "sentByUser": true},
      {"content": "How do we begin?", "sentByUser": false},
      {"content": "Using ListView and Containers", "sentByUser": true},
      {"content": "Alright, let's get started!", "sentByUser": false},
      {"content": "Time to code!", "sentByUser": false},
      {"content": "You’re amazing!", "sentByUser": false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat Room",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ChatBubble(
            text: messages[index]['content'] as String,
            isUser: messages[index]['sentByUser'] as bool,
          );
        },
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({super.key, required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.deepPurple : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isUser ? const Radius.circular(15) : Radius.zero,
            bottomRight: isUser ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
