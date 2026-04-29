import 'package:flutter/material.dart';
import 'package:otocharge_app/screens/welcome_screen.dart';

void main() {
  runApp(const SparkyApp());
}

class SparkyApp extends StatelessWidget {
  const SparkyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sparky',
      home: const WelcomeScreen(), 
    );
  }
}