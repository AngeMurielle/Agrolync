import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/farmer_cart_provider.dart';
import '../services/farmer_delivery_service.dart';
import '../paymentsucess.dart';

class FarmerCheckoutScreen extends StatefulWidget {
  const FarmerCheckoutScreen({super.key});

  @override
  State<FarmerCheckoutScreen> createState() => _FarmerCheckoutScreenState();
}

class _FarmerCheckoutScreenState extends State<FarmerCheckoutScreen> {
  bool _isProcessing = false;
  String _selectedPayment = 'mtn_momo';

  void _handlePayment() {
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isProcessing = false);

      final cart = context.read<FarmerCartProvider>();
      final totalAmount = cart.totalAmount;

      cart.clearCart();

      _navigateToPaymentSuccess(totalAmount);
    });
  }

  void _navigateToPaymentSuccess(double totalAmount) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentSuccessScreen(
          totalAmount: totalAmount,
          transactionId: _generateTransactionId(),
        ),
      ),
    );
  }

  String _generateTransactionId() {
    return 'AGL-${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<FarmerCartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Navigate back to marketplace while preserving navigation state
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Delivery Region Selection
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivery Region",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildRegionOption(
                    context,
                    cart,
                    "Same Town",
                    CameroonRegion.sameTown,
                    "7% of subtotal",
                  ),
                  const SizedBox(height: 10),
                  _buildRegionOption(
                    context,
                    cart,
                    "Other Regions",
                    CameroonRegion.otherRegions,
                    "12% of subtotal",
                  ),
                  const SizedBox(height: 10),
                  _buildRegionOption(
                    context,
                    cart,
                    "North Cameroon",
                    CameroonRegion.northRegion,
                    "15% of subtotal",
                  ),
                ],
              ),
            ),

            // Order Summary
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...cart.items.entries.map((entry) {
                    final productId = entry.key;
                    final quantity = entry.value;
                    final product = cart.products[productId];
                    if (product == null) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              product.image,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 56,
                                height: 56,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                                const SizedBox(height: 6),
                                Text('Qty: $quantity',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                          ),
                          Text(
                            '${(product.price * quantity).toStringAsFixed(0)} XAF',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF026139)),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Payment Method
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Payment Method",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 15),
                  RadioListTile<String>(
                    value: 'mtn_momo',
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedPayment = value);
                      }
                    },
                    title: const Text("MTN MoMo"),
                    subtitle: const Text("Mobile Money"),
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/mtn_logo.jpg',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  RadioListTile<String>(
                    value: 'orange_money',
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedPayment = value);
                      }
                    },
                    title: const Text("Orange Money"),
                    subtitle: const Text("Mobile Money"),
                    secondary: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/orange_logo.jpg',
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Order totals card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                      'Subtotal', '${cart.subtotal.toStringAsFixed(0)} XAF'),
                  const SizedBox(height: 10),
                  _buildSummaryRow(
                      'Tax (VAT 4%)', '${cart.tax.toStringAsFixed(0)} XAF'),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Delivery Fee',
                      '${cart.shippingFee.toStringAsFixed(0)} XAF'),
                  const Divider(height: 28, thickness: 1),
                  _buildSummaryRow(
                    'Total Amount',
                    '${cart.totalAmount.toStringAsFixed(0)} XAF',
                    valueStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF026139),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Confirm & Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF026139),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  onPressed: _isProcessing ? null : _handlePayment,
                  child: _isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
                          "Confirm & Pay",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionOption(
    BuildContext context,
    FarmerCartProvider cart,
    String label,
    CameroonRegion region,
    String fee,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: cart.selectedRegion == region
              ? const Color(0xFF026139)
              : Colors.grey.shade200,
          width: cart.selectedRegion == region ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RadioListTile<CameroonRegion>(
        value: region,
        groupValue: cart.selectedRegion,
        onChanged: (newValue) {
          if (newValue != null) {
            cart.updateRegion(newValue);
          }
        },
        title: Text(label),
        subtitle: Text(fee),
        activeColor: const Color(0xFF026139),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {TextStyle? valueStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value,
            style: valueStyle ?? const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
