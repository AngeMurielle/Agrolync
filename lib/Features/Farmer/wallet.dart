import 'package:flutter/material.dart';

class FarmerWalletScreen extends StatefulWidget {
  const FarmerWalletScreen({super.key});

  @override
  State<FarmerWalletScreen> createState() => _FarmerWalletScreenState();
}

class _FarmerWalletScreenState extends State<FarmerWalletScreen> {
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkGreen = Color(0xFF014D2E);

  double _balance = 250000.0; // XAF 250,000 (Synced with Home earnings)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Wallet',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: brandGreen,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'XAF ${_balance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _showTopUpDialog(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: brandGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Top Up'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _showWithdrawDialog(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Withdraw',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Quick Actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    'Send Money',
                    Icons.send,
                    () => _showSendMoneyDialog(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    'Request',
                    Icons.request_page,
                    () => _showRequestMoneyDialog(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    'Pay Bills',
                    Icons.receipt,
                    () => _showPayBillsDialog(context),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildQuickAction(
                    'History',
                    Icons.history,
                    () => _showTransactionHistory(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Recent Transactions
            const Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 16),

            _buildTransactionItem(
              'Sale - Maize',
              '+XAF 45000',
              'Today',
              Icons.trending_up,
              Colors.green,
            ),

            _buildTransactionItem(
              'Fertilizer Purchase',
              '-XAF 12500',
              'Yesterday',
              Icons.trending_down,
              Colors.red,
            ),

            _buildTransactionItem(
              'Sale - Tomatoes',
              '+XAF 28,000',
              '2 days ago',
              Icons.trending_up,
              Colors.green,
            ),

            _buildTransactionItem(
              'Equipment Purchase',
              '-XAF 35,000',
              '3 days ago',
              Icons.trending_down,
              Colors.red,
            ),

            _buildTransactionItem(
              'Top Up - MTN MoMo',
              '+XAF 50,000',
              '5 days ago',
              Icons.add_circle,
              Colors.blue,
            ),

            const SizedBox(height: 30),

            // Security Notice
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.security, color: brandGreen),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Your transactions are secured with bank-level encryption. All payments are processed safely.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
      String title, String amount, String date, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(icon, color: brandGreen, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showTopUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Top Up Wallet"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.phone_android, color: brandGreen),
              title: const Text("MTN MoMo"),
              subtitle: const Text("Top up via mobile money"),
              onTap: () {
                Navigator.pop(ctx);
                _processTopUp("MTN MoMo", 50000);
              },
            ),
            ListTile(
              leading: Icon(Icons.phone_android, color: Colors.orange),
              title: const Text("Orange Money"),
              subtitle: const Text("Top up via mobile money"),
              onTap: () {
                Navigator.pop(ctx);
                _processTopUp("Orange Money", 50000);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Withdraw Money"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount (XAF)",
                hintText: "Enter amount to withdraw",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Available balance: XAF 250000",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text) ?? 0;
              if (amount > 0 && amount <= _balance) {
                Navigator.pop(ctx);
                _processWithdrawal(amount);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: brandGreen,
            ),
            child: const Text("Withdraw"),
          ),
        ],
      ),
    );
  }

  void _showSendMoneyDialog(BuildContext context) {
    // Implementation for send money
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Send money feature coming soon!")),
    );
  }

  void _showRequestMoneyDialog(BuildContext context) {
    // Implementation for request money
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Request money feature coming soon!")),
    );
  }

  void _showPayBillsDialog(BuildContext context) {
    // Implementation for pay bills
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Pay bills feature coming soon!")),
    );
  }

  void _showTransactionHistory(BuildContext context) {
    // Implementation for transaction history
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Transaction history feature coming soon!")),
    );
  }

  void _processTopUp(String method, double amount) {
    setState(() {
      _balance += amount;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            "Successfully topped up XAF ${amount.toStringAsFixed(0)} via $method"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _processWithdrawal(double amount) {
    setState(() {
      _balance -= amount;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Successfully withdrew XAF ${amount.toStringAsFixed(0)}"),
        backgroundColor: Colors.green,
      ),
    );
  }
}
