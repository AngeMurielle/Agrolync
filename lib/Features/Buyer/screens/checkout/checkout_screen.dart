import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/order_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/wallet_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/cart/cart_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/paymentsucess/paymentsucess.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/services/delivery_service.dart';

class CheckoutScreen extends StatefulWidget {
  final Product? product;

  const CheckoutScreen({super.key, this.product});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = 'MoMo';
  bool _isProcessing = false;
  String deliveryAddress = 'AgroLync Hub, Yaoundé';

  double get _subtotal {
    if (widget.product != null) {
      return widget.product!.price;
    }

    final cart = Provider.of<CartProvider>(context, listen: false);
    return cart.subtotal;
  }

  double get _deliveryFee {
    final cart = Provider.of<CartProvider>(context, listen: false);

    if (widget.product != null) {
      return DeliveryService.calculateShippingFee(
        subtotal: _subtotal,
        region: cart.selectedRegion,
      );
    }

    return cart.shippingFee;
  }

  double get _tax => DeliveryService.calculateTax(_subtotal);

  double get _totalAmount {
    if (widget.product != null) {
      return _subtotal + _deliveryFee + _tax;
    }

    final cart = Provider.of<CartProvider>(context, listen: false);
    return cart.totalAmount;
  }

  void _handlePayment() {
    setState(() => _isProcessing = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isProcessing = false);

      final cart = Provider.of<CartProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      final walletProvider =
          Provider.of<WalletProvider>(context, listen: false);
      final paidAmount = _totalAmount;

      orderProvider.placeOrder(
        cart,
        _subtotal,
        _deliveryFee,
        _tax,
        paidAmount,
        deliveryAddress,
      );

      walletProvider.deductPurchase(
          _buildOrderEntries(cart), paidAmount.toInt());

      if (widget.product == null) {
        cart.clearCart();
      }

      _navigateToPaymentSuccess(paidAmount);
    });
  }

  void _editDeliveryAddress() {
    final controller = TextEditingController(text: deliveryAddress);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Edit Delivery Address'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter delivery address'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF015E38),
            ),
            onPressed: () {
              setState(() {
                if (controller.text.trim().isNotEmpty) {
                  deliveryAddress = controller.text.trim();
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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

  void _handleBack() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const CartScreen()),
      (route) => false,
    );
  }

  List<Map<String, dynamic>> _buildOrderEntries(CartProvider cart) {
    if (widget.product != null) {
      return [
        {
          'product': widget.product!,
          'quantity': 1,
        }
      ];
    }

    return cart.items.entries
        .map((entry) {
          final product = cart.products[entry.key];
          if (product == null) return null;
          return {
            'product': product,
            'quantity': entry.value,
          };
        })
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  String _regionLabel(CameroonRegion region) {
    switch (region) {
      case CameroonRegion.sameTown:
        return 'Same Town';
      case CameroonRegion.otherRegions:
        return 'Different Town';
      case CameroonRegion.northRegion:
        return 'North Cameroon';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final orderEntries = _buildOrderEntries(cart);
    final bool hasOrderItems = widget.product != null || cart.items.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF015E38)),
          onPressed: _handleBack,
        ),
        title: const Text('Checkout',
            style: TextStyle(
                color: Color(0xFF015E38), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: hasOrderItems
          ? Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                      16,
                      16,
                      16,
                      MediaQuery.of(context)
                              .viewInsets
                              .bottom
                              .clamp(0.0, double.infinity) +
                          120 +
                          MediaQuery.of(context).padding.bottom),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('REVIEW ORDER'),
                      _buildDeliveryInfoCard(cart),
                      const SizedBox(height: 24),
                      _buildSectionHeader('ORDER SUMMARY'),
                      _buildOrderSummaryList(orderEntries),
                      const SizedBox(height: 24),
                      _buildSectionHeader('PAYMENT METHOD'),
                      _buildPaymentOption(
                        'MoMo',
                        'MTN MoMo',
                        'FAST & SECURE',
                        'assets/images/mtn_logo.jpg',
                        Colors.amber,
                      ),
                      _buildPaymentOption(
                        'Orange',
                        'Orange Money',
                        'MOBILE TRANSFER',
                        'assets/images/orange_logo.jpg',
                        Colors.orange,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                if (_isProcessing)
                  Container(
                    color: Colors.white70,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF015E38),
                      ),
                    ),
                  ),
              ],
            )
          : _buildEmptyState(),
      bottomNavigationBar:
          hasOrderItems ? SafeArea(child: _buildBottomSummary(cart)) : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_basket_outlined,
              size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF015E38),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Looks like you haven\'t added any fresh harvest yet. Go back and pick some items!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _handleBack,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF015E38),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Go Back', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 4),
        child: Text(title,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
      );

  Widget _buildDeliveryInfoCard(CartProvider cart) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            _infoRow(
              Icons.location_on,
              'Delivery Address',
              deliveryAddress,
              true,
              onEdit: _editDeliveryAddress,
            ),
            const Divider(height: 32, color: Color(0xFFF3F5F7)),
            _infoRow(Icons.access_time_filled, 'Estimated Arrival',
                'Oct 24 - Oct 26, 2026', false),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Delivery Region',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            const SizedBox(height: 10),
            Row(
              children: CameroonRegion.values.map((region) {
                final selected = cart.selectedRegion == region;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(_regionLabel(region),
                          style: TextStyle(
                            color: selected ? Colors.white : Colors.black,
                            fontSize: 12,
                          )),
                      selected: selected,
                      selectedColor: const Color(0xFF015E38),
                      backgroundColor: const Color(0xFFF0F2F3),
                      onSelected: (_) => cart.updateRegion(region),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );

  Widget _infoRow(IconData icon, String title, String sub, bool hasEdit,
          {VoidCallback? onEdit}) =>
      Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE8F3EE),
            child: Icon(icon, color: const Color(0xFF015E38), size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(sub,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          if (hasEdit)
            TextButton(
              onPressed: onEdit,
              child: const Text('EDIT',
                  style: TextStyle(
                      color: Color(0xFF015E38),
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
        ],
      );

  Widget _buildOrderSummaryList(List<Map<String, dynamic>> orderEntries) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: orderEntries.isEmpty
            ? const [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('No items found.',
                      style: TextStyle(color: Colors.grey)),
                )
              ]
            : orderEntries
                .map((entry) => _buildOrderItem(
                      entry['product'] as Product,
                      entry['quantity'] as int,
                    ))
                .toList(),
      ),
    );
  }

  Widget _buildOrderItem(Product product, int quantity) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: const Color(0xFFF0F0F0),
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Qty: $quantity',
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Text('XAF ${(product.price * quantity).toInt()}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xFF015E38))),
          ],
        ),
      );

  Widget _buildPaymentOption(
      String id, String title, String sub, String asset, Color color) {
    final bool isSelected = _selectedPayment == id;

    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _selectedPayment = id),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isSelected ? const Color(0xFF015E38) : Colors.transparent,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                  child: ClipOval(
                    child: Image.asset(
                      asset,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.payment, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(sub,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.check_circle : Icons.radio_button_off,
                  color: isSelected
                      ? const Color(0xFF015E38)
                      : Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildBottomSummary(CartProvider cart) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _summaryRow('Subtotal', 'XAF ${_subtotal.toInt()}'),
            _summaryRow('Shipping', 'XAF ${_deliveryFee.toInt()}'),
            _summaryRow('Tax (10%)', 'XAF ${_tax.toInt()}'),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TOTAL AMOUNT',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    Text('XAF ${_totalAmount.toInt()}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF015E38))),
                  ],
                ),
                ElevatedButton(
                  onPressed: _isProcessing ? null : _handlePayment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF015E38),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: _isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Confirm & Pay',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                )
              ],
            ),
          ],
        ),
      );

  Widget _summaryRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
      );
}
