import 'package:flutter/material.dart';
// 1. IMPORT YOUR LOGISTICS SCREENS
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/main.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final double totalAmount;
  final String transactionId;

  const PaymentSuccessScreen({
    super.key,
    required this.totalAmount,
    required this.transactionId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF026139),
                  child: Icon(Icons.check, color: Colors.white, size: 50),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Payment Successful",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF026139),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Your transaction has been processed securely. A confirmation email has been sent to your registered address.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildReceiptCard(),
              const SizedBox(height: 32),
              _buildTimelineSection(),
              const SizedBox(height: 40),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  // ... (Keeping _buildReceiptCard, _getMonth, _receiptDetail, _buildTimelineSection, _nextStepItem exactly as you have them)

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {
              // 🚦 ROUTING TO LOGISTICS MAP SCREEN
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const LogisticsMapScreen(fromBuyer: true),
                ),
              );
            },
            icon: const Icon(Icons.explore_outlined, color: Colors.white),
            label: const Text("Track Order",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF026139),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const MainNavigationWrapper(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.home, color: Colors.black87),
            label: const Text("Back to Home",
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold)),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFE5E9E5),
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  // Re-pasting helper methods for completeness in your file
  Widget _buildReceiptCard() {
    String formattedAmount = totalAmount.toInt().toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF1EE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text("TOTAL AMOUNT PAID",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 8),
          Text(" $formattedAmount XAF",
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF026139))),
          const SizedBox(height: 20),
          const Divider(color: Colors.grey),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _receiptDetail("TRANSACTION ID", transactionId),
              _receiptDetail("DATE",
                  "${DateTime.now().day} ${_getMonth(DateTime.now().month)} ${DateTime.now().year}"),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _receiptDetail("PAYMENT METHOD", "Mobile Money"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("STATUS",
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: const Color(0xFFC7E2D6),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text("COMPLETED",
                        style: TextStyle(
                            color: Color(0xFF026139),
                            fontSize: 9,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  String _getMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _receiptDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTimelineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 3, height: 15, color: const Color(0xFF026139)),
            const SizedBox(width: 8),
            const Text("WHAT HAPPENS NEXT?",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 16),
        _nextStepItem(Icons.inventory_2, "Order Preparation",
            "Our warehouse is already processing your order. Quality checks are currently underway."),
        const SizedBox(height: 20),
        _nextStepItem(Icons.local_shipping, "Logistics Partner",
            "A delivery partner will be assigned within 2 hours to transport your items to the farm location."),
      ],
    );
  }

  Widget _nextStepItem(IconData icon, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFFE8F3EE),
            child: Icon(icon, size: 14, color: const Color(0xFF026139))),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(desc,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 11, height: 1.4)),
            ],
          ),
        )
      ],
    );
  }
}
