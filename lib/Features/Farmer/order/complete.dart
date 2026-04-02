import 'package:flutter/material.dart';

class CompletedOrdersView extends StatelessWidget {
  const CompletedOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    // Data mapping to your provided 'pending.png' image
    final List<Map<String, dynamic>> completedOrders = [
      {
        'date': 'JAN 12, 2024',
        'buyer': 'Green Grocers Ltd.',
        'earned': '\$1,240.00',
        'item': '100kg Organic Tomatoes',
        'image': 'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?w=500',
      },
      {
        'date': 'JAN 08, 2024',
        'buyer': 'Harvest Market',
        'earned': '\$850.00',
        'item': '50 Bags Organic Fertilizer',
        'image': 'https://images.unsplash.com/photo-1628352081506-83c43123ed6d?w=500',
      },
      {
        'date': 'JAN 05, 2024',
        'buyer': 'Sun-Kissed Grains',
        'earned': '\$2,100.00',
        'item': '500kg Premium Wheat',
        'image': 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=500',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: completedOrders.length,
      itemBuilder: (context, index) {
        final order = completedOrders[index];
        return _buildCompletedCard(
          date: order['date'],
          buyer: order['buyer'],
          earned: order['earned'],
          item: order['item'],
          imageUrl: order['image'],
        );
      },
    );
  }

  Widget _buildCompletedCard({
    required String date,
    required String buyer,
    required String earned,
    required String item,
    required String imageUrl,
  }) {
    const Color brandGreen = Color(0xFF026139);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Image with "Delivered" Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle, color: brandGreen, size: 14),
                      SizedBox(width: 4),
                      Text(
                        "DELIVERED",
                        style: TextStyle(
                          color: brandGreen,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Date and Earned Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "COMPLETED $date",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Earned",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
                
                // 3. Buyer and Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buyer,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      earned,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: brandGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 4. Item Detail
                Row(
                  children: [
                    const Icon(Icons.shopping_basket_outlined, size: 16, color: brandGreen),
                    const SizedBox(width: 8),
                    Text(
                      item,
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 5. Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.receipt_long, size: 16),
                        label: const Text("Receipt"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF1F5F3),
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.star_outline, size: 16),
                        label: const Text("Rate Buyer"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
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