import 'package:flutter/material.dart';
//import 'package:flutter_agrolync_pro/Core/Constants/colors.dart';
import 'dashboard_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/market_screen.dart'; // Create this or use placeholder
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/wallet/wallet.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/profile/profile_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class MainNavWrapper extends StatefulWidget {
  final int initialIndex;

  const MainNavWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  late int _selectedIndex;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _screens = [
      DashboardScreen(onNavigate: _navigateTo),
      LogisticsMarketScreen(onNavigate: _navigateTo),
      EarningsWalletPage(onNavigate: _navigateTo),
      LogisticsProfilePage(onNavigate: _navigateTo),
    ];
  }

  void _navigateTo(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}
