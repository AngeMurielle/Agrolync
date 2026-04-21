import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this
import 'FAQDetails.dart';
import '../drawer.dart';

class SupportHelpPage extends StatelessWidget {
  const SupportHelpPage({super.key});

  static const Color brandGreen = Color(0xFF026139);
  static const Color darkBlue = Color(0xFF1E293B);

  // Helper function for WhatsApp
  Future<void> _launchWhatsApp() async {
    final Uri url = Uri.parse("https://wa.me/237682087287");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch WhatsApp');
    }
  }

  // Helper function for Phone Call
  Future<void> _makePhoneCall() async {
    final Uri url = Uri.parse("tel:682087287");
    if (!await launchUrl(url)) {
      throw Exception('Could not launch Dialer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      drawer: const DrawerPage(initialSelectedItem: 'Profile'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Support & Help",
            style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HELP HEADER CARD ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF7F2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text("How can we help today?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkBlue)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: _buildContactBtn(Icons.chat_bubble,
                              "Live Chat", true, _launchWhatsApp)),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _buildContactBtn(Icons.phone, "Call Center",
                              false, _makePhoneCall)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            const Text("FAQ Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
            const SizedBox(height: 15),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.4,
              children: [
                _buildCategoryCard(
                    context, "Crop Care & Growth", "assets/images/farm1.jpg"),
                _buildCategoryCard(
                    context, "Market & Pricing", "assets/images/prices.jpg"),
                _buildCategoryCard(
                    context, "Weather Alerts", "assets/images/wheather.jpg"),
                _buildCategoryCard(
                    context, "Account & Billing", "assets/images/account.jpg"),
              ],
            ),
            const SizedBox(height: 30),

            const Text("Popular Questions",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkBlue)),
            const SizedBox(height: 10),
            _buildQuestionTile(context, "How to track my fertilizer delivery?",
                "Go to Market > Orders to see live tracking."),
            _buildQuestionTile(context, "Setting up pest infestation alerts",
                "Enable 'Weather & Pest Alerts' in your Settings menu."),
            _buildQuestionTile(context, "Withdrawal limits for market sales",
                "Standard limits are 500,000 XAF per day."),
          ],
        ),
      ),
    );
  }

  Widget _buildContactBtn(
      IconData icon, String label, bool isPrimary, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isPrimary ? brandGreen : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: isPrimary ? null : Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: isPrimary ? Colors.white : brandGreen),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    color: isPrimary ? Colors.white : darkBlue,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String assetPath) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FAQDetailPage(
                  title: title, content: "Full list of FAQs for $title..."))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(assetPath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.darken),
          ),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13)),
      ),
    );
  }

  Widget _buildQuestionTile(
      BuildContext context, String question, String answer) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title:
          Text(question, style: const TextStyle(color: darkBlue, fontSize: 14)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FAQDetailPage(title: "Answer", content: answer))),
    );
  }
}
