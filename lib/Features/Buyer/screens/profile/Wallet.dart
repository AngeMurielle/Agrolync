import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<Wallet> {
  // Initial balance from design
  double balance = 4250000;

  // Payment numbers for activated MTN and Orange top-up methods
  final String mtnNumber = "+237 682 087 287";
  final String orangeNumber = "+237 652 152 809";

  final List<Map<String, dynamic>> transactions = [
    {
      "title": "Purchase: Fertilizer X10",
      "date": "Oct 24, 2023 • 14:32",
      "amount": -240000,
      "status": "SUCCESS",
      "icon": Icons.shopping_cart_outlined,
      "iconColor": Colors.green
    },
    {
      "title": "Wallet Top-up",
      "date": "Oct 23, 2023 • 09:15",
      "amount": 1500000,
      "status": "SUCCESS",
      "icon": Icons.account_balance_wallet_outlined,
      "iconColor": Colors.green
    },
    {
      "title": "Logistics Fee",
      "date": "Oct 22, 2023 • 17:45",
      "amount": -15000,
      "status": "SUCCESS",
      "icon": Icons.local_shipping_outlined,
      "iconColor": Colors.green
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF015E38)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("AgroLync",
            style: TextStyle(
                color: Color(0xFF015E38), fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF015E38)),
            onPressed: () => _showNotifications(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 💳 TOTAL BALANCE CARD
            _buildBalanceCard(),

            const SizedBox(height: 24),
            const Text("QUICK TOP-UP",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            const SizedBox(height: 12),

            // 📲 TOP-UP BUTTONS
            Row(
              children: [
                Expanded(
                    child: _buildTopUpOption("MTN MoMo", "INSTANT",
                        Colors.amber, "assets/images/mtn_logo.jpg")),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildTopUpOption("Orange Money", "SECURED",
                        Colors.orange, "assets/images/orange_logo.jpg")),
              ],
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("TRANSACTION HISTORY",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                TextButton(
                    onPressed: () {},
                    child: const Text("VIEW ALL",
                        style: TextStyle(
                            color: Color(0xFF015E38),
                            fontSize: 12,
                            fontWeight: FontWeight.bold))),
              ],
            ),

            // 📜 TRANSACTIONS LIST
            ...transactions.map((tx) => _buildTransactionItem(tx)),

            const SizedBox(height: 20),
            _buildSecurityFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF015E38), // Dark Green
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("TOTAL BALANCE",
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                balance.toStringAsFixed(0).replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text("XAF",
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _handleDeposit(),
                  icon: const Icon(Icons.add_circle_outline, size: 18),
                  label: const Text("Deposit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF015E38),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _handleWithdraw(),
                  icon: const Icon(Icons.account_balance, size: 18),
                  label: const Text("Withdraw"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopUpOption(
      String title, String sub, Color color, String assetPath) {
    return InkWell(
      onTap: () => _handleQuickTopUp(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(12)),
              child: Image.asset(assetPath,
                  width: 28, height: 28, fit: BoxFit.contain),
            ),
            const SizedBox(height: 12),
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    bool isCredit = tx["amount"] > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: const Color(0xFFF0F9F4),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(tx["icon"], color: const Color(0xFF015E38), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx["title"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(tx["date"],
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isCredit ? '+' : ''}${tx["amount"].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCredit ? Colors.green : Colors.redAccent),
              ),
              const Text("SUCCESS",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFooter() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: const Color(0xFFF0F9F4),
            borderRadius: BorderRadius.circular(12)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.verified_user_outlined,
                size: 14, color: Color(0xFF015E38)),
            SizedBox(width: 8),
            Text("PCI-DSS COMPLIANT & END-TO-END ENCRYPTED",
                style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF015E38),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // --- ACTIONS ---
  void _handleDeposit() {
    setState(() => balance += 50000);
    _addTransaction(
        "Deposit", 50000, Icons.account_balance_wallet_outlined, true);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("XAF 50,000 deposited successfully")));
  }

  void _handleWithdraw() {
    if (balance < 10000) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Insufficient balance for withdrawal")));
      return;
    }
    setState(() => balance -= 10000);
    _addTransaction("Withdraw", -10000, Icons.account_balance_outlined, false);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("XAF 10,000 withdrawn successfully")));
  }

  void _handleQuickTopUp(String method) {
    final String number = method == 'MTN MoMo' ? mtnNumber : orangeNumber;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("$method Top-up"),
        content: Text(
            "Use $number to complete payment via USSD. Confirm when payment is done."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final int amount = 100000;
              setState(() => balance += amount);
              _addTransaction(
                  "$method Top-up", amount, Icons.add_circle_outline, true);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "$method top-up of XAF ${amount.toString()} applied")));
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _addTransaction(
      String title, int amount, IconData icon, bool isSuccess) {
    setState(() {
      transactions.insert(0, {
        'title': title,
        'date': DateTime.now().toString().split('.')[0],
        'amount': amount,
        'status': isSuccess ? 'SUCCESS' : 'FAILED',
        'icon': icon,
        'iconColor': isSuccess ? Colors.green : Colors.red,
      });
    });
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(16),
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Notifications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            ListTile(title: Text('Payment completed successfully')),
            ListTile(title: Text('New offer: 10% off fertilizers')),
            ListTile(title: Text('Reminder: pending delivery charges')),
          ],
        ),
      ),
    );
  }
}
