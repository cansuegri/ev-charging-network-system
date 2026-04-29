import 'package:flutter/material.dart';
import 'package:otocharge_app/screens/welcome_screen.dart';
import 'screens/login_screen.dart'; // Dosyayı nereye kaydettiysen o yolu yaz

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
      // BURASI ÇOK ÖNEMLİ: home kısmına yeni sınıfı yazmalısın
      home: const WelcomeScreen(), 
    );
  }
}