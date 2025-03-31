import 'package:flutter/material.dart';

void main() {
  runApp(const MessagingApp());
}

class MessagingApp extends StatelessWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConversationScreen(),
    );
  }
}

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chatMessages = [
      {"text": "Hey Tiger", "isSender": false},
      {"text": "Hey John!", "isSender": true},
      {"text": "What are we building today?", "isSender": false},
      {"text": "We're creating a chat UI demo", "isSender": true},
      {"text": "What features will it have?", "isSender": false},
      {"text": "It will resemble a messaging interface", "isSender": true},
      {"text": "That sounds exciting!", "isSender": false},
      {"text": "How do we start?", "isSender": false},
      {"text": "I'll use ListView, Container, and Align", "isSender": true},
      {"text": "Let's get to it!", "isSender": false},
      {"text": "Alright, time to code!", "isSender": false},
      {"text": "You're awesome!", "isSender": false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Messaging",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: chatMessages.length,
        itemBuilder: (context, index) {
          return MessageBubble(
            message: chatMessages[index]['text'] as String,
            isSender: chatMessages[index]['isSender'] as bool,
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const MessageBubble(
      {super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: isSender ? Colors.teal : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isSender ? const Radius.circular(15) : Radius.zero,
            bottomRight: isSender ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSender ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
