import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/wallet/category_detail.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/wallet/showCashOutModal.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';

class EarningsWalletPage extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const EarningsWalletPage({super.key, this.onNavigate});

  @override
  State<EarningsWalletPage> createState() => _EarningsWalletPageState();
}

class _EarningsWalletPageState extends State<EarningsWalletPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color primaryGreen = const Color(0xFF015E38);
  final Color accentGreen = const Color(0xFF00FF85);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MainNavWrapper(initialIndex: 0),
            ),
            (route) => false,
          ),
        ),
        title: Text("My Wallet",
            style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildBalanceCard(),
          ),
          TabBar(
            controller: _tabController,
            indicatorColor: primaryGreen,
            labelColor: primaryGreen,
            unselectedLabelColor: Colors.grey,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Payments"),
              Tab(text: "Incentives")
            ],
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFF9F9F9),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTransactionList("All"),
                  _buildTransactionList("Payouts"),
                  _buildTransactionList("Incentives"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("TOTAL BALANCE",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2)),
          const Text("750,500 XAF",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),

          // Added vertical space
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Withdrawable",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text("125,000 XAF",
                      style: TextStyle(
                          color: accentGreen,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),

              // SPACE BETWEEN Text and Button
              const SizedBox(width: 10),

              // Fixed width and height for Withdraw Button
              SizedBox(
                width: 120, // Set explicit width
                height: 48, // Set explicit height
                child: ElevatedButton(
                  onPressed: () => showCashOutModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: primaryGreen,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Withdraw",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTransactionList(String filter) {
    List<Widget> items = [];

    var grain = _buildCategoryItem(context, "Grain Delivery", "Maize & Rice",
        "145,000 XAF", Icons.local_shipping, primaryGreen);
    var fuel = _buildCategoryItem(context, "Fuel Incentive", "Mileage Bonus",
        "25,000 XAF", Icons.ev_station, primaryGreen);
    var fert = _buildCategoryItem(context, "Fertilizer Transport", "Logistics",
        "80,000 XAF", Icons.agriculture, primaryGreen);
    var live = _buildCategoryItem(context, "Livestock Transport",
        "North-South Route", "210,000 XAF", Icons.pets, primaryGreen);

    if (filter == "All") {
      items = [grain, fuel, fert, live];
    } else if (filter == "Payouts") {
      items = [grain, fert, live];
    } else if (filter == "Incentives") {
      items = [fuel];
    }

    // Using ListView.separated to ensure consistent space between list items
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: 12), // Space between cards
      itemBuilder: (context, index) => items[index],
    );
  }

  Widget _buildCategoryItem(BuildContext context, String title, String subtitle,
      String total, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text(subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(total,
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const Text("View Info",
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),

            // SPACE BETWEEN Amount and Chevron
            const SizedBox(width: 8),

            const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionCategoryDetail(
                  categoryName: title, totalAmount: total),
            ),
          );
        },
      ),
    );
  }
}
