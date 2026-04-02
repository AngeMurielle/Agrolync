import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class TransactionCategoryDetail extends StatefulWidget {
  final String categoryName;
  final String totalAmount;

  const TransactionCategoryDetail(
      {super.key, required this.categoryName, required this.totalAmount});

  @override
  State<TransactionCategoryDetail> createState() =>
      _TransactionCategoryDetailState();
}

class _TransactionCategoryDetailState extends State<TransactionCategoryDetail> {
  // Brand Color
  final Color primaryGreen = const Color(0xFF015E38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.categoryName,
            style: TextStyle(
                color: primaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Premium Header Section
          _buildHeader(),

          // List Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Trip History",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Last 30 Days",
                    style: TextStyle(
                        color: primaryGreen.withOpacity(0.6), fontSize: 12)),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildTransactionCard(index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: 2,
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

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Text("Total ${widget.categoryName} Earnings",
              style: const TextStyle(
                  color: Colors.white70, fontSize: 13, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          Text(widget.totalAmount,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text("Verified by AgroLync",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          )
        ],
      ),
    );
  }

  Widget _buildTransactionCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Icon section
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryGreen.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.local_shipping_outlined,
                color: primaryGreen, size: 24),
          ),
          const SizedBox(width: 16),

          // Middle: Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Trip ID #LYNC-00${index + 104}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on, size: 12, color: primaryGreen),
                    const SizedBox(width: 4),
                    const Text("Douala → Bafoussam",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text("Oct 20, 2023 • 14:20 PM",
                    style: TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),

          // Right: Amount & Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text("45,000 XAF",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text("PAID",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
