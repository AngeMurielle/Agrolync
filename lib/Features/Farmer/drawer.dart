import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Menu', style: TextStyle(color: Colors.black)),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF026139)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 30, backgroundImage: AssetImage(AppImages.person)),
                const SizedBox(height: 10),
                const Text("Ange Murielle", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text("Farmer Pro", style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              // Navigate to settings page
              // For now, just pop
              Navigator.of(context).pop();
            }
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Support"),
            onTap: () {
              // Navigate to support page
              Navigator.of(context).pop();
            }
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              // Handle logout
              Navigator.of(context).pop();
            }
          ),
        ],
      ),
    );
  }
}