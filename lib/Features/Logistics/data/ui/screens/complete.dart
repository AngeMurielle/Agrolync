import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/market_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/delivered.dart';

class DeliveryCompleteScreen extends StatelessWidget {
  final String orderId;
  final String earnings;
  final Map<String, dynamic>? jobData;

  const DeliveryCompleteScreen({
    super.key,
    this.orderId = "AGL-8829-CMR",
    this.earnings = "12,500 XAF",
    this.jobData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: -100,
            right: -50,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: const Color(0xFF015E38).withOpacity(0.05),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  // Success Animation/Icon Area
                  _buildSuccessHeader(),

                  const SizedBox(height: 40),

                  const Text(
                    "Mission Accomplished!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "The cargo has been delivered and the proof has been verified. Great job!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Summary Card
                  _buildSummaryCard(),

                  const Spacer(),

                  // Action Buttons
                  _buildActionButtons(context),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => MainNavWrapper(initialIndex: index)),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: const Color(0xFF015E38).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          height: 90,
          width: 90,
          decoration: const BoxDecoration(
            color: Color(0xFF015E38),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Order ID", orderId),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFFE0E0E0)),
          ),
          _buildSummaryRow("Status", "Delivered", isStatus: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Color(0xFFE0E0E0)),
          ),
          _buildSummaryRow("Earnings", earnings, isHighlight: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isStatus = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        if (isStatus)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        else
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isHighlight ? 18 : 14,
              color: isHighlight ? const Color(0xFF015E38) : Colors.black,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LogisticsMarketScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF015E38),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Back to Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Delivery(completedJob: jobData),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEEEEEE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
