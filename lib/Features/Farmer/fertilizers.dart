import 'package:flutter/material.dart';
// Ensure these paths match your project structure exactly
import 'package:flutter_agrolync_pro/Features/Farmer/seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pesticides.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
//import 'package:flutter_agrolync_pro/Features/Farmer/fertilizers.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tools.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/npk_fertilizer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/npk_fertilizer_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/urea_fertilizer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/urea_fertilizer_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/potassium_chloride.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/potassium_chloride_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/ammonium_nitrate.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/ammonium_nitrate_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/calcium_nitrate.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/calcium_nitrate_card.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/magnesium_sulfate.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/magnesium_sulfate_card.dart';

class FertilizersPage extends StatefulWidget {
  const FertilizersPage({super.key});

  @override
  State<FertilizersPage> createState() => _FertilizersPageState();
}

class _FertilizersPageState extends State<FertilizersPage> {
  final int _currentIndex = 1; // Market tab is selected
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Fixed Navigation Logic
  void _navigateToCategory(BuildContext context, String category) {
    Widget destination;
    switch (category) {
      case "All":
        // Navigate back to main marketplace
        Navigator.pop(context);
        return;
      case "Seeds":
        destination = const SeedsPage();
        break;
      case "Fertilizers":
        // Already on fertilizers page
        return;
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
          title: const Text('Search Products'),
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search for fertilizers...',
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
  Widget build(BuildContext context) {
    // 6 Products using Asset Images (Ensure these exist in your pubspec.yaml)
    final allProducts = [
      {
        'name': 'NPK Fertilizer 15-15-15',
        'price': '32.500',
        'unit': '50kg bag',
        'rating': '4.9',
        'reviews': '86',
        'image': 'assets/images/npk_fertilizer.jpg'
      },
      {
        'name': 'Urea Fertilizer',
        'price': '25.000',
        'unit': '50kg bag',
        'rating': '4.7',
        'reviews': '124',
        'image': 'assets/images/urea_fertilizer.jpg'
      },
      {
        'name': 'Potassium Chloride',
        'price': '30000',
        'unit': '50kg bag',
        'rating': '4.6',
        'reviews': '78',
        'image': 'assets/images/potassium_chloride.jpg'
      },
      {
        'name': 'Ammonium Nitrate',
        'price': '28.000',
        'unit': '50kg bag',
        'rating': '4.8',
        'reviews': '95',
        'image': 'assets/images/ammonium_nitrate1.png'
      },
      {
        'name': 'Calcium Nitrate',
        'price': '35.000',
        'unit': '25kg bag',
        'rating': '4.5',
        'reviews': '67',
        'image': 'assets/images/calcium_nitrate.jpg'
      },
      {
        'name': 'Magnesium Sulfate',
        'price': '22.000',
        'unit': '25kg bag',
        'rating': '4.7',
        'reviews': '89',
        'image': 'assets/images/magnesium_sulfate.png'
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
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.tune, color: Colors.black, size: 20),
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
                _buildCat(context, "Seeds", Icons.agriculture, false),
                _buildCat(context, "Fertilizers", Icons.science, true),
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
                        child: p['name'] == 'NPK Fertilizer 15-15-15'
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
                            : p['name'] == 'Urea Fertilizer'
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const UreaFertilizerDetails(),
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
                                : p['name'] == 'Potassium Chloride'
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const PotassiumChlorideDetails(),
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
                                    : p['name'] == 'Ammonium Nitrate'
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AmmoniumNitrateDetails(),
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
                                        : p['name'] == 'Calcium Nitrate'
                                            ? GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CalciumNitrateDetails(),
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
                                            : p['name'] == 'Magnesium Sulfate'
                                                ? GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MagnesiumSulfateDetails(),
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
                                      if (p['name'] ==
                                          'NPK Fertilizer 15-15-15') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const NpkFertilizerCardPage()));
                                      } else if (p['name'] ==
                                          'Urea Fertilizer') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const UreaFertilizerCartPage()));
                                      } else if (p['name'] ==
                                          'Potassium Chloride') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const PotassiumChlorideCartPage()));
                                      } else if (p['name'] ==
                                          'Ammonium Nitrate') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AmmoniumNitrateCartPage()));
                                      } else if (p['name'] ==
                                          'Calcium Nitrate') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CalciumNitrateCartPage()));
                                      } else if (p['name'] ==
                                          'Magnesium Sulfate') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MagnesiumSulfateCartPage()));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${p['name']} added to cart')));
                                      }
                                    },
                                    icon: const Icon(Icons.shopping_cart,
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
