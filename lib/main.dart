import 'package:chat_app/auth/LoginorSignup.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/themes/LightMode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      home: LoginOrSignup(),
      theme: lightMode,
    );
  }
}
