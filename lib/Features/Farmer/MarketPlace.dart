import 'package:flutter/material.dart';
// Ensure these paths match your project structure exactly
import 'package:flutter_agrolync_pro/Features/Farmer/seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pesticides.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/fertilizers.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tools.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Hybridmaize.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Maizeseed_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/npk_fertilizer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/npk_fertilizer_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/trowel.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/trowel_cart.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pestoil.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pestoil_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/herbicide.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/herbicide_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tomatoseed.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tomatoseed_card.dart';

class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  // Fixed Navigation Logic
  void _navigateToCategory(BuildContext context, String category) {
    Widget destination;
    switch (category) {
      case "All":
        // Stay on the current page (MarketplaceView)
        return;
      case "Seeds":
        destination = const SeedsPage();
        break;
      case "Fertilizers":
        destination = const FertilizersPage();
        break;
      case "Tools":
        destination = const ToolsPage();
        break;
      case "Pesticides":
        destination = const PesticidesPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 6 Products using Asset Images (Ensure these exist in your pubspec.yaml)
    final products = [
      {
        'name': 'Hybrid Maize Seeds',
        'price': '4.500',
        'unit': '25kg bag',
        'rating': '4.8',
        'reviews': '124',
        'image': 'assets/images/maizeseed.jpg'
      },
      {
        'name': 'NPK Fertilizer',
        'price': '3.250',
        'unit': '50kg bag',
        'rating': '4.9',
        'reviews': '86',
        'image': 'assets/images/npk_fertilizer.jpg'
      },
      {
        'name': 'Steel Hand Trowel',
        'price': '1.200',
        'unit': 'unit',
        'rating': '4.7',
        'reviews': '210',
        'image': 'assets/images/trowel.jpg'
      },
      {
        'name': 'Organic Pest Oil',
        'price': '1.899',
        'unit': '1L bottle',
        'rating': '4.5',
        'reviews': '43',
        'image': 'assets/images/pest_oil.jpg'
      },
      {
        'name': 'Herbicide',
        'price': '2.500',
        'unit': 'unit',
        'rating': '4.6',
        'reviews': '55',
        'image': 'assets/images/herbicide.jpg'
      },
      {
        'name': 'Tomato Seeds',
        'price': '1.000',
        'unit': 'pkt',
        'rating': '4.8',
        'reviews': '92',
        'image': 'assets/images/tomatoseed.jpg'
      },
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
                      child: product['name'] == 'Hybrid Maize Seeds'
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HybridMaizeDetails(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(product['image']!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : product['name'] == 'NPK Fertilizer'
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NpkFertilizerDetails(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12.0),
                                      ),
                                      image: DecorationImage(
                                        image: AssetImage(product['image']!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                              : product['name'] == 'Steel Hand Trowel'
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TrowelDetails(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(12.0),
                                          ),
                                          image: DecorationImage(
                                            image:
                                                AssetImage(product['image']!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : product['name'] == 'Organic Pest Oil'
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const PestoilDetails(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(12.0),
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    product['image']!),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        )
                                      : product['name'] == 'Herbicide'
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HerbicideDetails(),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(12.0),
                                                  ),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        product['image']!),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : product['name'] == 'Tomato Seeds'
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const TomatoseedDetails(),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                        top: Radius.circular(
                                                            12.0),
                                                      ),
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            product['image']!),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                      top:
                                                          Radius.circular(12.0),
                                                    ),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          product['image']!),
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
                            product['name']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            '${product['price']} XAF / ${product['unit']}',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                product['rating']!,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                '(${product['reviews']})',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (product['name'] == 'Hybrid Maize Seeds') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MaizeSeedCartPage(),
                                    ),
                                  );
                                } else if (product['name'] ==
                                    'NPK Fertilizer') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NpkFertilizerCardPage(),
                                    ),
                                  );
                                } else if (product['name'] ==
                                    'Steel Hand Trowel') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TrowelCartPage(),
                                    ),
                                  );
                                } else if (product['name'] ==
                                    'Organic Pest Oil') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const PestoilCardPage(),
                                    ),
                                  );
                                } else if (product['name'] == 'Herbicide') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HerbicideCardPage(),
                                    ),
                                  );
                                } else if (product['name'] == 'Tomato Seeds') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TomatoseedCardPage(),
                                    ),
                                  );
                                } else {
                                  // TODO: add to cart logic / state update
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${product['name']} added to cart'),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(Icons.shopping_cart, size: 16),
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
