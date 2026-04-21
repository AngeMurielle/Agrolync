import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Core/Constants/colors.dart';
// Corrected the double slash in the import path
import 'package:flutter_agrolync_pro/Core/Constants/dimensions.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

class AppDrawer extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const AppDrawer({super.key, this.onNavigate});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String selectedItem = "Home"; // Track selected drawer item

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
            Icons.home_outlined,
            "Home",
            isActive: selectedItem == "Home",
            onTap: () {
              setState(() => selectedItem = "Home");
              Navigator.pop(context);
              widget.onNavigate?.call(0);
            },
          ),
          _drawerItem(
            context,
            Icons.storefront_outlined,
            "Marketplace",
            isActive: selectedItem == "Marketplace",
            onTap: () {
              setState(() => selectedItem = "Marketplace");
              Navigator.pop(context);
              widget.onNavigate?.call(1);
            },
          ),
          _drawerItem(
            context,
            Icons.shopping_bag_outlined,
            "My Orders",
            isActive: selectedItem == "My Orders",
            onTap: () {
              setState(() => selectedItem = "My Orders");
              Navigator.pop(context);
              widget.onNavigate?.call(2);
            },
          ),
          _drawerItem(
            context,
            Icons.account_balance_wallet_outlined,
            "Wallet",
            isActive: selectedItem == "Wallet",
            onTap: () {
              setState(() => selectedItem = "Wallet");
              Navigator.pop(context);
              widget.onNavigate?.call(2);
            },
          ),
          //const Spacer(),

          _drawerItem(
            context,
            Icons.settings_outlined,
            "Settings",
            isActive: selectedItem == "Settings",
            onTap: () {
              setState(() => selectedItem = "Settings");
              Navigator.pop(context);
              widget.onNavigate?.call(3);
            },
          ),
          const SizedBox(height: 10),
          const Divider(),
          _drawerItem(
            context,
            Icons.logout,
            "SIGN OUT",
            isActive: false,
            onTap: () => _showSignOutDialog(context),
            isSignOut: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
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
          // Profile Image with circular styling
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/ange1.jpeg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.white.withOpacity(0.2),
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text("John Math.",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 4),
          const Text("VERIFIED PROVIDER",
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                  letterSpacing: 0.5)),
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
        title: const Text("Sign Out",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to log out of AgroLync?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignUpScreen()),
              (route) => false,
            ),
            child: const Text("Logout",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
