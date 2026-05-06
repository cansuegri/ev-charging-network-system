import 'package:flutter/material.dart';
import '../states/wallet_state.dart';
import 'home_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const double sessionCost = 12.45;

  // --- FIREBASE İÇİN ASENKRON (ASYNC) HALE GETİRİLDİ ---
  Future<void> _payNow() async {
    // İşlemin Firebase'de bitmesini 'await' ile bekliyoruz
    final success = await walletState.pay(sessionCost);

    // Veritabanından cevap gelene kadar kullanıcı sayfayı kapatırsa çökmesin diye güvenlik kontrolü
    if (!mounted) return;

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient wallet balance.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Payment completed successfully.'),
        backgroundColor: Color(0xFF2F8F5B),
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(initialIndex: 2),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: walletState,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF101010),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.payments,
                    color: Color(0xFFF4D06F),
                    size: 34,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Payment Summary',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Review your charging session cost.',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 28),

                  _paymentRow('Station', 'North Star Hub'),
                  _paymentRow('Delivered Energy', '34.2 kWh'),
                  _paymentRow('Duration', '42 min'),
                  _paymentRow('Price', '\$0.42 / kWh'),

                  const Divider(color: Colors.white12, height: 34),

                  _paymentRow('Total', '\$12.45', isTotal: true),

                  const SizedBox(height: 28),

                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _methodTile(
                    method: PaymentMethod.wallet,
                    title: 'Sparky Wallet',
                    // Bakiye anlık olarak Firebase'den gelecek!
                    subtitle:
                        'Balance: \$${walletState.balance.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet,
                  ),
                  const SizedBox(height: 12),
                  _methodTile(
                    method: PaymentMethod.visa,
                    title: 'Visa Card',
                    subtitle: '** 4242',
                    icon: Icons.credit_card,
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: _payNow, // Güncellediğimiz asenkron fonksiyon
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF4D06F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'PAY NOW',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _paymentRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: isTotal ? Colors.white : Colors.white,
              fontSize: isTotal ? 18 : 15,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? const Color(0xFFF4D06F) : Colors.white,
              fontSize: isTotal ? 24 : 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _methodTile({
    required PaymentMethod method,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = walletState.selectedMethod == method;

    return GestureDetector(
      onTap: () {
        walletState.selectPaymentMethod(method);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? const Color(0xFFF4D06F) : Colors.white10,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFFF4D06F)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ? const Color(0xFFF4D06F) : Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}