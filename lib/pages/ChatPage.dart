import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receieverEmail;
  const ChatPage({super.key, required this.receieverEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receieverEmail)),
    );
  }
}
