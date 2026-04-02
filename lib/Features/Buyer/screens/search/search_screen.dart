import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';

import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
// C:\flutter\flutter_agrolync_pro\lib\models\product_model.dart

import '../product/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";
  List<String> recentSearches = [];

  final List<String> categories = [
    "Grains",
    "Vegetables",
    "Fruits",
    "Tubers",
    "Others"
  ];

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    List<Product> filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: _buildSearchField(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: query.isEmpty
            ? _buildInitialView()
            : _buildSearchResults(filteredProducts),
      ),
    );
  }

  // 🔍 SEARCH INPUT
  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "Search products...",
        border: InputBorder.none,
      ),
      onChanged: (value) {
        setState(() {
          query = value;
        });
      },
      onSubmitted: (value) {
        if (value.isNotEmpty && !recentSearches.contains(value)) {
          setState(() {
            recentSearches.add(value);
          });
        }
      },
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

        // 🔥 TRENDING
        const Text(
          "Trending",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        Wrap(
          spacing: 10,
          children: [
            _buildTrendingChip("Maize"),
            _buildTrendingChip("Tomatoes"),
            _buildTrendingChip("Potatoes"),
          ],
        ),

        const SizedBox(height: 20),

        // 🧩 CATEGORIES GRID
        const Text(
          "Categories",
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
                    query = categories[index];
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
  Widget _buildSearchResults(List<Product> results) {
    if (results.isEmpty) {
      return const Center(
        child: Text("No products found"),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];

        return ListTile(
          leading: Image.asset(
            product.image,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Text(product.name),
          subtitle: Text("${product.price} XAF"),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsScreen(product: product),
              ),
            );
          },
        );
      },
    );
  }

  // 🔥 TRENDING CHIP
  Widget _buildTrendingChip(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          query = text;
        });
      },
      child: Chip(
        label: Text(text),
      ),
    );
  }
}