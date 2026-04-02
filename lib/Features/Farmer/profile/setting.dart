import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkTextColor = Color(0xFF1E293B);
  static const Color subTextColor = Color(0xFF64748B);
  static const Color bgGrey = Color(0xFFF8FAFC);
  static const Color dangerRed = Color(0xFFEF4444);

  bool _orderUpdates = true;
  bool _priceAlerts = true;
  bool _weatherAlerts = false;
  bool _biometricLogin = true;
  bool _offlineMaps = false;

  @override
  Widget build(BuildContext context) {
    // Using MediaQuery to ensure we handle different screen heights
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: bgGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        // Added more bottom padding to ensure the last card isn't cramped
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          children: [
            _buildSectionHeader("APP SETTINGS"),
            _buildSettingGroup(
              height: screenHeight * 0.25, // Occupies 25% of screen height
              children: [
                _buildSwitchTile(
                  icon: Icons.inventory_2_outlined,
                  title: "Order Updates",
                  value: _orderUpdates,
                  onChanged: (v) => setState(() => _orderUpdates = v),
                ),
                const Divider(height: 1, indent: 60), // Added dividers for better separation
                _buildSwitchTile(
                  icon: Icons.trending_up,
                  title: "Price Alerts",
                  value: _priceAlerts,
                  onChanged: (v) => setState(() => _priceAlerts = v),
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.water_drop_outlined,
                  title: "Weather Alerts",
                  value: _weatherAlerts,
                  onChanged: (v) => setState(() => _weatherAlerts = v),
                ),
              ],
            ),
            
            const SizedBox(height: 25), // Increased space between sections
            
            _buildSectionHeader("ACCOUNT SECURITY"),
            _buildSettingGroup(
              height: screenHeight * 0.18, // Occupies 18% of screen height
              children: [
                _buildNavigationTile(
                  icon: Icons.lock_outline,
                  title: "Change Password",
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.fingerprint,
                  title: "Biometric Login",
                  value: _biometricLogin,
                  onChanged: (v) => setState(() => _biometricLogin = v),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            _buildSectionHeader("DATA & STORAGE"),
            _buildSettingGroup(
              height: screenHeight * 0.18, 
              children: [
                _buildActionTile(
                  icon: Icons.cleaning_services_outlined,
                  title: "Clear Cache",
                  subtitle: "Free up 124 MB of space",
                  trailing: const Icon(Icons.delete_outline, color: subTextColor),
                  onTap: () {},
                ),
                const Divider(height: 1, indent: 60),
                _buildSwitchTile(
                  icon: Icons.map_outlined,
                  title: "Offline Maps",
                  value: _offlineMaps,
                  onChanged: (v) => setState(() => _offlineMaps = v),
                ),
              ],
            ),
            
            const SizedBox(height: 25),
            
            _buildSectionHeader("DANGER ZONE", color: dangerRed),
            _buildSettingGroup(
              height: screenHeight * 0.12, // Danger zone card height
              children: [
                _buildActionTile(
                  icon: Icons.no_accounts_outlined,
                  iconBgColor: const Color(0xFFFFF1F2),
                  iconColor: dangerRed,
                  title: "Delete Account",
                  titleColor: dangerRed,
                  subtitle: "Permanently remove all your data",
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color color = brandGreen}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Text(
        title,
        style: TextStyle(
          color: color.withOpacity(0.8), 
          fontWeight: FontWeight.w800, 
          fontSize: 13, 
          letterSpacing: 1.2
        ),
      ),
    );
  }

  // Updated Helper with Height property
  Widget _buildSettingGroup({required List<Widget> children, double? height}) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      // Use MainAxisAlignment.spaceEvenly to stretch tiles across the height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({required IconData icon, required String title, required bool value, required ValueChanged<bool> onChanged}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: _buildIcon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: darkTextColor, fontSize: 16)),
      trailing: Switch.adaptive(
        value: value,
        activeColor: brandGreen,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildNavigationTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: _buildIcon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: darkTextColor, fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: subTextColor),
      onTap: onTap,
    );
  }

  Widget _buildActionTile({
    required IconData icon, 
    required String title, 
    required String subtitle, 
    Widget? trailing, 
    required VoidCallback onTap,
    Color? iconBgColor,
    Color? iconColor,
    Color? titleColor,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: _buildIcon(icon, bgColor: iconBgColor, iconColor: iconColor),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, color: titleColor ?? darkTextColor, fontSize: 16)),
      subtitle: Text(subtitle, style: const TextStyle(color: subTextColor, fontSize: 13)),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildIcon(IconData icon, {Color? bgColor, Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: iconColor ?? brandGreen, size: 24),
    );
  }
}