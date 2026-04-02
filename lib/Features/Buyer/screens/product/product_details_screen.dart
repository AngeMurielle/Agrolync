import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/Chat_page.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      // We use a Stack so the "Message" and "Buy" buttons stay fixed at the bottom
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. TOP IMAGE SECTION WITH FLOATING PRICE
                _buildHeaderImage(context),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CATEGORY & NAME
                      Text(
                        product.category.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF015E38),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1c1b1b),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // TAGS (ORGANIC, READY TO SHIP, ETC)
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildStatusChip(Icons.verified, "CERTIFIED ORGANIC"),
                          _buildStatusChip(
                              Icons.local_shipping, "READY TO SHIP"),
                          _buildStatusChip(Icons.eco, "SUSTAINABLE"),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // FARMER CARD
                      _buildFarmerSection(),

                      const SizedBox(height: 30),

                      // DESCRIPTION
                      const Text(
                        "Product Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.description,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // LOCATION & LOGISTICS
                      const Text(
                        "Location & Logistics",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      _buildLogisticsSection(),

                      // Extra padding for the bottom bar
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. BOTTOM ACTION BUTTONS
          _buildBottomActions(context),
        ],
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeaderImage(BuildContext context) {
    return Stack(
      children: [
        // Product Image
        Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(product.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Floating Price Badge (Top Right of Content)
        Positioned(
          bottom: 30,
          right: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF015E38),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              "${product.price} XAF / ${product.unit}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F3EF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF015E38)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF015E38),
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage(
                'assets/images/farmer_placeholder.png'), // Add an asset here
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.sellerName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  product.location,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildLogisticsSection() {
    // Use the same location as in FarmDetails.dart for consistency
    final LatLng farmLocation = const LatLng(4.1560, 9.2435);

    return Column(
      children: [
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: farmLocation, zoom: 14.0),
              mapType: MapType.hybrid,
              markers: {
                Marker(
                  markerId: const MarkerId("farm_location"),
                  position: farmLocation,
                ),
              },
              // Disable user interactions for display purposes
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              scrollGesturesEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.info_outline, size: 18, color: Color(0xFF015E38)),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Estimated delivery to your location: 3-5 business days via AgroLync Logistics.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF015E38)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatPage(
                        farmerName: product.sellerName,
                        farmerPhone: '+237 692 018 826',
                        isBuyer: true,
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        color: Color(0xFF015E38), size: 18),
                    SizedBox(width: 8),
                    Text("Message Farmer",
                        style: TextStyle(
                            color: Color(0xFF015E38),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF015E38),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                ),
                onPressed: () {
                  context.read<CartProvider>().addToCart(product);
                  Navigator.pushNamed(context, '/cart');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text("Buy Now",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*  // 💬 MESSAGE POPUP
  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Message Farmer"),
          content: const TextField(
            decoration: InputDecoration(
              hintText: "Type your message...",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Message sent")),
                );
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }
}*/
