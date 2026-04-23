import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/new_product.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product1.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product2.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product3.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product4.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product5.dart';

class MyListingsView extends StatefulWidget {
  const MyListingsView({super.key});

  @override
  State<MyListingsView> createState() => _MyListingsViewState();
}

class _MyListingsViewState extends State<MyListingsView> {
  final Color brandGreen = const Color(0xFF026139);

  // Note: Using dynamic to allow for different value types,
  // but we cast to String when passing to the Edit page.
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Organic Yellow Maize',
      'stock': '500 Bags',
      'price': '35000 XAF / bag of 100 kg',
      'status': 'ACTIVE',
      'image': 'assets/images/maize.jpg',
      'route': 'product1',
    },
    {
      'name': 'Organic Red Onions',
      'stock': '200 Bags',
      'price': '45000 XAF / bag of 100 kg',
      'status': 'ACTIVE',
      'image': 'assets/images/onions.jpg',
      'route': 'product2',
    },
    {
      'name': 'French Tomatoes',
      'stock': '350 Big Backets',
      'price': '2500 XAF / Basket',
      'status': 'ACTIVE',
      'image': 'assets/images/tomato.jpg',
      'route': 'product3',
    },
    {
      'name': 'Organic Green Beans',
      'stock': '300 Bags',
      'price': '55000 XAF / Bag of 50 kg',
      'status': 'ACTIVE',
      'image': 'assets/images/beans.jpg',
      'route': 'product4',
    },
    {
      'name': 'Organic Carrots',
      'stock': '0 kg',
      'price': '15000 XAF / Bag of 50 kg',
      'status': 'SOLD OUT',
      'image': 'assets/images/carrot.jpg',
      'route': 'product5',
    },
  ];

  void _navigateToProduct(BuildContext context, String routeName) {
    Widget destination;
    // Calling the actual imported Classes
    switch (routeName) {
      case 'product1':
        destination = const Product1Page();
        break;
      case 'product2':
        destination = const Product2Page();
        break;
      case 'product3':
        destination = const Product3Page();
        break;
      case 'product4':
        destination = const Product4Page();
        break;
      case 'product5':
        destination = const Product5Page();
        break;
      default:
        return; // Do nothing if route is unknown
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final item = products[index];
        
        // Automatic status based on stock
        String stockStr = item['stock'] ?? '0';
        int stockValue = int.tryParse(stockStr.split(' ')[0]) ?? 0;
        bool isSoldOut = stockValue <= 0;
        String status = isSoldOut ? 'SOLD OUT' : 'ACTIVE';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _navigateToProduct(context, item['route']),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Opacity(
                        opacity: isSoldOut ? 0.6 : 1.0,
                        child: Image.asset(
                          item['image']!,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade200,
                            child:
                                const Icon(Icons.image_not_supported_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['name']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: isSoldOut ? Colors.grey : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              _buildStatusBadge(status),
                            ],
                          ),
                        const SizedBox(height: 12),
                        _buildRow(Icons.scale_outlined,
                            "Stock: ${item['stock']}", isSoldOut),
                        const SizedBox(height: 6),
                        _buildRow(Icons.payments_outlined,
                            "Price: ${item['price']}", isSoldOut),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          // Casting map to String to resolve the type error
                          builder: (context) => AddNewProductPage(
                            editData: Map<String, String>.from(item),
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text("Edit"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: isSoldOut ? Colors.grey : Colors.black,
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: true, // Farmer cannot click this anymore
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          isSoldOut
                              ? Icons.remove_shopping_cart_outlined
                              : Icons.check_circle_outline,
                          size: 18,
                        ),
                        label: Text(isSoldOut ? "Sold Out" : "Active"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSoldOut
                              ? Colors.grey.shade100
                              : const Color(0xFFE8F3EE),
                          foregroundColor:
                              isSoldOut ? Colors.grey.shade600 : brandGreen,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Helper Widgets ---
  Widget _buildStatusBadge(String status) {
    bool isActive = status == 'ACTIVE';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFE8F3EE) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: isActive ? brandGreen : Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildRow(IconData icon, String text, bool isDimmed) => Row(
        children: [
          Icon(icon,
              size: 16,
              color: isDimmed ? Colors.grey.shade400 : Colors.grey.shade600),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: isDimmed ? Colors.grey.shade400 : Colors.grey.shade700,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      );
}
