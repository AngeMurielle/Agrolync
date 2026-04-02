import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Listing.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/MarketPlace.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/new_product.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // CRITICAL: This prevents the 'Symbol(dartx.toString)'/TypeError errors
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We use a Scaffold here for the AppBar and FloatingActionButton,
    // but the BottomNavigationBar is provided by the FarmerHomeScreen parent.
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const FarmerHomeScreen(),
                ),
                (route) => false,
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
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.black),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune, color: Colors.black, size: 20),
            ),
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
