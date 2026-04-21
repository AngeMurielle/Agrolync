import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product_detail_actions.dart';

class AmmoniumNitrateDetails extends StatefulWidget {
  const AmmoniumNitrateDetails({super.key});

  @override
  State<AmmoniumNitrateDetails> createState() => _AmmoniumNitrateDetailsState();
}

class _AmmoniumNitrateDetailsState extends State<AmmoniumNitrateDetails> {
  int _quantity = 1;
  final int _unitPrice = 28000;

  void _incrementQuantity() => setState(() => _quantity++);
  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
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
                  Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/images/ammonium_nitrate1.png'),
                              fit: BoxFit.cover))),
                  const SizedBox(height: 16),
                  const Text("Ammonium Nitrate",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Row(children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(" 4.8 (95 reviews)",
                        style: TextStyle(color: Colors.grey))
                  ]),
                  const SizedBox(height: 8),
                  Text("$_unitPrice XAF",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF026139))),
                  const Text("PER 50KG BAG",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 24),
                  const Text("Specifications",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _buildSpecGrid(),
                  const SizedBox(height: 24),
                  const Text("Description",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text(
                      "High-quality ammonium nitrate with excellent nitrogen content for maximum crop growth.",
                      style: TextStyle(color: Colors.grey, height: 1.5)),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
            ]),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Quantity:", style: TextStyle(fontSize: 16)),
                      Row(children: [
                        IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: _decrementQuantity),
                        Text("$_quantity",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _incrementQuantity)
                      ])
                    ]),
                const SizedBox(height: 12),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          final product = Product(
                            id: 'ammonium_nitrate',
                            name: 'Ammonium Nitrate',
                            category: 'Fertilizers',
                            price: _unitPrice.toDouble(),
                            unit: '50kg bag',
                            image: 'assets/images/ammonium_nitrate1.png',
                            description:
                                'Nitrogen-rich ammonium nitrate fertilizer',
                            sellerId: 'agrolync_fertilizers',
                            sellerName: 'AgroLync Marketplace',
                            location: 'Cameroon',
                          );
                          for (int i = 0; i < _quantity; i++) {
                            context
                                .read<FarmerCartProvider>()
                                .addToCart(product);
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Added $_quantity x ${product.name} to cart!'),
                              duration: const Duration(milliseconds: 1500),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: const Color(0xFF026139),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF026139),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const Text("Add to Cart",
                            style: TextStyle(fontSize: 16)))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecGrid() {
    final specs = [
      {'label': 'Nitrogen', 'value': '34%'},
      {'label': 'Grade', 'value': 'Industrial'},
      {'label': 'Purity', 'value': '99.5%'},
      {'label': 'Package', 'value': '50kg'}
    ];
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2.5,
        children: specs
            .map((spec) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(spec['label']!,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                      Text(spec['value']!,
                          style: const TextStyle(fontWeight: FontWeight.bold))
                    ])))
            .toList());
  }
}
