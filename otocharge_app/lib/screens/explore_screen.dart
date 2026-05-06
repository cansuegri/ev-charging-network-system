// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(), // context parametresi ve ikon kaldırıldı
              const SizedBox(height: 24),
              _buildSearchBar(),
              const SizedBox(height: 18),
              Expanded(child: _buildMapArea()),
              const SizedBox(height: 18),
              _buildLiveStationCard(), // Firestore'dan veri çeken yapımız
            ],
          ),
        ),
      ),
    );
  }

  // --- SADECE LOGO KALDI ---
  Widget _buildHeader() {
    return const Row(
      children: [
        Icon(Icons.star_rounded, color: Color(0xFFF4D06F), size: 24),
        SizedBox(width: 8),
        Text(
          'SPARKY',
          style: TextStyle(
            color: Color(0xFFF4D06F),
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          const Icon(Icons.search_rounded, color: Colors.white38, size: 24),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Find a station',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 42,
            height: 42,
            margin: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFFF4D06F),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white10),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _FakeMapPainter())),
          Center(
            child: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF4D06F).withOpacity(0.18),
                border: Border.all(color: const Color(0xFFF4D06F), width: 2),
              ),
              child: const Icon(
                Icons.ev_station_rounded,
                color: Color(0xFFF4D06F),
                size: 28,
              ),
            ),
          ),
          Positioned(
            top: 18,
            left: 18,
            child: _buildMapChip('1 station nearby'),
          ),
          Positioned(
            bottom: 18,
            right: 18,
            child: _buildLocationButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildMapChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildLocationButton() {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFFF4D06F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Icon(
        Icons.my_location_rounded,
        color: Colors.black,
        size: 22,
      ),
    );
  }

  Widget _buildLiveStationCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Stations').snapshots(),
      builder: (context, snapshot) {

        // --- HATA YAKALAYICI ---
        if (snapshot.hasError) {
          print("FİREBASE HATASI: ${snapshot.error}"); // Terminalde de görelim
          return Center(child: Text("Hata: ${snapshot.error}", style: const TextStyle(color: Colors.redAccent, fontSize: 12)));
        }
        // ------------------------------------

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFFF4D06F)));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("Yakında istasyon bulunamadı.", style: TextStyle(color: Colors.white)));
        }

        var stationData = snapshot.data!.docs.first.data() as Map<String, dynamic>;

        String name = stationData['name'] ?? 'Bilinmeyen İstasyon';
        String address = stationData['address'] ?? 'Adres yok';
        String speed = stationData['speed']?.toString() ?? '0';
        String price = stationData['price']?.toString() ?? '0.0';
        bool isAvailable = stationData['isAvailable'] ?? false;

        return _buildNearestStationCard(name, address, speed, price, isAvailable);
      },
    );
  }

  Widget _buildNearestStationCard(String name, String address, String speed, String price, bool isAvailable) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1B1B),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStatusBadge(isAvailable),
              const Spacer(),
              Text(
                isAvailable ? 'AVAILABLE' : 'IN USE',
                style: TextStyle(
                  color: isAvailable ? const Color(0xFF9ED99E) : Colors.redAccent,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w900,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            address,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _buildInfoBox(
                  title: 'SPEED',
                  value: speed,
                  unit: 'kW',
                  icon: Icons.bolt_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildInfoBox(
                  title: 'PRICE',
                  value: '\$$price',
                  unit: '/kWh',
                  icon: Icons.payments_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 56,
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.navigation_rounded, color: Colors.black),
              label: const Text(
                'START NAVIGATION',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.7,
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
    );
  }

  Widget _buildStatusBadge(bool isAvailable) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF4D06F).withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFF4D06F).withOpacity(0.35)),
      ),
      child: const Row(
        children: [
          Icon(Icons.near_me_rounded, color: Color(0xFFF4D06F), size: 15),
          SizedBox(width: 6),
          Text(
            'NEAREST STATION',
            style: TextStyle(
              color: Color(0xFFF4D06F),
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF242424),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFF4D06F), size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white30,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FakeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.055)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (double y = 30; y < size.height; y += 48) {
      final path = Path()
        ..moveTo(0, y)
        ..quadraticBezierTo(size.width * 0.35, y - 25, size.width, y + 18);
      canvas.drawPath(path, roadPaint);
    }

    for (double x = 20; x < size.width; x += 55) {
      final path = Path()
        ..moveTo(x, 0)
        ..quadraticBezierTo(x + 35, size.height * 0.45, x - 10, size.height);
      canvas.drawPath(path, roadPaint);
    }

    final dotPaint = Paint()
      ..color = const Color(0xFFF4D06F).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final points = [
      Offset(size.width * 0.18, size.height * 0.25),
      Offset(size.width * 0.76, size.height * 0.30),
      Offset(size.width * 0.30, size.height * 0.70),
      Offset(size.width * 0.68, size.height * 0.78),
    ];

    for (final point in points) {
      canvas.drawCircle(point, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}