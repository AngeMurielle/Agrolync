import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  final Color primaryGreen = const Color(0xFF015E38);

  // Functional State Logic
  bool _newLoads = true;
  bool _payoutAlerts = true;
  bool _appUpdates = false;
  bool _smsAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Soft background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Notification Settings",
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderHint(),
            _buildSectionLabel("DELIVERY & EARNINGS"),
            _buildToggleCard(
              icon: Icons.local_shipping_outlined,
              title: "New Load Alerts",
              subtitle: "Instant notifications for nearby agricultural loads.",
              value: _newLoads,
              onChanged: (val) => setState(() => _newLoads = val),
            ),
            _buildToggleCard(
              icon: Icons.account_balance_wallet_outlined,
              title: "Payouts & Incentives",
              subtitle: "Alerts for wallet transfers and fuel bonuses.",
              value: _payoutAlerts,
              onChanged: (val) => setState(() => _payoutAlerts = val),
            ),
            const SizedBox(height: 20),
            _buildSectionLabel("COMMUNICATION"),
            _buildToggleCard(
              icon: Icons.system_update_alt_rounded,
              title: "System Updates",
              subtitle: "Maintenance alerts and new feature news.",
              value: _appUpdates,
              onChanged: (val) => setState(() => _appUpdates = val),
            ),
            _buildToggleCard(
              icon: Icons.sms_outlined,
              title: "SMS Backup Alerts",
              subtitle: "Receive critical updates via text when offline.",
              value: _smsAlerts,
              onChanged: (val) => setState(() => _smsAlerts = val),
            ),
            const SizedBox(height: 40),
            _buildFooterNote(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: 3,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainNavWrapper(initialIndex: index),
            ),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget _buildHeaderHint() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryGreen.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: primaryGreen, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "Keep alerts enabled to ensure you don't miss high-paying loads.",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildToggleCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: SwitchListTile(
        activeColor: primaryGreen,
        contentPadding: const EdgeInsets.all(16),
        secondary: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryGreen.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: primaryGreen, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ),
        value: value,
        onChanged: (bool newValue) {
          onChanged(newValue);
          _showFeedback(title, newValue);
        },
      ),
    );
  }

  void _showFeedback(String title, bool isEnabled) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$title ${isEnabled ? 'Enabled' : 'Disabled'}"),
        backgroundColor: isEnabled ? primaryGreen : Colors.grey[800],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildFooterNote() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          "Changes are saved automatically and applied to this device only.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 11),
        ),
      ),
    );
  }
}
