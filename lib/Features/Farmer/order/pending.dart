import 'package:flutter/material.dart';

class PendingOrdersView extends StatelessWidget {
  const PendingOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data list matching the screenshot items
    final List<Map<String, String>> pendingOrders = [
      {
        'id': '#ORD-9928',
        'buyer': 'Green Grocers Ltd.',
        'item': '100kg Organic Tomatoes',
        'image': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500', // Tomato image
      },
      {
        'id': '#ORD-9925',
        'buyer': 'Harvest Market',
        'item': '50 Bags of Fertilizer',
        'image': 'https://images.unsplash.com/photo-1628352081506-83c43123ed6d?w=500', // Fertilizer bags
      },
      {
        'id': '#ORD-9912',
        'buyer': 'Sun-Kissed Grains',
        'item': '500kg Premium Wheat',
        'image': 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=500', // Wheat image
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: pendingOrders.length,
      itemBuilder: (context, index) {
        final order = pendingOrders[index];
        return _buildOrderCard(
          context,
          orderId: order['id']!,
          buyerName: order['buyer']!,
          details: order['item']!,
          imageUrl: order['image']!,
        );
      },
    );
  }

  Widget _buildOrderCard(
    BuildContext context, {
    required String orderId,
    required String buyerName,
    required String details,
    required String imageUrl,
  }) {
    const Color brandGreen = Color(0xFF026139);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Order Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. ID Row
                Text(
                  "ID: $orderId",
                  style: TextStyle(
                    color: brandGreen.withOpacity(0.6),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // 3. Buyer Name & Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buyerName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F3EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Buyer Profile",
                        style: TextStyle(
                          color: brandGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 4. Item Details
                Row(
                  children: [
                    const Icon(Icons.inventory_2_outlined, size: 16, color: brandGreen),
                    const SizedBox(width: 8),
                    Text(
                      details,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 5. Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF1F5F3),
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Reject", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Accept", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}