import 'package:flutter/material.dart';
// Ensure these paths match your project structure exactly
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/cart/farmer_cart_screen.dart';
import 'package:provider/provider.dart';

class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  // Fixed Navigation Logic
  void _navigateToCategory(BuildContext context, String category) {
    int index;
    switch (category) {
      case "All":
        // Stay on the current page (MarketplaceView)
        return;
      case "Seeds":
        index = 5;
        break;
      case "Fertilizers":
        index = 6;
        break;
      case "Tools":
        index = 7;
        break;
      case "Pesticides":
        index = 8;
        break;
      default:
        return;
    }

    final navProvider = context.read<FarmerNavigationProvider>();
    navProvider.setIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    // 6 Products using Asset Images (Ensure these exist in your pubspec.yaml)
    final products = [
      Product(
        id: 'maize_seeds',
        name: 'Hybrid Maize Seeds',
        category: 'Seeds',
        price: 45000,
        unit: '25kg bag',
        image: 'assets/images/maizeseed.jpg',
        description: 'High-quality hybrid maize seeds for better yield',
        sellerId: 'farmer_coop',
        sellerName: 'AgroLync Cooperative',
        location: 'Douala, Cameroon',
      ),
      Product(
        id: 'npk_fertilizer',
        name: 'NPK Fertilizer',
        category: 'Fertilizers',
        price: 32500,
        unit: '50kg bag',
        image: 'assets/images/npk_fertilizer.jpg',
        description: 'Balanced NPK fertilizer for optimal plant growth',
        sellerId: 'agri_supply',
        sellerName: 'AgriSupply Ltd',
        location: 'Yaoundé, Cameroon',
      ),
      Product(
        id: 'steel_trowel',
        name: 'Steel Hand Trowel',
        category: 'Tools',
        price: 1200,
        unit: 'unit',
        image: 'assets/images/trowel.jpg',
        description: 'Durable steel hand trowel for gardening',
        sellerId: 'tool_master',
        sellerName: 'ToolMaster Cameroon',
        location: 'Bamenda, Cameroon',
      ),
      Product(
        id: 'pest_oil',
        name: 'Organic Pest Oil',
        category: 'Pesticides',
        price: 1899,
        unit: '1L bottle',
        image: 'assets/images/pest_oil.jpg',
        description: 'Natural organic pest control oil',
        sellerId: 'green_farm',
        sellerName: 'GreenFarm Solutions',
        location: 'Limbe, Cameroon',
      ),
      Product(
        id: 'herbicide',
        name: 'Herbicide',
        category: 'Pesticides',
        price: 2500,
        unit: 'unit',
        image: 'assets/images/herbicide.jpg',
        description: 'Effective weed control herbicide',
        sellerId: 'crop_protect',
        sellerName: 'CropProtect Cameroon',
        location: 'Bafoussam, Cameroon',
      ),
      Product(
        id: 'tomato_seeds',
        name: 'Tomato Seeds',
        category: 'Seeds',
        price: 1000,
        unit: 'pkt',
        image: 'assets/images/tomatoseed.jpg',
        description: 'Premium tomato seeds for home gardening',
        sellerId: 'seed_haven',
        sellerName: 'Seed Haven',
        location: 'Kribi, Cameroon',
      ),
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCat(context, "All", Icons.grid_view, true),
              _buildCat(context, "Seeds", Icons.agriculture, false),
              _buildCat(context, "Fertilizers", Icons.science, false),
              _buildCat(context, "Tools", Icons.handyman, false),
              _buildCat(context, "Pesticides", Icons.bug_report, false),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.75,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage(product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${product.price.toStringAsFixed(0)} XAF / ${product.unit}',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            product.sellerName,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10.0,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<FarmerCartProvider>()
                                    .addToCart(product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("${product.name} added to cart!"),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF026139),
                                    action: SnackBarAction(
                                      label: "View Cart",
                                      textColor: Colors.white,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const FarmerCartScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_cart_outlined,
                                  size: 16),
                              label: const Text('Add to Cart'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF026139),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                textStyle: const TextStyle(fontSize: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCat(
      BuildContext context, String label, IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, label),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF026139) : Colors.grey[200],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.black,
              size: 24.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF026139) : Colors.grey[600],
              fontSize: 12.0,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
