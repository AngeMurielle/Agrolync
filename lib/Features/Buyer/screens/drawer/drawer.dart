import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  static const int indexMarketplace = 0;
  static const int indexOrders = 1;
  static const int indexWallet = 2;
  static const int indexSettings = 3;

  final Color brandGreen = const Color(0xFF015E38);

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        _watchBottomNavigationProvider(context)?.currentIndex ?? -1;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header with your asset image
          _buildDrawerHeader(),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: [
                _buildMenuItem(
                  icon: Icons.storefront_rounded,
                  title: "Marketplace",
                  isActive: currentIndex == indexMarketplace,
                  onTap: () => _selectTab(context, indexMarketplace),
                ),
                _buildMenuItem(
                  icon: Icons.shopping_bag_outlined,
                  title: "My Orders",
                  isActive: currentIndex == indexOrders,
                  onTap: () => _selectTab(context, indexOrders),
                ),
                _buildMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: "Wallet",
                  isActive: currentIndex == indexWallet,
                  onTap: () => _selectTab(context, indexWallet),
                ),
                const Divider(height: 40),
                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: "Settings",
                  isActive: currentIndex == indexSettings,
                  onTap: () => _selectTab(context, indexSettings),
                ),
                _buildMenuItem(
                  icon: Icons.logout_outlined,
                  title: "Sign Out",
                  titleColor: brandGreen,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Sign Out"),
                        content:
                            const Text("Are you sure you want to log out?"),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text("Cancel")),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen()));
                            },
                            child: const Text("Logout",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _selectTab(BuildContext context, int tabIndex) {
    Navigator.pop(context);
    final provider = _maybeReadBottomNavigationProvider(context);
    if (provider != null) {
      provider.setIndex(tabIndex);
      return;
    }

    switch (tabIndex) {
      case indexMarketplace:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case indexOrders:
        Navigator.pushReplacementNamed(context, '/orders');
        break;
      case indexWallet:
        Navigator.pushReplacementNamed(context, '/wallet');
        break;
      case indexSettings:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
      default:
        break;
    }
  }

  BottomNavigationProvider? _maybeReadBottomNavigationProvider(
      BuildContext context) {
    try {
      return context.read<BottomNavigationProvider>();
    } catch (_) {
      return null;
    }
  }

  BottomNavigationProvider? _watchBottomNavigationProvider(
      BuildContext context) {
    try {
      return context.watch<BottomNavigationProvider>();
    } catch (_) {
      return null;
    }
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 60, 20, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage('assets/images/ange1.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text("Green Valley Co.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Text("VERIFIED BUYER",
              style: TextStyle(
                  color: Color(0xFF015E38),
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const Text("PREMIUM MEMBER",
              style: TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String title,
      bool isActive = false,
      Color? titleColor,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isActive ? brandGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon,
            color: titleColor ?? (isActive ? Colors.white : Colors.black87)),
        title: Text(title,
            style: TextStyle(
                color: titleColor ?? (isActive ? Colors.white : Colors.black87),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        onTap: onTap,
      ),
    );
  }
}
