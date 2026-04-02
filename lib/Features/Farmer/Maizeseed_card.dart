import 'package:flutter/material.dart';
// Ensure these paths match your project structure exactly
import 'package:flutter_agrolync_pro/Features/Farmer/checkout.dart';

class MaizeSeedCartPage extends StatefulWidget {
  const MaizeSeedCartPage({super.key});

  @override
  State<MaizeSeedCartPage> createState() => _MaizeSeedCartPageState();
}

class _MaizeSeedCartPageState extends State<MaizeSeedCartPage> {
  // 1. Data Model for Cart Items
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Hybrid Maize Seeds',
      'weight': '25kg Bag',
      'price': 45000,
      'quantity': 1,
      'image': 'assets/images/maizeseed.jpg'
    },
    {
      'name': 'NPK Fertilizer 15-15-15',
      'weight': '50kg Bag',
      'price': 65000,
      'quantity': 2,
      'image': 'assets/images/npk_fertilizer.jpg'
    },
  ];

  // 2. Calculation Logic
  double get _subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _shippingFee {
    return _subtotal * 0.07; // 7% Shipping Fee
  }

  double get _totalPrice {
    return _subtotal + _shippingFee;
  }

  void _updateQuantity(int index, bool increment) {
    setState(() {
      if (increment) {
        _cartItems[index]['quantity']++;
      } else {
        if (_cartItems[index]['quantity'] > 1) {
          _cartItems[index]['quantity']--;
        }
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Shopping Cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return _buildCartItem(index, item);
              },
            ),
          ),
          _buildOrderSummary(),
          _buildCheckoutButton(),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildCartItem(int index, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(item['image'],
                width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.grey, size: 20),
                      onPressed: () => _removeItem(index),
                    )
                  ],
                ),
                Text(item['weight'],
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "${item['price'] >= 10 ? (item['price'] / 10).toStringAsFixed(3) : (item['price'] * 100).toStringAsFixed(0)} XAF",
                        style: const TextStyle(
                            color: Color(0xFF026139),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          _quantityBtn(Icons.remove,
                              () => _updateQuantity(index, false)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text("${item['quantity']}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          _quantityBtn(
                              Icons.add, () => _updateQuantity(index, true)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, size: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Order Summary",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _summaryRow("Subtotal",
              "${_subtotal >= 10 ? (_subtotal / 10).toStringAsFixed(3) : (_subtotal * 100).toStringAsFixed(0)} XAF"),
          const SizedBox(height: 8),
          _summaryRow("Shipping Fee (7%)",
              "${_shippingFee >= 10 ? (_shippingFee / 10).toStringAsFixed(3) : (_shippingFee * 100).toStringAsFixed(0)} XAF"),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(
                  "${_totalPrice >= 10 ? (_totalPrice / 10).toStringAsFixed(3) : (_totalPrice * 100).toStringAsFixed(0)} XAF",
                  style: const TextStyle(
                      color: Color(0xFF026139),
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ],
          )
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(orderItems: _cartItems),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF026139),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text("Proceed to Checkout",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
