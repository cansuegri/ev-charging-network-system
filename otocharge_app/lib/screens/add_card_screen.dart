import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add New Card', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Temsili Kart Görseli
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFF4D06F), Color(0xFFB8860B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.contactless, color: Colors.white, size: 32),
                const Text('**** **** **** ****', 
                  style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('CARD HOLDER', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    Text('EXPIRES', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 30),
          // Giriş Alanları
          _buildTextField('Card Number', Icons.credit_card),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildTextField('Expiry Date', Icons.calendar_today)),
              const SizedBox(width: 15),
              Expanded(child: _buildTextField('CVV', Icons.lock_outline)),
            ],
          ),
          const Spacer(),
          // Kaydet Butonu
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF4D06F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () {
                // Kart kaydetme mantığı buraya gelecek
                Navigator.pop(context);
              },
              child: const Text('Save Card', 
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildTextField(String hint, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: const Color(0xFFF4D06F)),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}