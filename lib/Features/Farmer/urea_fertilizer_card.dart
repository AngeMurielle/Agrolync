import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/checkout.dart';

class UreaFertilizerCartPage extends StatefulWidget {
  const UreaFertilizerCartPage({super.key});

  @override
  State<UreaFertilizerCartPage> createState() => _UreaFertilizerCartPageState();
}

class _UreaFertilizerCartPageState extends State<UreaFertilizerCartPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Urea Fertilizer',
      'weight': '50kg bag',
      'price': 25.00,
      'quantity': 1,
      'image': 'assets/images/urea_fertilizer.jpg'
    },
  ];

  double get _subtotal {
    return _cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _shippingFee {
    return _subtotal * 0.07;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Shopping Cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: AssetImage(item['image']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("${item['price']} XAF/${item['weight']}",
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  Text(
                                      "Total: ${(item['price'] * item['quantity']).toStringAsFixed(2)} XAF",
                                      style: const TextStyle(
                                          color: Color(0xFF026139),
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => _removeItem(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Quantity:"),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 20),
                                  onPressed: () =>
                                      _updateQuantity(index, false),
                                ),
                                Text("${item['quantity']}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 20),
                                  onPressed: () => _updateQuantity(index, true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Subtotal:"),
                    Text("${_subtotal.toStringAsFixed(2)} XAF",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Shipping:"),
                    Text("${_shippingFee.toStringAsFixed(2)} XAF",
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text("${_totalPrice.toStringAsFixed(2)} XAF",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF026139))),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckoutScreen(orderItems: _cartItems),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF026139),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Proceed to Checkout",
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
