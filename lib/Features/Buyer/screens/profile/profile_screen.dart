import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  File? _profileImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
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
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF015E38)),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
        color: const Color(0xFF015E38),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      height: 80,
                      color: Colors.white24,
                      child: _profileImage != null
                          ? Image.file(_profileImage!, fit: BoxFit.cover)
                          : const Icon(Icons.person_add_alt_1,
                              color: Colors.white, size: 35),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt,
                        size: 14, color: Color(0xFF015E38)),
                  ),
                )
              ],
            ),
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
