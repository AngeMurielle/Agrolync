import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/widgets/product_card.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/widgets/category_chip.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

// 1. IMPORT YOUR CUSTOM DRAWER
import 'package:flutter_agrolync_pro/Features/Buyer/screens/drawer/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Grains";
  final List<String> categories = [
    "Grains",
    "Vegetables",
    "Fruits",
    "Tubers",
    "Others"
  ];

  bool _isLoading = false;
  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoaded) {
      _hasLoaded = true;
      _loadProducts();
    }
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
    });
    await context.read<ProductProvider>().loadProducts();
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final List<Product> displayedProducts =
        productProvider.getProductsByCategory(selectedCategory);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (context) => Consumer<BottomNavigationProvider>(
            builder: (context, navProvider, child) {
              final profileImagePath = navProvider.profileImagePath;
              return GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage:
                        profileImagePath != null && profileImagePath.isNotEmpty
                            ? (kIsWeb
                                    ? NetworkImage(profileImagePath)
                                    : FileImage(File(profileImagePath)))
                                as ImageProvider
                            : const AssetImage('assets/images/ange1.jpeg'),
                  ),
                ),
              );
            },
          ),
        ),
        title: const Text(
          "AgroLync",
          style: TextStyle(
            color: Color(0xFF015E38),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          _buildNotificationIcon(context),
          _buildCartBadge(context),
        ],
      ),
      drawer: const DrawerScreen(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/search'),
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F5F7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 12),
                      Text(
                        "Search for products...",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Promo Banner
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF015E38),
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/maize.jpg'),
                    fit: BoxFit.cover,
                    opacity: 0.1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Today's Harvest",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Fresh Maize\n20% Discount",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF015E38),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                            ),
                            child: const Text("Buy Now",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Image.asset('assets/images/maize.jpg', height: 100),
                  ],
                ),
              ),
            ),
            // Category Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 45,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryChip(
                    title: categories[index],
                    isSelected: selectedCategory == categories[index],
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                      });
                    },
                  );
                },
              ),
            ),
            // Product Grid
            Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: displayedProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: displayedProducts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildNotificationIcon(BuildContext context) {
    bool hasUnreadNotifications = true;
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined,
              color: Colors.black, size: 26),
          onPressed: () => Navigator.pushNamed(context, '/notifications'),
        ),
        if (hasUnreadNotifications)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              constraints: const BoxConstraints(minWidth: 8, minHeight: 8),
            ),
          ),
      ],
    );
  }

  Widget _buildCartBadge(BuildContext context) {
    final cartItemsCount = context.watch<CartProvider>().items.length;
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined,
              color: Colors.black, size: 26),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
        if (cartItemsCount > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Colors.red, shape: BoxShape.circle),
              child: Text(
                '$cartItemsCount',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }
}
