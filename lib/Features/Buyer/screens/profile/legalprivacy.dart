import 'package:flutter/material.dart';
class LegalPrivacyPage extends StatelessWidget {
  const LegalPrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brandGreen = Color(0xFF015E38);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Legal & Privacy", 
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildLegalSection(
            Icons.security_outlined,
            "Privacy Policy", 
            "Last updated: March 2026\n\nWe collect your location only to facilitate accurate farm-to-door deliveries. Your data is encrypted and never sold to third parties."
          ),
          const SizedBox(height: 30),
          _buildLegalSection(
            Icons.gavel_outlined,
            "Terms of Service", 
            "By using AgroLync, you agree to our fair-pricing model. Users found manipulating real-time market prices will have their accounts suspended."
          ),
          const SizedBox(height: 30),
          _buildLegalSection(
            Icons.verified_user_outlined,
            "Cookie Policy", 
            "We use minimal cookies to remember your login session and language preference (English/French)."
          ),
          const SizedBox(height: 50),
          
          // 🛡️ SECURITY FOOTER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.shield_rounded, color: brandGreen),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "AgroLync uses 256-bit SSL encryption for all transactions.",
                    style: TextStyle(fontSize: 11, color: Color(0xFF475569)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text("App Version 2.1.0", 
              style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalSection(IconData icon, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF015E38)),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          ],
        ),
        const SizedBox(height: 12),
        Text(content, style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.6)),
      ],
    );
  }
}