import 'package:flutter/material.dart';
import 'package:otocharge_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Flutter'ın arka plan motorunu başlat
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase'i projeye bağla
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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