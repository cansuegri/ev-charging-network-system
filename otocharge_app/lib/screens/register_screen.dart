import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: Stack(
        children: [
          // 1. ARKA PLANDAKİ HAFİF SARI IŞIK (Hata düzeltildi)
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // blurRadius boxShadow içine taşındı, hata artık yok
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF4D06F).withOpacity(0.05),
                    blurRadius: 150,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          
          // 2. ANA İÇERİK
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // GERİ DÖNÜŞ BUTONU
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  _buildLogoSection(),
                  const SizedBox(height: 40),
                  const Text(
                    'Join the\nEcosystem', 
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 44, 
                      fontWeight: FontWeight.w900, 
                      height: 1.1,
                      letterSpacing: -1.5,
                    )
                  ),
                  const SizedBox(height: 45),
                  _buildLabel("FULL NAME"),
                  _buildInputField(hint: "Nikola Tesla", icon: Icons.person_outline),
                  const SizedBox(height: 25),
                  _buildLabel("EMAIL ADDRESS"),
                  _buildInputField(hint: "tesla@sparky.ev", icon: Icons.alternate_email),
                  const SizedBox(height: 25),
                  _buildLabel("PASSWORD"),
                  _buildInputField(hint: "••••••••", icon: Icons.lock_outline, isPassword: true),
                  const SizedBox(height: 25),
                  _buildLabel("CONFIRM PASSWORD"),
                  _buildInputField(hint: "••••••••", icon: Icons.verified_user_outlined, isPassword: true),
                  const SizedBox(height: 30),
                  _buildTermsCheckbox(),
                  const SizedBox(height: 40),
                  _buildRegisterButton(),
                  const SizedBox(height: 40),
                  _buildLoginLink(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Yardımcı Metotlar (Yapı Korundu) ---

  Widget _buildLogoSection() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(Icons.bolt, color: Color(0xFFF4D06F), size: 30),
      const SizedBox(width: 8),
      const Text('SPARKY', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
    ],
  );

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 10),
    child: Text(text, style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
  );

  Widget _buildInputField({required String hint, required IconData icon, bool isPassword = false}) => TextField(
    obscureText: isPassword,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.white24, size: 22),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white12, fontSize: 16),
      filled: true,
      fillColor: const Color(0xFF181818),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
    ),
  );

  Widget _buildTermsCheckbox() => Row(
    children: [
      SizedBox(
        height: 24, width: 24,
        child: Checkbox(
          value: _isAgreed,
          activeColor: const Color(0xFFF4D06F),
          checkColor: Colors.black,
          side: const BorderSide(color: Colors.white12, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onChanged: (val) => setState(() => _isAgreed = val!),
        ),
      ),
      const SizedBox(width: 12),
      const Expanded(child: Text("I agree to the Terms & Privacy Policy", style: TextStyle(color: Colors.grey, fontSize: 13))),
    ],
  );

  Widget _buildRegisterButton() => Container(
    height: 60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(18),
      gradient: const LinearGradient(colors: [Color(0xFFF4D06F), Color(0xFFEBC76D)]),
    ),
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('REGISTER', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
          SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.black, size: 18),
        ],
      ),
    ),
  );

  Widget _buildLoginLink() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Already have an account? ", style: TextStyle(color: Colors.grey, fontSize: 15)),
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Text("Login", style: TextStyle(color: Color(0xFFF4D06F), fontWeight: FontWeight.bold, fontSize: 15)),
      ),
    ],
  );
}