import 'package:flutter/material.dart';
// Ensure this path matches your project structure exactly
import 'package:flutter_agrolync_pro/Features/Farmer/paymentsucess.dart'; 

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> orderItems;

  const CheckoutScreen({super.key, required this.orderItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // --- Payment Configuration ---
  final String mtnNumber = "+237 682 087 287";
  final String orangeNumber = "+237 652 152 809";

  String _selectedPayment = "MoMo";
  bool _isProcessing = false;

  // --- Calculation Logic (Matching design: XAF 183,500) ---
  int get _subtotal => widget.orderItems.fold(
      0, (sum, item) => sum + ((item['price'] as int) * (item['quantity'] as int)));
  
  double get _tax => _subtotal * 0.05; // 5% VAT
  int get _deliveryFee => 5000;
  double get _totalAmount => _subtotal + _tax + _deliveryFee;

  void _handlePayment() {
    setState(() => _isProcessing = true);

    // Simulate API/USSD Processing Delay
    Future.delayed(const Duration(seconds: 3), () {
      // FIX FOR LINE 40: Check if widget is still in the tree and use correct parameter names
      if (!mounted) return;
      
      setState(() => _isProcessing = false);
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentSuccessScreen(
            totalAmount: _totalAmount, // Fixed: changed 'amount' to 'totalAmount'
            transactionId: "AGL-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF026139)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Checkout", style: TextStyle(color: Color(0xFF026139), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader("REVIEW ORDER"),
                _buildDeliveryInfoCard(),
                const SizedBox(height: 24),
                
                _buildSectionHeader("ORDER SUMMARY"),
                _buildOrderSummaryList(),
                const SizedBox(height: 24),

                _buildSectionHeader("PAYMENT METHOD"),
                _buildPaymentOption("MoMo", "MTN MoMo", "FAST & SECURE", Icons.phone_android, const Color(0xFFFFCC00)),
                _buildPaymentOption("Orange", "Orange Money", "MOBILE TRANSFER", Icons.tablet_android, const Color(0xFFFF6600)),
                
                const SizedBox(height: 150), // Space for bottom sheet
              ],
            ),
          ),
          if (_isProcessing) 
            Container(
              color: Colors.white70, 
              child: const Center(child: CircularProgressIndicator(color: Color(0xFF026139)))
            ),
        ],
      ),
      bottomSheet: _buildBottomSummary(),
    );
  }

  // --- UI Components ---

  Widget _buildSectionHeader(String title) => Padding(
    padding: const EdgeInsets.only(bottom: 12), 
    child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))
  );

  Widget _buildDeliveryInfoCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: [
        _infoRow(Icons.location_on, "Delivery Address", "AgroLync Hub, Yaoundé", true),
        const Divider(height: 32),
        _infoRow(Icons.access_time_filled, "Estimated Arrival", "Oct 24 - Oct 26, 2026", false),
      ],
    ),
  );

  Widget _infoRow(IconData icon, String title, String sub, bool hasEdit) => Row(
    children: [
      CircleAvatar(backgroundColor: const Color(0xFFE8F3EE), child: Icon(icon, color: const Color(0xFF026139), size: 20)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12))])),
      if (hasEdit) TextButton(onPressed: () {}, child: const Text("EDIT", style: TextStyle(color: Color(0xFF026139), fontWeight: FontWeight.bold))),
    ],
  );

  Widget _buildOrderSummaryList() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
    child: Column(
      children: widget.orderItems.map((item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item['image'] ?? '', width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: Colors.grey[200], child: const Icon(Icons.image))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold)), Text("Qty: ${item['quantity']}", style: const TextStyle(color: Colors.grey, fontSize: 12))])),
            Text("XAF ${item['price'] * item['quantity']}", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF026139))),
          ],
        ),
      )).toList(),
    ),
  );

  Widget _buildPaymentOption(String id, String title, String sub, IconData icon, Color color) {
    bool isSelected = _selectedPayment == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedPayment = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(16), 
          border: Border.all(color: isSelected ? const Color(0xFF026139) : Colors.transparent, width: 2)
        ),
        child: Row(
          children: [
            Container(width: 45, height: 45, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.account_balance_wallet, color: Colors.white)),
            const SizedBox(width: 16),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10))])),
            Icon(isSelected ? Icons.check_circle : Icons.radio_button_off, color: const Color(0xFF026139)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSummary() => Container(
    padding: const EdgeInsets.all(24),
    decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _summaryRow("Subtotal", "XAF $_subtotal"),
        _summaryRow("Tax (VAT 5%)", "XAF ${_tax.toInt()}"),
        _summaryRow("Delivery Fee", "XAF $_deliveryFee"),
        const Divider(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("TOTAL AMOUNT", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)), Text("XAF ${_totalAmount.toInt()}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF026139)))]),
            ElevatedButton(
              onPressed: _isProcessing ? null : _handlePayment,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF026139), padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("Confirm & Pay", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            )
          ],
        )
      ],
    ),
  );

  Widget _summaryRow(String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: Colors.grey)), Text(value, style: const TextStyle(fontWeight: FontWeight.bold))]));
}