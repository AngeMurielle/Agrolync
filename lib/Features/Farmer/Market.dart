import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Listing.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/MarketPlace.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/new_product.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/drawer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/wallet/wallet_screen.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/order.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/profile/profile.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/cart/farmer_cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/search.dart'
    show SearchPage;

class MarketPage extends StatefulWidget {
  final int initialTabIndex;

  const MarketPage({super.key, this.initialTabIndex = 0});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color brandGreen = const Color(0xFF026139);

  @override
  void initState() {
    super.initState();
    // length: 2 matches the number of Tabs and TabBarView children
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.initialTabIndex);
  }

  @override
  void dispose() {
    // CRITICAL: This prevents the 'Symbol(dartx.toString)'/TypeError errors
    _tabController.dispose();
    super.dispose();
  }

  void _handleSearchTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }

  void _handleFilterTap() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildFilterSheet(),
    );
  }

  Widget _buildFilterSheet() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildFilterOption('Price: Low to High', Icons.trending_down),
          _buildFilterOption('Price: High to Low', Icons.trending_up),
          _buildFilterOption('Most Popular', Icons.favorite),
          _buildFilterOption('Recently Added', Icons.access_time),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFilterOption(String label, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: brandGreen),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Filtered by: $label')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // We use a Scaffold here for the AppBar and FloatingActionButton,
    // but the BottomNavigationBar is provided by the FarmerHomeScreen parent.
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      drawer: const DrawerPage(initialSelectedItem: 'Marketplace'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            try {
              final navProvider = context.read<FarmerNavigationProvider>();
              navProvider.setIndex(1); // Set to Marketplace index
              Navigator.of(context).pop();
            } catch (e) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const FarmerHomeScreen()),
              );
            }
          },
        ),
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
            onPressed: _handleSearchTap,
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          Consumer<FarmerCartProvider>(
            builder: (context, cart, child) {
              return IconButton(
                icon: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        color: Colors.black, size: 26),
                    if (cart.items.length > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
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
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: brandGreen,
          unselectedLabelColor: Colors.grey,
          indicatorColor: brandGreen,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: const [
            Tab(text: "My Products"),
            Tab(text: "Marketplace"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [MyListingsView(), MarketplaceView()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: brandGreen,
        shape: const CircleBorder(),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddNewProductPage()),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
