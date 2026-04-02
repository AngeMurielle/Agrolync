//import 'package:flutter/material.dart';

//class HelpCenterPage extends StatelessWidget {
  import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final Color brandGreen = const Color(0xFF015E38);
  final TextEditingController _searchController = TextEditingController();
  
  // Full list of questions and answers
  final List<Map<String, String>> _allFaqs = [
    {
      "q": "How do I track my delivery?",
      "a": "Navigate to 'My Orders' and select your active order. You will see a real-time map showing the driver's current location and estimated arrival time."
    },
    {
      "q": "What payment methods are accepted?",
      "a": "AgroLync currently supports MTN Mobile Money, Orange Money, and major Credit/Debit cards. Cash on delivery is available for select regions."
    },
    {
      "q": "Can I cancel my order?",
      "a": "Orders can be cancelled within 15 minutes of placement. After that, the farmer begins harvesting/packaging, and cancellation may not be possible."
    },
    {
      "q": "How do I report damaged goods?",
      "a": "If your produce arrives damaged, take a photo immediately and upload it via the 'Report Issue' button in your Order History for a 100% refund."
    },
    {
      "q": "Is there a delivery fee?",
      "a": "Delivery fees are calculated based on the distance between the farm and your delivery address. You will see the final fee at checkout."
    },
  ];

  List<Map<String, String>> _filteredFaqs = [];

  @override
  void initState() {
    super.initState();
    _filteredFaqs = _allFaqs; // Initially show all
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, String>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allFaqs;
    } else {
      results = _allFaqs
          .where((faq) => faq["q"]!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() => _filteredFaqs = results);
  }

  Future<void> _makeCall() async {
    final Uri launchUri = Uri(scheme: 'tel', path: '682087287');
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: brandGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Help & Support", 
          style: TextStyle(color: brandGreen, fontWeight: FontWeight.bold, fontSize: 18)),
      ),
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                hintText: "Search for answers...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF1F5F9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 📞 DIRECT CONTACT CARD
                  _buildContactCard(),
                  
                  const SizedBox(height: 30),
                  
                  const Text("Top Questions", 
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 15),

                  // ❓ DYNAMIC FAQ LIST
                  _filteredFaqs.isEmpty 
                    ? const Center(child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("No matching questions found."),
                      ))
                    : Column(
                        children: _filteredFaqs.map((faq) => _buildFaqItem(faq['q']!, faq['a']!)).toList(),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: brandGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: brandGreen.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white24,
            child: Icon(Icons.headset_mic, color: Colors.white),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Still have questions?", 
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                Text("Call us at 682 087 287", 
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _makeCall,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: brandGreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text("Call Now", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
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
        iconColor: brandGreen,
        title: Text(question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(answer, style: const TextStyle(color: Color(0xFF64748B), height: 1.5)),
          ),
        ],
      ),
    );
  }
}