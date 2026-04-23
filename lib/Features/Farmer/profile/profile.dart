import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/profile/setting.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';
import 'dart:io';

// Internal Imports
// ignore: library_prefixes
import 'personalInfo.dart' as personalInfo;
// ignore: library_prefixes
import 'FarmDetails.dart' as farmDetails;
// ignore: library_prefixes
import 'PaymentMethod.dart' as paymentMethod;
// ignore: library_prefixes
import 'LanguageSelection.dart' as languageSelection;
// ignore: library_prefixes
import 'SupportHelp.dart' as supportHelp;
// ignore: library_prefixes
import '../drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final String _userName = "Ange Awagoum";
  final String _location = "Buea, Cameroon";
  final Color brandGreen = const Color(0xFF026139);

  // --- FIXED IMAGE PICKER LOGIC ---
  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800, // Optimized for mobile performance
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile picture updated!")),
          );
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text("Could not access gallery. Check app permissions.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      drawer: const DrawerPage(initialSelectedItem: 'Profile'),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () {
            final navProvider = context.read<FarmerNavigationProvider>();
            navProvider.setIndex(0); // Set to Home index
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // --- PROFILE PICTURE SECTION ---
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _image != null
                          ? FileImage(_image!)
                          : const NetworkImage(
                                  'https://i.pravatar.cc/150?u=elias')
                              as ImageProvider,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: brandGreen,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            Text(
              _userName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                Text(_location, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 35),

            // --- NAVIGATION LIST ---
            _buildProfileCard([
              _profileTile(Icons.person_outline, "Personal Information", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const personalInfo.PersonalInfoPage()));
              }),
              _profileTile(Icons.agriculture_outlined, "Farm Details", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const farmDetails.FarmDetailsPage()));
              }),
              _profileTile(Icons.payments_outlined, "Payment Methods", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const paymentMethod.PaymentMethodPage()));
              }),
            ]),

            const SizedBox(height: 24),

            _buildProfileCard([
              _profileTile(Icons.language, "Language Selection", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const languageSelection.LanguagePage()));
              }, trailingText: "English"),
              _profileTile(Icons.help_outline, "Support/Help", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const supportHelp.SupportHelpPage()));
              }),
            ]),

            const SizedBox(height: 35),

            // --- FIXED LOGOUT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 60, // Increased height as requested
              child: TextButton.icon(
                onPressed: () => _showLogoutDialog(context),
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.08),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "AgroLync v2.4.1",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildProfileCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(children: children),
      ),
    );
  }

  Widget _profileTile(IconData icon, String title, VoidCallback onTap,
      {String? trailingText}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: brandGreen.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: brandGreen, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText,
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Log Out"),
        content: const Text("Are you sure you want to log out of AgroLync?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Add your actual logout/auth clearing logic here
            },
            child: const Text("Log Out", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
