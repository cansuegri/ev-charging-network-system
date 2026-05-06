// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'charging_status_screen.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: SafeArea(
        child: Column(
          children: [
            _buildHero(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            title: 'SOCKET',
                            value: 'CCS2',
                            subtitle: 'Fast Charging',
                            icon: Icons.bolt,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _infoCard(
                            title: 'SOCKET',
                            value: 'Type 2',
                            subtitle: 'AC Charging',
                            icon: Icons.electrical_services,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _infoCard(
                            title: 'PRICING POLICY',
                            value: '\$0.42',
                            subtitle: '/kWh',
                            icon: Icons.payments,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _infoCard(
                            title: 'EST. FULL CHARGE',
                            value: '\$12.50',
                            subtitle: 'approx.',
                            icon: Icons.timer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    _detailTile(
                      icon: Icons.location_on,
                      title: 'Grand Central Parking, Level 2',
                      subtitle: 'Access 24/7 • Security on site',
                    ),
                    const SizedBox(height: 12),
                    _detailTile(
                      icon: Icons.credit_card,
                      title: 'Contactless Payment',
                      subtitle: 'Wallet, card, or RFID supported',
                    ),
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ChargingStatusScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.bolt, color: Colors.black),
                        label: const Text(
                          'START CHARGING',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF4D06F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
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

  Widget _buildHero(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFE9401A),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 12,
            left: 12,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            ),
          ),
          const Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'SPARKY',
                style: TextStyle(
                  color: Color(0xFFF4D06F),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const Positioned(
            top: 14,
            right: 18,
            child: Icon(Icons.favorite, color: Color(0xFFF4D06F)),
          ),
          Center(
            child: Container(
              width: 105,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bolt, color: Color(0xFFE9401A), size: 28),
                  SizedBox(height: 18),
                  Icon(Icons.ev_station, color: Colors.black87, size: 46),
                  SizedBox(height: 18),
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF1D1D1D),
                    child: Icon(Icons.power, color: Color(0xFFF4D06F), size: 18),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 18,
            left: 18,
            child: _badge('AVAILABLE'),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Vortex Station X-1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          '0.8 miles away • 4.9 ★ (124)',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.88),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF2F8F5B),
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFF4D06F), size: 20),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _detailTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF181818),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF4D06F).withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: const Color(0xFFF4D06F), size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}