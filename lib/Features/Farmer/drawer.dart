import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Core/Constants/colors.dart';
import 'package:flutter_agrolync_pro/Core/Constants/dimensions.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';

class DrawerPage extends StatelessWidget {
  final String initialSelectedItem;
  const DrawerPage({super.key, this.initialSelectedItem = 'Home'});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _drawerItem(
            context,
            Icons.home,
            'Home',
            isActive: _isItemActive(context, 'Home'),
            onTap: () {
              _handleNavigation(context, 'Home', 0);
            },
          ),
          _drawerItem(
            context,
            Icons.storefront_outlined,
            'Marketplace',
            isActive: _isItemActive(context, 'Marketplace'),
            onTap: () {
              _handleNavigation(context, 'Marketplace', 1);
            },
          ),
          _drawerItem(
            context,
            Icons.shopping_bag_outlined,
            'My Orders',
            isActive: _isItemActive(context, 'My Orders'),
            onTap: () {
              _handleNavigation(context, 'My Orders', 2);
            },
          ),
          _drawerItem(
            context,
            Icons.account_balance_wallet_outlined,
            'Wallet',
            isActive: _isItemActive(context, 'Wallet'),
            onTap: () {
              _handleNavigation(context, 'Wallet', 3);
            },
          ),
          const SizedBox(height: 10),
          const Divider(),
          _drawerItem(
            context,
            Icons.person_outline,
            'Profile',
            isActive: _isItemActive(context, 'Profile'),
            onTap: () {
              _handleNavigation(context, 'Profile', 4);
            },
          ),
          const SizedBox(height: 10),
          _drawerItem(
            context,
            Icons.logout,
            'SIGN OUT',
            isActive: false,
            onTap: () => _showSignOutDialog(context),
            isSignOut: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  bool _isItemActive(BuildContext context, String item) {
    try {
      final navProvider = context.read<FarmerNavigationProvider>();
      return navProvider.selectedDrawerItem == item;
    } catch (e) {
      return initialSelectedItem == item;
    }
  }

  void _handleNavigation(BuildContext context, String item, int index) {
    Navigator.pop(context);
    try {
      final navProvider = context.read<FarmerNavigationProvider>();
      navProvider.setDrawerItem(item);
      navProvider.setTabIndex(index);
    } catch (e) {
      // Fallback - just close the drawer
      debugPrint('Navigation provider error: $e');
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.person,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white.withValues(alpha: 0.2),
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ange Murielle',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'VERIFIED FARMER',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Balance: 14,250.00 XAF',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context,
    IconData icon,
    String title, {
    required bool isActive,
    required VoidCallback onTap,
    bool isSignOut = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryGreen : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSignOut
              ? Colors.red
              : (isActive ? Colors.white : AppColors.textDark),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSignOut
                ? Colors.red
                : (isActive ? Colors.white : AppColors.textDark),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign Out',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to log out of AgroLync?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
              (route) => false,
            ),
            child: const Text('Logout',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
