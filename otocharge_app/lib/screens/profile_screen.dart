// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'welcome_screen.dart';
// Buraya projenin diğer ekranlarını import ediyoruz
import 'add_card_screen.dart'; 
// import 'payment_methods_screen.dart'; // Bu dosyalar sende hazırsa yorum satırını kaldırabilirsin
// import 'notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 34),
              _buildUserInfo(),
              const SizedBox(height: 34),
              _sectionTitle('ACCOUNT SETTINGS'),
              const SizedBox(height: 12),
              _settingsGroup(
                children: [
                  _settingsTile(
                    icon: Icons.credit_card,
                    title: 'Payment Methods',
                    onTap: () {
                      // Ödeme yöntemleri sayfasına yönlendirme
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCardScreen()));
                    },
                  ),
                  _settingsTile(
                    icon: Icons.settings,
                    title: 'Account Settings',
                    onTap: () {
                      // Hesap ayarları sayfasına yönlendirme
                    },
                  ),
                  _settingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {
                      // Bildirimler sayfasına yönlendirme
                    },
                  ),
                  _settingsTile(
                    icon: Icons.shield,
                    title: 'Privacy & Security',
                    onTap: () {
                      // Gizlilik sayfasına yönlendirme
                    },
                  ),
                ],
              ),
              const SizedBox(height: 26),
              _sectionTitle('SUPPORT'),
              const SizedBox(height: 12),
              _settingsGroup(
                children: [
                  _settingsTile(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {
                      // Yardım merkezi yönlendirmesi
                    },
                  ),
                  _settingsTile(
                    icon: Icons.logout_rounded,
                    title: 'Sign Out',
                    isDanger: true,
                    onTap: () {
                      // Çıkış yapınca welcome screen'e döner ve önceki sayfaları siler
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.star_rounded, color: Color(0xFFF4D06F), size: 22),
        const SizedBox(width: 8),
        const Text(
          'SPARKY',
          style: TextStyle(
            color: Color(0xFFF4D06F),
            fontSize: 17,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // Sağ üstteki üç nokta butonu işlevi
          },
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white70,
              size: 22,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 106,
            height: 106,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFF4D06F), Color(0xFF2C2C2C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF4D06F).withAlpha(40), // withOpacity yerine withAlpha kullanarak uyarılardan kaçındık
                  blurRadius: 28,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: const CircleAvatar(
              backgroundColor: Color(0xFF202020),
              child: Icon(
                Icons.person,
                color: Color(0xFFF4D06F),
                size: 52,
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Alex Sterling',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'EXECUTIVE MEMBER',
            style: TextStyle(
              color: Colors.white38,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: const [
              _ProfileBadge(
                icon: Icons.verified,
                text: 'Identity Verified',
              ),
              _ProfileBadge(
                icon: Icons.calendar_month,
                text: 'Member since Oct 2023',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white38,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _settingsGroup({required List<Widget> children}) {
    return Container(
      clipBehavior: Clip.antiAlias, // İçerideki InkWell'in köşelerden taşmaması için
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isDanger
                      ? Colors.red.withAlpha(25)
                      : const Color(0xFFF4D06F).withAlpha(30),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: isDanger ? Colors.redAccent : const Color(0xFFF4D06F),
                  size: 21,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDanger ? Colors.redAccent : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: isDanger ? Colors.redAccent.withAlpha(180) : Colors.white30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ProfileBadge({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFF4D06F), size: 15),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}