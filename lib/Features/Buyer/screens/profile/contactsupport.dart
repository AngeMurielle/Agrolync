import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSupportPage extends StatefulWidget {
  const ContactSupportPage({super.key});

  @override
  State<ContactSupportPage> createState() => _ContactSupportPageState();
}

class _ContactSupportPageState extends State<ContactSupportPage> {
  final Color brandGreen = const Color(0xFF015E38);

  // Updated with the full international format
  final String displaySupportNumber = "+237 682 087 287";
  final String rawSupportNumber = "237682087287";

  // 📞 1. PHONE CALL FUNCTIONALITY
  Future<void> _makeCall() async {
    final Uri uri = Uri(scheme: 'tel', path: "+$rawSupportNumber");
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        _showErrorSnackBar(
            "Could not open dialer. Please call $displaySupportNumber manually.");
      }
    } catch (e) {
      _showErrorSnackBar("An error occurred while trying to call.");
    }
  }

  // 💬 2. WHATSAPP FUNCTIONALITY (Fully Functional)
  Future<void> _launchWhatsApp() async {
    final String url =
        "https://wa.me/$rawSupportNumber?text=Hello AgroLync Support, I need help with...";
    final Uri uri = Uri.parse(url);

    try {
      // mode: LaunchMode.externalApplication ensures it opens the WhatsApp App
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar("WhatsApp is not installed on this device.");
      }
    } catch (e) {
      _showErrorSnackBar("An error occurred opening WhatsApp.");
    }
  }

  // ✉️ 3. EMAIL FUNCTIONALITY
  Future<void> _sendEmail() async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: 'support@agrolync.com',
      query: 'subject=AgroLync Support Request&body=Hello AgroLync Team,',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: brandGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Contact Support",
            style: TextStyle(
                color: brandGreen, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // HEADER
            Column(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                    color: brandGreen.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.support_agent_rounded,
                      size: 55, color: brandGreen),
                ),
                const SizedBox(height: 24),
                const Text("We're here to help",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B))),
                const SizedBox(height: 8),
                const Text(
                  "Reach out via any of the channels below. We typically respond within minutes.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xFF64748B), fontSize: 13, height: 1.5),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // CALL CARD
            _buildContactCard(
              icon: Icons.phone_in_talk_rounded,
              title: "Call Hotline",
              subtitle: displaySupportNumber,
              color: brandGreen,
              onTap: _makeCall,
            ),

            // WHATSAPP CARD
            _buildContactCard(
              icon: Icons.chat_bubble_rounded,
              title: "WhatsApp Chat",
              subtitle: "Instant Messaging",
              color: const Color(0xFF25D366),
              onTap: _launchWhatsApp,
            ),

            // EMAIL CARD
            _buildContactCard(
              icon: Icons.alternate_email_rounded,
              title: "Email Us",
              subtitle: "support@agrolync.com",
              color: Colors.blueAccent,
              onTap: _sendEmail,
            ),

            const SizedBox(height: 40),

            // SECURITY TAG
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.verified_outlined,
                    size: 14, color: Colors.grey.shade400),
                const SizedBox(width: 6),
                Text("End-to-end encrypted support",
                    style:
                        TextStyle(color: Colors.grey.shade400, fontSize: 11)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(subtitle,
                          style: const TextStyle(
                              color: Color(0xFF64748B), fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    color: Color(0xFFCBD5E1), size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
