// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../states/wallet_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: walletState,
      builder: (context, _) {
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
                  const SizedBox(height: 26),
                  _buildBalanceCard(),
                  const SizedBox(height: 18),
                  _buildActionButtons(),
                  const SizedBox(height: 30),
                  _buildSectionHeader(),
                  const SizedBox(height: 14),
                  _transactionTile(
                    title: 'Charging Payment',
                    subtitle: 'North Star Hub • Just now',
                    amount: '-\$12.45',
                    status: 'PAID',
                    icon: Icons.ev_station,
                    isIncome: false,
                  ),
                  const SizedBox(height: 12),
                  _transactionTile(
                    title: 'Downtown Supercharger',
                    subtitle: 'May 24, 2024 • 42 min',
                    amount: '-\$32.40',
                    status: 'USED',
                    icon: Icons.ev_station,
                    isIncome: false,
                  ),
                  const SizedBox(height: 12),
                  _transactionTile(
                    title: 'Airport Rapid Port',
                    subtitle: 'May 21, 2024 • 18 min',
                    amount: '-\$12.85',
                    status: 'USED',
                    icon: Icons.ev_station,
                    isIncome: false,
                  ),
                  const SizedBox(height: 12),
                  _transactionTile(
                    title: 'Top Up • Visa',
                    subtitle: 'May 19, 2024 • 09:12 AM',
                    amount: '+\$200.00',
                    status: 'COMPLETED',
                    icon: Icons.credit_card,
                    isIncome: true,
                  ),
                  const SizedBox(height: 12),
                  _transactionTile(
                    title: 'Greenway Plaza',
                    subtitle: 'May 15, 2024 • 55 min',
                    amount: '-\$45.10',
                    status: 'USED',
                    icon: Icons.ev_station,
                    isIncome: false,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.auto_awesome, color: Color(0xFFF4D06F), size: 22),
        const SizedBox(width: 8),
        const Text(
          'Sparky',
          style: TextStyle(
            color: Color(0xFFF4D06F),
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        const Spacer(),
        CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFF1F1F1F),
          child: Icon(
            Icons.person,
            color: Colors.white.withOpacity(0.85),
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE6A2), Color(0xFFF4D06F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4D06F).withOpacity(0.22),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOTAL BALANCE',
            style: TextStyle(
              color: Color(0xFF5A4300),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${walletState.balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text(
                  'USD',
                  style: TextStyle(
                    color: Color(0xFF5A4300),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.account_balance_wallet,
                color: Color(0x665A4300),
                size: 34,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: _walletActionButton(
            label: 'TOP UP',
            icon: Icons.add_circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _walletActionButton(
            label: 'TRANSFER',
            icon: Icons.send_rounded,
          ),
        ),
      ],
    );
  }

  Widget _walletActionButton({
    required String label,
    required IconData icon,
  }) {
    return SizedBox(
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: const Color(0xFFF4D06F), size: 20),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 0.7,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B1B1B),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white10),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return const Row(
      children: [
        Text(
          'Recent Sessions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Spacer(),
        Text(
          'VIEW ALL',
          style: TextStyle(
            color: Color(0xFFF4D06F),
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }

  Widget _transactionTile({
    required String title,
    required String subtitle,
    required String amount,
    required String status,
    required IconData icon,
    required bool isIncome,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFF4D06F).withOpacity(0.12),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: const Color(0xFFF4D06F), size: 22),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  color: isIncome
                      ? const Color(0xFF86E08C)
                      : const Color(0xFFFFB4A8),
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}