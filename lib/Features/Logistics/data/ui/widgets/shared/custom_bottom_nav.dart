import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Core/Constants/colors.dart';


class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key, 
    required this.currentIndex, 
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.grid_view_rounded, "Home", 0),
            _navItem(Icons.map_outlined, "Market", 1),
            const SizedBox(width: 40), // Space for FAB
            _navItem(Icons.account_balance_wallet_outlined, "Wallet", 2),
            _navItem(Icons.person_outline, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    bool active = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? AppColors.primaryGreen : Colors.grey),
          Text(label, style: TextStyle(
            color: active ? AppColors.primaryGreen : Colors.grey,
            fontSize: 10,
            fontWeight: active ? FontWeight.bold : FontWeight.normal
          )),
        ],
      ),
    );
  }
}