import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_search_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product1.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product2.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product3.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product4.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product5.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = "";
  List<String> recentSearches = [];
  String selectedCategory = "";
  String selectedType = "";

  final List<String> categories = [
    "Grains & Cereals",
    "Vegetables",
    "Fruits",
    "Root Crops",
    "Oilseeds",
    "Spices & Herbs",
    "Forage Crops",
    "Seeds",
    "Fertilizers",
    "Tools",
    "Pesticides",
    "Others"
  ];

  final List<Map<String, String>> marketInsights = [
    {
      "title": "Maize Market Trends",
      "subtitle": "Current price: 250 XAF/kg • High demand",
      "image": "assets/images/maize.jpg"
    },
    {
      "title": "Tomato Season Update",
      "subtitle": "Peak season • Price: 150 XAF/kg",
      "image": "assets/images/tomato.jpg"
    },
    {
      "title": "Cassava Export Opportunities",
      "subtitle": "International demand rising",
      "image": "assets/images/cassava.jpg"
    },
  ];

  // Navigate to product details based on product name
  void _navigateToProductDetails(BuildContext context, String productName) {
    Widget page;
    
    // Map product names to their respective pages
    if (productName.toLowerCase().contains('maize') || productName.toLowerCase().contains('corn')) {
      page = const Product1Page();
    } else if (productName.toLowerCase().contains('onion')) {
      page = const Product2Page();
    } else if (productName.toLowerCase().contains('tomato')) {
      page = const Product3Page();
    } else if (productName.toLowerCase().contains('bean')) {
      page = const Product4Page();
    } else if (productName.toLowerCase().contains('carrot')) {
      page = const Product5Page();
    } else {
      // Default to product 1 if no match
      page = const Product1Page();
    }
    
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FarmerSearchProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: _buildSearchField(),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () => _showFilterDialog(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: query.isEmpty && selectedCategory.isEmpty && selectedType.isEmpty
              ? _buildInitialView()
              : _buildSearchResults(),
        ),
      ),
    );
  }

  // 🔍 SEARCH INPUT
  Widget _buildSearchField() {
    return Consumer<FarmerSearchProvider>(
      builder: (context, provider, child) {
        return TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search products, crops, supplies...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              query = value;
            });
            provider.searchProducts(value);
          },
          onSubmitted: (value) {
            if (value.isNotEmpty && !recentSearches.contains(value)) {
              setState(() {
                recentSearches.add(value);
              });
            }
          },
        );
      },
    );
  }

  // FILTER DIALOG
  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Products'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Category Filter
            DropdownButtonFormField<String>(
              initialValue: selectedCategory.isEmpty ? null : selectedCategory,
              decoration: const InputDecoration(labelText: 'Category'),
              items: ['All', ...categories].map((category) {
                return DropdownMenuItem(
                  value: category == 'All' ? '' : category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value ?? '';
                });
                Provider.of<FarmerSearchProvider>(context, listen: false)
                    .filterByCategory(selectedCategory);
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 16),
            // Type Filter
            DropdownButtonFormField<String>(
              initialValue: selectedType.isEmpty ? null : selectedType,
              decoration: const InputDecoration(labelText: 'Type'),
              items: ['All', 'My Products', 'Marketplace'].map((type) {
                return DropdownMenuItem(
                  value: type == 'All' ? '' : (type == 'My Products' ? 'my_product' : 'marketplace'),
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value ?? '';
                });
                Provider.of<FarmerSearchProvider>(context, listen: false)
                    .filterByType(selectedType);
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedCategory = '';
                selectedType = '';
              });
              Provider.of<FarmerSearchProvider>(context, listen: false)
                  .searchProducts(query);
              Navigator.pop(context);
            },
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  // 📌 INITIAL VIEW (NO SEARCH YET)
  Widget _buildInitialView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🕒 RECENT SEARCHES
        if (recentSearches.isNotEmpty) ...[
          const Text(
            "Recent Searches",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: recentSearches.map((item) {
              return Chip(
                label: Text(item),
                onDeleted: () {
                  setState(() {
                    recentSearches.remove(item);
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],

        // 🔥 MARKET INSIGHTS
        const Text(
          "Market Insights",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: marketInsights.length,
            itemBuilder: (context, index) {
              final insight = marketInsights[index];
              return Container(
                width: 200,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      insight["subtitle"]!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // 🧩 CROP CATEGORIES
        const Text(
          "Browse Categories",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Expanded(
          child: GridView.builder(
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = categories[index];
                  });
                  Provider.of<FarmerSearchProvider>(context, listen: false)
                      .filterByCategory(categories[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF026139).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: const Color(0xFF026139).withValues(alpha: 0.2)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF026139),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  // 🔎 SEARCH RESULTS
  Widget _buildSearchResults() {
    return Consumer<FarmerSearchProvider>(
      builder: (context, provider, child) {
        final results = provider.searchResults;

        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  query.isEmpty ? "No products found" : "No results found for '$query'",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Try searching for crops, supplies, or tools",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Active Filters
            if (selectedCategory.isNotEmpty || selectedType.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.filter_list, size: 16, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      "Filters: ${selectedCategory.isNotEmpty ? selectedCategory : ''} ${selectedType.isNotEmpty ? (selectedType == 'my_product' ? 'My Products' : 'Marketplace') : ''}".trim(),
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.clear, size: 16, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          selectedCategory = '';
                          selectedType = '';
                        });
                        provider.searchProducts(query);
                      },
                    ),
                  ],
                ),
              ),

            // Results Count
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "${results.length} product${results.length == 1 ? '' : 's'} found",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),

            // Results List
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final product = results[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(product.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (product.type == 'my_product')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: product.status == 'ACTIVE'
                                    ? Colors.green.shade100
                                    : Colors.red.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                product.status,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: product.status == 'ACTIVE'
                                      ? Colors.green.shade800
                                      : Colors.red.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.price,
                            style: const TextStyle(
                              color: Color(0xFF026139),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (product.stock.isNotEmpty)
                            Text(
                              "Stock: ${product.stock}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          if (product.rating.isNotEmpty)
                            Row(
                              children: [
                                const Icon(Icons.star, size: 14, color: Colors.amber),
                                Text(
                                  " ${product.rating} (${product.reviews})",
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              color: product.type == 'my_product'
                                  ? Colors.blue.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              product.type == 'my_product' ? 'My Product' : 'Marketplace',
                              style: TextStyle(
                                fontSize: 10,
                                color: product.type == 'my_product'
                                    ? Colors.blue.shade800
                                    : Colors.orange.shade800,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to product details page
                        _navigateToProductDetails(context, product.name);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}