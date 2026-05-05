import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'charging_status_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainShellState();
}

class _MainShellState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ExploreScreen(),
    /*ChargingStatusScreen(),
    WalletScreen(),
    ProfileScreen(), */
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101010),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF151515),
          border: Border(
            top: BorderSide(color: Colors.white10, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFF4D06F),
          unselectedItemColor: Colors.white38,
          selectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt_outlined),
              activeIcon: Icon(Icons.bolt),
              label: 'Sessions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}