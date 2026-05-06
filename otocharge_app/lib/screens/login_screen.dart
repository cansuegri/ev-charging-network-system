import 'package:flutter/material.dart';
import 'home_screen.dart'; 
import 'welcome_screen.dart'; 
import 'register_screen.dart';
import '../services/auth_service.dart';

// Controller ve Yüklenme durumu kullanacağımız için StatefulWidget olmak zorunda
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Kullanıcının yazdığı metinleri tutacak değişkenler
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Firebase işlemleri
  final AuthService _authService = AuthService();
  
  // Yükleniyor animasyonu kontrolü
  bool _isLoading = false;

  // --- GÜVENLİ FİREBASE GİRİŞ FONKSİYONU ---
  Future<void> _login() async {
    // 1. Boş alan kontrolü
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email and password.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 2. Yüklenme simgesini başlat
    setState(() {
      _isLoading = true;
    });

    try {
      // 3. Firebase'e giriş isteği yolla
      final user = await _authService.signInWithEmailPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Sayfa hala açık mı kontrolü (Güvenlik)
      if (!mounted) return;

      if (user != null) {
        // 4. Giriş Başarılı - Ana Sayfaya Yönlendir
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful!'),
            backgroundColor: Color(0xFF2F8F5B),
          ),
        );
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false, // Geri tuşuna basınca logine dönmesin diye geçmişi siliyoruz
        );
      } else {
        // 5. Giriş Başarısız (Yanlış şifre vb.)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed. Invalid email or password.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // Beklenmeyen bir hata olursa sonsuz döngüye girmemesi için hata yakalama
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred during login.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      // 6. İşlem ne olursa olsun (başarılı veya hatalı) yüklenme simgesini DURDUR!
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010), 
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70, size: 20),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacement(
                          context, 
                          MaterialPageRoute(builder: (context) => const WelcomeScreen())
                        );
                      }
                    },
                  ), 
                ],
              ), 
              
              const SizedBox(height: 40),
              
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.bolt, color: Color(0xFFF4D06F), size: 55),
                    SizedBox(height: 10),
                    Text(
                      'SPARKY', 
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 22, 
                        fontWeight: FontWeight.bold, 
                        letterSpacing: 4
                      )
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              const Text(
                'Welcome back', 
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 34, 
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1
                )
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter your details to sign in.', 
                style: TextStyle(color: Colors.grey[600], fontSize: 16)
              ),

              const SizedBox(height: 45),
              
              _buildLabel("EMAIL ADDRESS"),
              _buildTextField(hint: "name@example.com", controller: _emailController),
              
              const SizedBox(height: 25),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabel("PASSWORD"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?", 
                      style: TextStyle(color: Color(0xFFF4D06F), fontSize: 12, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
              _buildTextField(hint: "••••••••", isPassword: true, controller: _passwordController),

              const SizedBox(height: 35),
              
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF4D06F), Color(0xFFEBC76D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login, // Yüklenirken butona tekrar basılmasını engeller
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, 
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isLoading 
                          ? const SizedBox(
                              width: 24, 
                              height: 24, 
                              child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2.5)
                            )
                          : const Text('Login', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      if (!_isLoading) const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[900])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text("OR CONTINUE WITH", style: TextStyle(color: Colors.grey[700], fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Divider(color: Colors.grey[900])),
                ],
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: _buildSocialButton("Google", Icons.g_mobiledata)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildSocialButton("Apple", Icons.apple)),
                ],
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const RegisterScreen()) 
                      );
                    },
                    child: const Text(
                      "Register", 
                      style: TextStyle(color: Color(0xFFF4D06F), fontWeight: FontWeight.bold, fontSize: 15)
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _footerText("PRIVACY"),
                  const SizedBox(width: 25),
                  _footerText("TERMS"),
                  const SizedBox(width: 25),
                  _footerText("SUPPORT"),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Text(
      text, 
      style: const TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.2)
    ),
  );

  Widget _buildTextField({required String hint, bool isPassword = false, required TextEditingController controller}) => TextField(
    controller: controller, // Firebase'in verileri okuyabilmesi için zorunlu
    obscureText: isPassword,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 15),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),
  );

  Widget _buildSocialButton(String label, IconData icon) => Container(
    height: 55,
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.white10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    ),
  );

  Widget _footerText(String text) => Text(
    text, 
    style: TextStyle(color: Colors.grey[800], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)
  );
}