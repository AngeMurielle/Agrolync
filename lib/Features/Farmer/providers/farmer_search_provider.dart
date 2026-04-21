import 'package:flutter/material.dart';

class FarmerProduct {
  final String name;
  final String price;
  final String stock;
  final String status;
  final String image;
  final String type; // 'my_product' or 'marketplace'
  final String category;
  final String unit;
  final String rating;
  final String reviews;

  FarmerProduct({
    required this.name,
    required this.price,
    required this.image,
    required this.type,
    this.stock = '',
    this.status = 'ACTIVE',
    this.category = '',
    this.unit = '',
    this.rating = '',
    this.reviews = '',
  });

  bool matchesSearch(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
           category.toLowerCase().contains(query.toLowerCase()) ||
           type.toLowerCase().contains(query.toLowerCase());
  }
}

class FarmerSearchProvider extends ChangeNotifier {
  List<FarmerProduct> _allProducts = [];
  List<FarmerProduct> _myProducts = []; // Only farmer's uploaded products
  List<FarmerProduct> _searchResults = [];
  String _currentFilter = 'my_product'; // Default filter: show only my products
  String _selectedCategory = '';
  String _selectedType = '';

  FarmerSearchProvider() {
    _loadProducts();
  }

  List<FarmerProduct> get searchResults => _searchResults;
  String get currentFilter => _currentFilter;
  List<FarmerProduct> get myProducts => _myProducts;

  void _loadProducts() {
    // Farmer's own uploaded products - ONLY these are shown in search
    final myProducts = [
      FarmerProduct(
        name: 'Organic Yellow Maize',
        price: '35.000 XAF / bag of 100 kg',
        stock: '500 Bags',
        status: 'ACTIVE',
        image: 'assets/images/maize.jpg',
        type: 'my_product',
        category: 'Grains & Cereals',
      ),
      FarmerProduct(
        name: 'Organic Red Onions',
        price: '45.000 XAF / bag of 100 kg',
        stock: '200 Bags',
        status: 'ACTIVE',
        image: 'assets/images/onions.jpg',
        type: 'my_product',
        category: 'Vegetables',
      ),
      FarmerProduct(
        name: 'French Tomatoes',
        price: '2500 XAF / Basket',
        stock: '350 Big Baskets',
        status: 'ACTIVE',
        image: 'assets/images/tomato.jpg',
        type: 'my_product',
        category: 'Vegetables',
      ),
      FarmerProduct(
        name: 'Organic Green Beans',
        price: '55.000 XAF / Bag of 50 kg',
        stock: '300 Bags',
        status: 'ACTIVE',
        image: 'assets/images/beans.jpg',
        type: 'my_product',
        category: 'Vegetables',
      ),
      FarmerProduct(
        name: 'Organic Carrots',
        price: '15.000 XAF / Bag of 50 kg',
        stock: '0 kg',
        status: 'SOLD OUT',
        image: 'assets/images/carrot.jpg',
        type: 'my_product',
        category: 'Vegetables',
      ),
    ];

    // Optional: Marketplace products farmer has uploaded
    // If the farmer lists products on the marketplace, they would be added here
    final farmerMarketplaceProducts = [
      // Add marketplace products uploaded by THIS farmer here
      // For now, empty - but structure is in place for future expansion
    ];

    _myProducts = myProducts;
    _allProducts = [...myProducts, ...farmerMarketplaceProducts];
    _searchResults = _myProducts; // Default: show only my products
    notifyListeners();
  }

  /// Search products uploaded by this farmer
  void searchProducts(String query) {
    if (query.isEmpty) {
      _searchResults = _myProducts;
    } else {
      _searchResults = _myProducts
          .where((product) => product.matchesSearch(query))
          .toList();
    }
    notifyListeners();
  }

  /// Filter products by category (only from farmer's products)
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  /// Filter by product type (my_product or marketplace uploaded by farmer)
  void filterByType(String type) {
    _selectedType = type;
    _applyFilters();
  }

  /// Apply combined filters
  void _applyFilters() {
    _searchResults = _myProducts.where((product) {
      bool categoryMatch = _selectedCategory.isEmpty ||
          _selectedCategory == 'All' ||
          product.category == _selectedCategory;
      bool typeMatch = _selectedType.isEmpty ||
          _selectedType == 'All' ||
          product.type == _selectedType;
      return categoryMatch && typeMatch;
    }).toList();
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _selectedCategory = '';
    _selectedType = '';
    _searchResults = _myProducts;
    notifyListeners();
  }

  List<String> getCategories() {
    return _allProducts
        .map((product) => product.category)
        .where((category) => category.isNotEmpty)
        .toSet()
        .toList();
  }

  List<String> getTypes() {
    return ['my_product', 'marketplace'];
  }
}