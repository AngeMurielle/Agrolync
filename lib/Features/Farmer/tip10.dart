import 'package:flutter/material.dart';

class Tip10Page extends StatelessWidget {
  const Tip10Page({super.key});

  static const Color brandGreen = Color(0xFF026139);
  static const Color lightGreenSurface = Color(0xFFEFF7F2);
  static const Color darkBlueText = Color(0xFF1E293B);
  static const Color bodyGreyText = Color(0xFF64748B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Agronomic Tips",
          style: TextStyle(color: brandGreen, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Hero Image Section ---
            Stack(
              children: [
                Image.asset(
                  'assets/images/Tip10.jpg', // Using your specific asset
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: brandGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "BEST PRACTICE",
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Preventive Equipment Maintenance",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // --- Intro Text Box ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                ),
                child: const Text(
                  "Enhance operational safety by inspecting equipment before the busy season to avoid costly delays.\nWell-maintained machinery operates more efficiently and prevents injuries. Always shut off power before leaving an operator's station and ensure all workers are trained on safety procedures.",
                  style: TextStyle(color: bodyGreyText, height: 1.5, fontSize: 14),
                ),
              ),
            ),

            // --- Core Strategies Section (Limited to 2) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Core Strategies",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandGreen),
                  ),
                  Text(
                    "2 RECOMMENDED",
                    style: TextStyle(fontSize: 12, color: bodyGreyText, letterSpacing: 1),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildStrategyCard(
              index: "1",
              title: "The 50-Hour Checklist",
              description: " Perform a systematic check of fluids, belts, and sharp edges every 50 hours of machine operation.",
              icon: Icons.grass,
              efficiency: "HIGH",
              cost: "LOW",
            ),

            _buildStrategyCard(
              index: "2",
              title: "Post-Season Storage",
              description: "Clean, lubricate, and store all equipment under cover immediately after the harvest to prevent rust and degradation.",
              icon: Icons.sync,
              efficiency: "VITAL",
              cost: "MEDIUM",
            ),

            const SizedBox(height: 24),

            // --- Stay Informed Footer ---
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: brandGreen,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Stay Informed",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Get weekly agronomic insights delivered to your dashboard.",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: brandGreen,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text("Enable Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStrategyCard({
    required String index,
    required String title,
    required String description,
    required IconData icon,
    required String efficiency,
    required String cost,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(width: 6, height: 140, decoration: const BoxDecoration(
              color: brandGreen,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: lightGreenSurface, borderRadius: BorderRadius.circular(12)),
                          child: Icon(icon, color: brandGreen, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "$index. $title",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: darkBlueText, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(description, style: const TextStyle(color: bodyGreyText, fontSize: 13, height: 1.4)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildStatText("EFFICIENCY: ", efficiency),
                        const SizedBox(width: 16),
                        _buildStatText("COST: ", cost),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        children: [
          TextSpan(text: label, style: const TextStyle(color: bodyGreyText)),
          TextSpan(text: value, style: const TextStyle(color: brandGreen)),
        ],
      ),
    );
  }
}