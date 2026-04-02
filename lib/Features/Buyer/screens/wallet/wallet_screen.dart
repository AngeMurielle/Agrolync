import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/wallet_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/drawer/drawer.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // Payment numbers for activated MTN and Orange top-up methods
  final String mtnNumber = "+237 682 087 287";
  final String orangeNumber = "+237 652 152 809";

  @override
  Widget build(BuildContext context) {
    final wallet = context.watch<WalletProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF015E38)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
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
            _buildBalanceCard(wallet),

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
            ...wallet.transactions.map((tx) => _buildTransactionItem(tx)),

            const SizedBox(height: 20),
            _buildSecurityFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(WalletProvider wallet) {
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
                wallet.balance.toStringAsFixed(0).replaceAllMapped(
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

  Widget _buildTransactionItem(WalletTransaction tx) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          if (tx.productImage != null && tx.productImage!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                tx.productImage!,
                width: 42,
                height: 42,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 42,
                  height: 42,
                  color: const Color(0xFFF0F9F4),
                  child: const Icon(Icons.image,
                      color: Color(0xFF015E38), size: 20),
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFFF0F9F4),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(tx.icon, color: const Color(0xFF015E38), size: 20),
            ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                if (tx.productName != null) ...[
                  Text(tx.productName!,
                      style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
                Text(
                    '${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}-${tx.date.day.toString().padLeft(2, '0')} ${tx.date.hour.toString().padLeft(2, '0')}:${tx.date.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${tx.isCredit ? '+' : ''}${tx.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: tx.isCredit ? Colors.green : Colors.redAccent),
              ),
              Text(tx.status,
                  style: const TextStyle(
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
    context.read<WalletProvider>().deposit(50000);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("XAF 50,000 deposited successfully")));
  }

  void _handleWithdraw() {
    final wallet = context.read<WalletProvider>();
    if (wallet.balance < 10000) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Insufficient balance for withdrawal")));
      return;
    }
    wallet.withdraw(10000);
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
              context.read<WalletProvider>().quickTopUp(method, amount);
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
