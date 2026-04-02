/*import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/available_shipments_screen.dart';
import 'screens/completed_trips_screen.dart';
import 'screens/profile_vehicle_screen.dart';

class LogisticsMainWrapper extends StatefulWidget {
  const LogisticsMainWrapper({super.key});

  @override
  State<LogisticsMainWrapper> createState() => _LogisticsMainWrapperState();
}

class _LogisticsMainWrapperState extends State<LogisticsMainWrapper> {
  int _currentIndex = 0;
  final Color brandGreen = const Color(0xFF015E38);

  // List of screens corresponding to the Bottom Nav
  final List<Widget> _pages = [
    const LogisticsDashboard(),     // Home (L1)
    const AvailableShipmentsScreen(), // Market (L2a)
    const EarningsWalletScreen(),     // Wallet (L3a)
    const ProfileVehicleScreen(),     // Profile (L4)
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showScanner(context),
        backgroundColor: brandGreen,
        elevation: 4,
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.grid_view_rounded, "Home", 0),
            _buildNavItem(Icons.map_outlined, "Market", 1),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(Icons.account_balance_wallet_outlined, "Wallet", 2),
            _buildNavItem(Icons.person_outline, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return InkWell(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? brandGreen : Colors.grey,
            size: 26,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? brandGreen : Colors.grey,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showScanner(BuildContext context) {
    // Functional placeholder for the QR Scanner
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(width: 40, height: 4, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text("Scan Shipment QR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Spacer(),
            Icon(Icons.qr_code_2, size: 200, color: brandGreen.withOpacity(0.2)),
            const Spacer(),
            const Text("Align QR code within the frame to verify pickup"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
*/