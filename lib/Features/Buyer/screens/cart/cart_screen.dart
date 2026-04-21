import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Slightly off-white background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Shopping Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15, top: 12, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "${cart.items.length} ITEMS",
                style: const TextStyle(
                    color: Color(0xFF015E38),
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : SingleChildScrollView(
              child: Column(
                children: [
                  // 1. LIST OF CART ITEMS
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final productId = cart.items.keys.toList()[index];
                      final product = cart.products[productId];
                      final quantity = cart.items[productId];
                      if (product == null || quantity == null) {
                        return const SizedBox.shrink(); // Skip invalid items
                      }
                      return _buildCartItem(product, quantity, cart);
                    },
                  ),

                  // 2. ORDER SUMMARY CARD
                  _buildOrderSummary(cart),

                  // 3. FREE DELIVERY BANNER
                  _buildDeliveryBanner(cart),

                  const SizedBox(height: 20),

                  // 4. CHECKOUT BUTTON
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF015E38),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () =>
                            Navigator.pushNamed(context, '/checkout'),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Proceed to Checkout",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
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

  Widget _buildCartItem(Product product, int quantity, CartProvider cart) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(product.image,
                width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red, size: 20),
                      onPressed: () => cart.removeItemCompletely(product.id),
                      //removeItemCompletely
                    ),
                  ],
                ),
                Text(product.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${product.price} XAF",
                        style: const TextStyle(
                            color: Color(0xFF015E38),
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    _buildQuantityController(product, quantity, cart),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityController(
      Product product, int quantity, CartProvider cart) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () => cart.decreaseQuantity(product.id),
              icon: const Icon(Icons.remove, size: 16)),
          Text("$quantity",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          IconButton(
            onPressed: () => cart.addToCart(product),
            icon: const Icon(Icons.add, size: 16, color: Colors.white),
            style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF015E38),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(CartProvider cart) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F3F4)),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.receipt_long, color: Color(0xFF015E38)),
              SizedBox(width: 10),
              Text("Order Summary",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(height: 30),
          _summaryRow("Subtotal", "${cart.subtotal.toInt()} XAF"),
          _summaryRow("Shipping Fee", "${cart.shippingFee.toInt()} XAF"),
          _summaryRow("Tax (5%)", "${cart.tax.toInt()} XAF"),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("TOTAL AMOUNT",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
              Text("${cart.totalAmount} XAF",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF015E38))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isGreen ? const Color(0xFF015E38) : Colors.black)),
        ],
      ),
    );
  }

  Widget _buildDeliveryBanner(CartProvider cart) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFD4EDDA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.local_shipping, color: Color(0xFF155724)),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "FREE DELIVERY ON ALL ORDERS OVER 500,000 XAF",
              style: TextStyle(
                  color: Color(0xFF155724),
                  fontWeight: FontWeight.bold,
                  fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}
