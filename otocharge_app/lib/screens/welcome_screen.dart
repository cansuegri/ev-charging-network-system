// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Derin siyah arka plan
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            
            // 1. Üstteki Görsel Kartı
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  image: const DecorationImage(
                    image: AssetImage('assets/welcomepage.png.jpg'), // pubspec'teki adıyla birebir aynı
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // 2. Alt Kısım (Metinler ve Gradient Buton)
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to",
                      style: TextStyle(
                        fontSize: 44, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                        height: 0.9,
                      ),
                    ),
                    const Text(
                      "Sparky",
                      style: TextStyle(
                        fontSize: 44, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFFFFD982), // Vurgu rengi (Altın)
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Experience the future of mobility with our premium network of luminous charging stations. Powering your journey, one star at a time.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(0.6),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 35),
                    
                    // "Get Started" Gradient Butonu
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFFE5A5), Color(0xFFF2C94C)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get Started", 
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold, 
                                color: Color(0xFF4A3400),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_rounded, color: Color(0xFF4A3400), size: 22),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Alt Bilgi (Footer)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildFooterItem("LUMINOUS NETWORK"),
                        const SizedBox(width: 20),
                        _buildFooterItem("PREMIUM FLOW"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Alt kısımdaki noktalı yazılar için yardımcı widget
  Widget _buildFooterItem(String text) {
    return Row(
      children: [
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFFFFD982),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white24,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}