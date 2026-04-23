import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/drawer/drawer.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/wallet.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/Address.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/contactsupport.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/helpcenter.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/PersonalDetails.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  String _selectedLanguage = "ENGLISH";
  XFile? _pickedFile;
  File? _profileImage;
  final Color _brandGreen = const Color(0xFF015E38);

  // --- IMAGE PICKER LOGIC (Same as Farmer Profile) ---
  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _getImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
          _profileImage = File(pickedFile.path);
        });
        // Update provider immediately after selecting the image (like Farmer profile)
        if (mounted) {
          context
              .read<BottomNavigationProvider>()
              .setProfileImage(pickedFile.path);
        }
        // Call upload function after selecting the image
        await _uploadImage(pickedFile);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Could not access image source. Check permissions."),
          ),
        );
      }
    }
  }

  Future<void> _uploadImage(XFile imageFile) async {
    // Show loading indicator
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
            const Text("Uploading image..."),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    try {
      // Simulate network delay for upload
      await Future.delayed(const Duration(seconds: 2));

      // Here you would normally perform the actual upload to your server/Supabase
      // Example:
      // await supabase.storage.from('avatars').upload('path/to/image.png', imageFile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Profile picture uploaded successfully!",
                style: TextStyle(color: Colors.white)),
            backgroundColor: _brandGreen,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image. Please try again."),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => Consumer<BottomNavigationProvider>(
            builder: (context, navProvider, child) {
              final profileImagePath = navProvider.profileImagePath;
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        profileImagePath != null && profileImagePath.isNotEmpty
                            ? (kIsWeb
                                    ? NetworkImage(profileImagePath)
                                    : FileImage(File(profileImagePath)))
                                as ImageProvider
                            : const AssetImage('assets/images/ange1.jpeg'),
                  ),
                ),
              );
            },
          ),
        ),
        title: const Text(
          "AgroLync",
          style:
              TextStyle(color: Color(0xFF015E38), fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.grey),
            onPressed: () => _showNotifications(),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildStatCard("ACTIVE ORDERS", "12", null),
              const SizedBox(width: 16),
              _buildStatCard("ECO SCORE", "94", Icons.eco),
            ],
          ),
          const SizedBox(height: 30),
          _buildSectionHeader("ACCOUNT & LOGISTICS"),
          _buildGroupedContainer([
            _buildCustomTile(Icons.person_outline, "Personal Details",
                "Edit your info", const PersonalDetailsPage()),
            _buildCustomTile(Icons.location_on_outlined, "Delivery Addresses",
                "2 saved locations", const AddressPage()),

            // 🟢 UPDATED: Routes to your specific WalletScreen file
            _buildCustomTile(
              Icons.account_balance_wallet_outlined,
              "Wallet & Payments",
              "Manage payment methods",
              const Wallet(),
            ),
          ]),
          const SizedBox(height: 25),
          _buildSectionHeader("PREFERENCES"),
          _buildGroupedContainer([
            _buildLanguageTile(),
            _buildNotificationTile(),
          ]),
          const SizedBox(height: 25),
          _buildSectionHeader("SUPPORT"),
          _buildGroupedContainer([
            _buildCustomTile(Icons.support_agent, "Contact Support",
                "Get help from team", const ContactSupportPage()),
            _buildCustomTile(Icons.help_outline, "Help Center",
                "FAQs and guides", const HelpCenterPage()),
          ]),
          const SizedBox(height: 32),
          Center(
            child: TextButton(
              onPressed: () => _showLogoutDialog(context),
              child: const Text(
                "SIGN OUT",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _brandGreen,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _pickedFile != null
                      ? (kIsWeb
                          ? NetworkImage(_pickedFile!.path) as ImageProvider
                          : FileImage(File(_pickedFile!.path)) as ImageProvider)
                      : null,
                  child: _pickedFile == null
                      ? const Icon(Icons.person_add_alt_1,
                          color: Colors.white, size: 30)
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: _brandGreen, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: _brandGreen,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Awagoum Murielle",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Premium Member since 2022",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    _HeaderBadge(label: "VERIFIED"),
                    SizedBox(width: 8),
                    _HeaderBadge(label: "LVL 4"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData? icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Icon(icon, color: const Color(0xFF015E38), size: 20),
                if (icon != null) const SizedBox(width: 4),
                Text(value,
                    style: const TextStyle(
                        color: Color(0xFF015E38),
                        fontSize: 24,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupedContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(children: children),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(title,
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5)),
    );
  }

  Widget _buildCustomTile(
      IconData icon, String title, String subtitle, Widget targetPage) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color(0xFFE9F5EF),
            borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: const Color(0xFF015E38), size: 20),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle,
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => targetPage)),
    );
  }

  Widget _buildLanguageTile() {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color(0xFFE9F5EF),
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.language, color: Color(0xFF015E38), size: 20),
      ),
      title: const Text("Language",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: DropdownButton<String>(
        value: _selectedLanguage,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down, size: 18),
        onChanged: (String? newValue) =>
            setState(() => _selectedLanguage = newValue!),
        items: <String>['ENGLISH', 'FRANÇAIS']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationTile() {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color(0xFFE9F5EF),
            borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.notifications_none,
            color: Color(0xFF015E38), size: 20),
      ),
      title: const Text("Notifications",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      trailing: CupertinoSwitch(
        value: _notificationsEnabled,
        activeTrackColor: const Color(0xFF015E38),
        onChanged: (val) => setState(() => _notificationsEnabled = val),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Sign Out"),
        content: const Text("Are you sure you want to log out of AgroLync?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
              );
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListTile(title: Text('Payment completed successfully')),
            ListTile(title: Text('New offer: 10% off fertilizers')),
            ListTile(title: Text('Reminder: pending delivery charges')),
          ],
        ),
      ),
    );
  }
}

class _HeaderBadge extends StatelessWidget {
  final String label;
  const _HeaderBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white24, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }
}
