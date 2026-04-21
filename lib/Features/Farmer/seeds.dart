import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/cart/farmer_cart_screen.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pesticides.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/fertilizers.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tools.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Hybridmaize.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Maizeseed_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/bean_seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/bean_seeds_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/onion_seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/onion_seeds_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/carrot_seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/carrot_seeds_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pepper_seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pepper_seeds_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tomatoseed.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tomatoseed_card.dart';

class SeedsPage extends StatefulWidget {
  const SeedsPage({super.key});

  @override
  State<SeedsPage> createState() => _SeedsPageState();
}

class _SeedsPageState extends State<SeedsPage> {
  final int _currentIndex = 1; // Market tab is selected
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Fixed Navigation Logic
  void _navigateToCategory(BuildContext context, String category) {
    Widget destination;
    switch (category) {
      case "All":
        // Navigate back to main marketplace while preserving navigation state
        Navigator.of(context).popUntil((route) => route.isFirst);
        return;
      case "Seeds":
        // Already on seeds page
        return;
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

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Search Marketplace'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search all marketplace products...',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.toLowerCase();
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _searchQuery = '';
                  _searchController.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _onBottomNavTap(int index) {
    if (index == _currentIndex) return; // Already on this tab

    switch (index) {
      case 0: // Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FarmerHomeScreen(),
          ),
        );
        break;
      case 1: // Market - go back to main market
        Navigator.pop(context);
        break;
      case 2: // Orders
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FarmerHomeScreen(),
          ),
        );
        // TODO: Set the index to 2 when navigating to home screen
        break;
      case 3: // Profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const FarmerHomeScreen(),
          ),
        );
        // TODO: Set the index to 3 when navigating to home screen
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 6 Products using Asset Images (Ensure these exist in your pubspec.yaml)
    final List<Map<String, String>> allProducts = [
      {
        'name': 'Hybrid Maize Seeds',
        'price': '45000',
        'unit': '25kg bag',
        'rating': '4.8',
        'reviews': '124',
        'image': 'assets/images/maizeseed.jpg'
      },
      {
        'name': 'Bean Seeds',
        'price': '1500',
        'unit': 'kg',
        'rating': '4.7',
        'reviews': '89',
        'image': 'assets/images/beans seed.jpg'
      },
      {
        'name': 'Tomato Seeds',
        'price': '1200',
        'unit': 'pkt',
        'rating': '4.9',
        'reviews': '156',
        'image': 'assets/images/tomatoseed.jpg'
      },
      {
        'name': 'Onion Seeds',
        'price': '1800',
        'unit': 'pkt',
        'rating': '4.6',
        'reviews': '78',
        'image': 'assets/images/onionseed.jpg'
      },
      {
        'name': 'Carrot Seeds',
        'price': '1400',
        'unit': 'pkt',
        'rating': '4.8',
        'reviews': '92',
        'image': 'assets/images/carrots.jpg'
      },
      {
        'name': 'Pepper Seeds',
        'price': '1600',
        'unit': 'pkt',
        'rating': '4.7',
        'reviews': '67',
        'image': 'assets/images/pepperseed.jpg'
      },
    ];

    // Filter products based on search query
    final products = _searchQuery.isEmpty
        ? allProducts
        : allProducts
            .where((product) =>
                product['name']!.toLowerCase().contains(_searchQuery))
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Market",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showSearchDialog,
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Consumer<FarmerCartProvider>(
              builder: (context, cart, child) {
                return IconButton(
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.shopping_cart_outlined,
                          color: Colors.black, size: 20),
                      if (cart.items.length > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Center(
                              child: Text(
                                '${cart.items.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FarmerCartScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCat(context, "All", Icons.grid_view, false),
                _buildCat(context, "Seeds", Icons.agriculture, true),
                _buildCat(context, "Fertilizers", Icons.science, false),
                _buildCat(context, "Tools", Icons.handyman, false),
                _buildCat(context, "Pesticides", Icons.bug_report, false),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      0.68, // Adjusted to fit the "Add to Cart" button better
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: p['name'] == 'Hybrid Maize Seeds'
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
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                  child: Image.asset(
                                    p['image']!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.grey.shade200,
                                      child: const Icon(Icons.image,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                              )
                            : p['name'] == 'Bean Seeds'
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BeanSeedsDetails(),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                      child: Image.asset(
                                        p['image']!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey.shade200,
                                          child: const Icon(Icons.image,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  )
                                : p['name'] == 'Tomato Seeds'
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
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(16)),
                                          child: Image.asset(
                                            p['image']!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Container(
                                              color: Colors.grey.shade200,
                                              child: const Icon(Icons.image,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        ),
                                      )
                                    : p['name'] == 'Onion Seeds'
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const OnionSeedsDetails(),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(16)),
                                              child: Image.asset(
                                                p['image']!,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  color: Colors.grey.shade200,
                                                  child: const Icon(Icons.image,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          )
                                        : p['name'] == 'Carrot Seeds'
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CarrotSeedsDetails(),
                                                    ),
                                                  );
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                          top: Radius.circular(
                                                              16)),
                                                  child: Image.asset(
                                                    p['image']!,
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Container(
                                                      color:
                                                          Colors.grey.shade200,
                                                      child: const Icon(
                                                          Icons.image,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : p['name'] == 'Pepper Seeds'
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const PepperSeedsDetails(),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      16)),
                                                      child: Image.asset(
                                                        p['image']!,
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        errorBuilder: (context,
                                                                error,
                                                                stackTrace) =>
                                                            Container(
                                                          color: Colors
                                                              .grey.shade200,
                                                          child: const Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius
                                                            .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    16)),
                                                    child: Image.asset(
                                                      p['image']!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Container(
                                                        color: Colors
                                                            .grey.shade200,
                                                        child: const Icon(
                                                            Icons.image,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['name']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Row(children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              Text(" ${p['rating']} (${p['reviews']})",
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey))
                            ]),
                            const SizedBox(height: 4),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "${p['price']} XAF ",
                                  style: const TextStyle(
                                      color: Color(0xFF026139),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              TextSpan(
                                  text: "/ ${p['unit']}",
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10))
                            ])),
                            const SizedBox(height: 8),
                            SizedBox(
                                width: double.infinity,
                                height: 32,
                                child: ElevatedButton.icon(
                                    onPressed: () {
                                      final product = Product(
                                        id: p['name']!
                                            .toLowerCase()
                                            .replaceAll(' ', '_'),
                                        name: p['name']!,
                                        category: 'Seeds',
                                        price: double.parse(p['price']!),
                                        unit: p['unit']!,
                                        image: p['image']!,
                                        description:
                                            'High-quality ${p['name']} for farming',
                                        sellerId: 'agrolync_seeds',
                                        sellerName: 'AgroLync Marketplace',
                                        location: 'Cameroon',
                                      );
                                      context
                                          .read<FarmerCartProvider>()
                                          .addToCart(product);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${product.name} added to cart!'),
                                          duration: const Duration(
                                              milliseconds: 1500),
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor:
                                              const Color(0xFF026139),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 16),
                                    label: const Text("Add to Cart"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF026139),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: EdgeInsets.zero,
                                      textStyle: const TextStyle(fontSize: 11),
                                    ))),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF026139),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined), label: "Market"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildCat(
      BuildContext context, String label, IconData icon, bool selected) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, label),
      child: Column(
        children: [
          CircleAvatar(
              radius: 25,
              backgroundColor:
                  selected ? const Color(0xFFE8F3EE) : Colors.grey.shade100,
              child: Icon(icon,
                  color: selected ? const Color(0xFF026139) : Colors.grey)),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: selected ? const Color(0xFF026139) : Colors.grey,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
