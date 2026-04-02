import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  final Color primaryGreen = const Color(0xFF015E38);

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
        title: Text(
          "Trip History",
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemCount: 8,
        itemBuilder: (context, index) => _buildTripCard(index),
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

  Widget _buildTripCard(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          // Header: ID and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: #TRP-00${100 + index}",
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              Text(
                "45,000 XAF",
                style: TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1),
          ),
          // Route Details
          Row(
            children: [
              // Visual Timeline
              Column(
                children: [
                  Icon(Icons.radio_button_checked,
                      color: primaryGreen, size: 16),
                  Container(
                      width: 2,
                      height: 25,
                      color: primaryGreen.withOpacity(0.2)),
                  const Icon(Icons.location_on, color: Colors.orange, size: 16),
                ],
              ),
              const SizedBox(width: 15),
              // Locations
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Douala (Port Area)",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(height: 18),
                    Text("Yaoundé (Mvan)",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ],
                ),
              ),
              // Status & Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("12 Oct 2025",
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                  const SizedBox(height: 15),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "COMPLETED",
                      style: TextStyle(
                          color: primaryGreen,
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
