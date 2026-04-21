import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product_detail_actions.dart';

class TomatoseedDetails extends StatefulWidget {
  const TomatoseedDetails({super.key});

  @override
  State<TomatoseedDetails> createState() => _TomatoseedDetailsState();
}

class _TomatoseedDetailsState extends State<TomatoseedDetails> {
  // Logic variables
  int _quantity = 1;
  final int _unitPrice = 1000;

  // Methods for the counter
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _handleAddToCart() {
    final product = Product(
      id: 'tomato_seeds',
      name: 'Tomato Seeds',
      category: 'Seeds',
      price: _unitPrice.toDouble(),
      unit: 'pkt',
      image: 'assets/images/tomatoseed.jpg',
      description: 'Premium tomato seeds for home gardening',
      sellerId: 'seed_haven',
      sellerName: 'Seed Haven',
      location: 'Kribi, Cameroon',
    );

    // Add quantity to cart
    for (int i = 0; i < _quantity; i++) {
      context.read<FarmerCartProvider>().addToCart(product);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Added $_quantity x ${product.name} to cart!"),
        duration: const Duration(milliseconds: 1000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF026139),
      ),
    );
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
        actions: const [
          ProductDetailAppBarActions(),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/tomatoseed.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  const Text(
                    "Tomato Seeds",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(" 4.8 (92 reviews)",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Price Section (XAF behind price)
                  Text(
                    "$_unitPrice XAF",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF026139),
                    ),
                  ),
                  const Text(
                    "PER PACKET",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Product Specifications",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),

                  // Specifications Grid
                  _buildSpecGrid(),

                  const SizedBox(height: 24),
                  const Text(
                    "Product Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "High-quality tomato seeds for home gardens and commercial farms. These seeds produce juicy, flavorful tomatoes with excellent disease resistance. Suitable for various climates and soil types.",
                    style: TextStyle(color: Colors.black87, height: 1.5),
                  ),

                  const SizedBox(height: 24),

                  // Environmental Needs
                  Row(
                    children: [
                      _buildSmallSpec(
                          Icons.water_drop, "WATER NEEDS", "Moderate"),
                      const SizedBox(width: 16),
                      _buildSmallSpec(
                          Icons.landscape, "SOIL TYPE", "Well-drained"),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // --- FOOTER ACTIONS ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Row(
              children: [
                // Decrement/Increment Counter
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _decrementQuantity,
                        icon: const Icon(Icons.remove, size: 20),
                        color: _quantity > 1 ? Colors.black : Colors.grey,
                      ),
                      Text(
                        "$_quantity",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: _incrementQuantity,
                        icon: const Icon(Icons.add,
                            size: 20, color: Color(0xFF026139)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),

                // Add to Cart Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF026139),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildSpecGrid() {
    return Row(
      children: [
        _specCard(Icons.trending_up, "YIELD", "High"),
        const SizedBox(width: 12),
        _specCard(Icons.access_time, "MATURITY", "70-80 Days"),
      ],
    );
  }

  Widget _specCard(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF026139)),
            const SizedBox(height: 8),
            Text(title,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(value,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallSpec(IconData icon, String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F8F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF026139)),
            const SizedBox(height: 4),
            Text(title,
                style: const TextStyle(fontSize: 10, color: Colors.grey)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
