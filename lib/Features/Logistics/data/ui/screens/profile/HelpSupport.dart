import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  final Color primaryGreen = const Color(0xFF015E38);
  final Color whatsappGreen = const Color(0xFF25D366);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Help & Support",
            style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  _buildSectionLabel("DIRECT SUPPORT"),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildContactCard(
                        context,
                        Icons.message_rounded,
                        "WhatsApp",
                        "Chat with us",
                        whatsappGreen,
                        () => _simulateContact(context, "WhatsApp Support"),
                      ),
                      const SizedBox(width: 15),
                      _buildContactCard(
                        context,
                        Icons.headset_mic_rounded,
                        "Call Center",
                        "Talk to an agent",
                        primaryGreen,
                        () => _simulateContact(context, "Voice Support"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildSectionLabel("FREQUENTLY ASKED QUESTIONS"),
                  const SizedBox(height: 12),
                  _buildFaqItem(
                    "How do I withdraw my earnings?",
                    "Go to your Wallet tab and click 'Cash Out'. You can withdraw via Orange Money or MTN MoMo. Processing usually takes less than 24 hours.",
                  ),
                  _buildFaqItem(
                    "What if I encounter a road block?",
                    "Safety first. Use the 'Emergency' button on your active trip screen to alert AgroLync dispatchers and local authorities immediately.",
                  ),
                  _buildFaqItem(
                    "How are fuel bonuses calculated?",
                    "Bonuses are based on trip distance, load weight, and route efficiency. These are credited to your 'Incentives' balance immediately after delivery.",
                  ),
                  const SizedBox(height: 40),
                  _buildAppVersionInfo(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
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

  Widget _buildSearchHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How can we help you?",
            style: TextStyle(
                fontSize: 22, color: primaryGreen, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              hintText: "Search for topics or questions...",
              hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFF1F3F4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
          color: Colors.grey[400],
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2),
    );
  }

  Widget _buildContactCard(BuildContext context, IconData icon, String title,
      String subtitle, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                  color: color.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        iconColor: primaryGreen,
        collapsedIconColor: Colors.grey,
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        title: Text(
          question,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        children: [
          Text(
            answer,
            style:
                TextStyle(color: Colors.grey[700], fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAppVersionInfo() {
    return Center(
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 20),
          Text(
            "AgroLync Pro v2.0.1",
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          const SizedBox(height: 4),
          const Text(
            "Reliable Logistics for Cameroon",
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  void _simulateContact(BuildContext context, String method) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Connecting to AgroLync $method..."),
        backgroundColor: primaryGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
