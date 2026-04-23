import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map.dart'; // FIX: Import LogisticsMapScreen

// FIX: Added proper class naming and documentation
/// Active orders view for farmers - displays ongoing delivery orders
class Active extends StatelessWidget {
  const Active({super.key});

  @override
  Widget build(BuildContext context) {
    return const ActiveOrdersView();
  }
}

class ActiveOrdersView extends StatelessWidget {
  const ActiveOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> activeOrders = [
      {
        'id': '#ORD-9928',
        'buyer': 'Green Grocers Ltd.',
        'item': '250kg Irish Potatoes',
        // High-quality potato image
        'image':
            'https://images.unsplash.com/photo-1518977676601-b53f02ac6d31?auto=format&fit=crop&q=80&w=500',
        'status': 'In Transit',
        'statusIcon': Icons.local_shipping,
        'actionIcon': Icons.location_on_outlined,
        'actionText': 'Track Delivery',
      },
      {
        'id': '#ORD-9930',
        'buyer': 'Harvest Market',
        'item': '500kg Sweet Corn',
        // High-quality corn image
        'image':
            'https://images.unsplash.com/photo-1551754655-cd27e38d2076?auto=format&fit=crop&q=80&w=500',
        'status': 'Awaiting Pickup',
        'statusIcon': Icons.inventory_2,
        'actionIcon': Icons.calendar_today_outlined,
        'actionText': 'View Schedule',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activeOrders.length,
      itemBuilder: (context, index) {
        final order = activeOrders[index];
        return _buildActiveCard(
          context,
          orderId: order['id'],
          buyerName: order['buyer'],
          details: order['item'],
          imageUrl: order['image'],
          statusLabel: order['status'],
          statusIcon: order['statusIcon'],
          primaryActionIcon: order['actionIcon'],
          primaryActionText: order['actionText'],
        );
      },
    );
  }

  Widget _buildActiveCard(
    BuildContext context, {
    required String orderId,
    required String buyerName,
    required String details,
    required String imageUrl,
    required String statusLabel,
    required IconData statusIcon,
    required IconData primaryActionIcon,
    required String primaryActionText,
  }) {
    const Color brandGreen = Color(0xFF026139);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // FIX: Replaced deprecated withOpacity with withValues
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image with Status Badge Overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // --- IMAGE HANDLING LOGIC ---
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.grey.shade100,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          strokeWidth: 2,
                          color: brandGreen,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image_outlined,
                              color: Colors.grey, size: 40),
                          SizedBox(height: 8),
                          Text("Image unavailable",
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: brandGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, color: Colors.white, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        statusLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
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
                Text(
                  "ID: $orderId",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      buyerName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F3EE),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Buyer Profile",
                        style: TextStyle(
                            color: brandGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined,
                        size: 16, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Text(
                      details,
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text("Message Buyer",
                            overflow: TextOverflow.ellipsis),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black87,
                          backgroundColor: const Color(0xFFF1F5F3),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to map screen for tracking delivery
                          if (primaryActionText == 'Track Delivery') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LogisticsMapScreen(
                                    fromBuyer: false,
                                    source: NavigationSource.farmer),
                              ),
                            );
                          }
                        },
                        icon: Icon(primaryActionIcon, size: 18),
                        label: Text(primaryActionText,
                            overflow: TextOverflow.ellipsis),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
