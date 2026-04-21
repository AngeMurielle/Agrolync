import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
  // COMPLETE Mock data representing all required categories
  final List<Product> _allProducts = [
    // GRAINS - 4 products
    Product(
      id: 'p1',
      name: 'White Maize',
      category: 'Grains',
      price: 25000,
      image: 'assets/images/white maize.jpg',
      description:
          'Dried white maize, perfect for flour or poultry feed. Grade A quality.',
      unit: 'Bag (50kg)',
      sellerId: 's1',
      sellerName: 'Agro-North Group',
      location: 'Garoua, North Region',
    ),
    Product(
      id: 'p2',
      name: 'Yellow Maize',
      category: 'Grains',
      price: 28000,
      image: 'assets/images/maize.jpg',
      description:
          'Premium yellow maize for animal feed and human consumption.',
      unit: 'Bag (50kg)',
      sellerId: 's2',
      sellerName: 'Farmers Cooperative',
      location: 'Bamenda, North West',
    ),
    Product(
      id: 'p3',
      name: 'Rice Paddy',
      category: 'Grains',
      price: 35000,
      image: 'assets/images/rice paddy.jpg',
      description: 'High-quality local rice paddy, ready for milling.',
      unit: 'Bag (100kg)',
      sellerId: 's3',
      sellerName: 'Rice Farmers Union',
      location: 'Yagoua, Far North',
    ),
    Product(
      id: 'p4',
      name: 'Millet Grains',
      category: 'Grains',
      price: 22000,
      image: 'assets/images/millet grain.jpg',
      description:
          'Traditional millet grains, rich in nutrients and gluten-free.',
      unit: 'Bag (25kg)',
      sellerId: 's4',
      sellerName: 'Sahel Grains Ltd',
      location: 'Maroua, Far North',
    ),

    // VEGETABLES - 4 products
    Product(
      id: 'p5',
      name: 'Fresh Tomatoes',
      category: 'Vegetables',
      price: 5000,
      image: 'assets/images/tomato.jpg',
      description:
          'High-quality organic tomatoes sourced directly from Foumbot. Harvested within 24 hours.',
      unit: 'Basket',
      sellerId: 's5',
      sellerName: 'Farmer Moussa',
      location: 'Foumbot, West Region',
    ),
    Product(
      id: 'p6',
      name: 'Red Onions',
      category: 'Vegetables',
      price: 12000,
      image: 'assets/images/onions.jpg',
      description:
          'Sharp and fresh red onions from the Far North. Long shelf life.',
      unit: 'Bag',
      sellerId: 's6',
      sellerName: 'Mamma Sali',
      location: 'Maroua, Far North',
    ),
    Product(
      id: 'p7',
      name: 'Bell Peppers',
      category: 'Vegetables',
      price: 8000,
      image: 'assets/images/pepperseed.jpg',
      description: 'Colorful bell peppers, perfect for cooking and salads.',
      unit: 'Basket',
      sellerId: 's7',
      sellerName: 'Green Valley Farms',
      location: 'Buea, South West',
    ),
    Product(
      id: 'p8',
      name: 'Fresh Lettuce',
      category: 'Vegetables',
      price: 3000,
      image: 'assets/images/fresh lettuce.jpg',
      description: 'Crisp, fresh lettuce leaves harvested daily.',
      unit: 'Bundle',
      sellerId: 's8',
      sellerName: 'Urban Gardens',
      location: 'Yaounde, Center',
    ),

    // FRUITS - 4 products
    Product(
      id: 'p9',
      name: 'Export Bananas',
      category: 'Fruits',
      price: 3500,
      image: 'assets/images/banana.jpg',
      description:
          'Sweet Cavendish bananas, ready for local consumption or shipping.',
      unit: 'Bunch',
      sellerId: 's9',
      sellerName: 'CDC South',
      location: 'Tiko, South West',
    ),
    Product(
      id: 'p10',
      name: 'Pineapples',
      category: 'Fruits',
      price: 6000,
      image: 'assets/images/pineapple.jpg',
      description: 'Juicy, sweet pineapples from the coastal regions.',
      unit: 'Piece',
      sellerId: 's10',
      sellerName: 'Coastal Fruits Ltd',
      location: 'Limbe, South West',
    ),
    Product(
      id: 'p11',
      name: 'Oranges',
      category: 'Fruits',
      price: 4500,
      image: 'assets/images/orange.jpg',
      description: 'Fresh, vitamin-rich oranges packed with natural sweetness.',
      unit: 'Bag (10kg)',
      sellerId: 's11',
      sellerName: 'Citrus Gardens',
      location: 'Dschang, West Region',
    ),
    Product(
      id: 'p12',
      name: 'Mangoes',
      category: 'Fruits',
      price: 5500,
      image: 'assets/images/mangoes.jpg',
      description: 'Sweet, tropical mangoes at their peak ripeness.',
      unit: 'Basket',
      sellerId: 's12',
      sellerName: 'Tropical Delights',
      location: 'Douala, Littoral',
    ),

    // TUBERS - 4 products
    Product(
      id: 'p13',
      name: 'Sweet Potatoes',
      category: 'Tubers',
      price: 8000,
      image: 'assets/images/sweet potaoes.jpg',
      description:
          'Large, sweet orange-fleshed potatoes. Nutritious and fresh.',
      unit: 'Basket',
      sellerId: 's13',
      sellerName: 'Talla Farms',
      location: 'Bafoussam',
    ),
    Product(
      id: 'p14',
      name: 'Irish Potatoes',
      category: 'Tubers',
      price: 10000,
      image: 'assets/images/irish potatoes.jpg',
      description: 'Premium Irish potatoes, perfect for fries and boiling.',
      unit: 'Bag (25kg)',
      sellerId: 's14',
      sellerName: 'Highland Tubers',
      location: 'Bamenda, North West',
    ),
    Product(
      id: 'p15',
      name: 'Cassava Roots',
      category: 'Tubers',
      price: 4000,
      image: 'assets/images/cassava roots.jpg',
      description:
          'Fresh cassava roots, staple food for many Cameroonian dishes.',
      unit: 'Bundle',
      sellerId: 's15',
      sellerName: 'Cassava Farmers Coop',
      location: 'Nkongsamba, Littoral',
    ),
    Product(
      id: 'p16',
      name: 'Yams',
      category: 'Tubers',
      price: 12000,
      image: 'assets/images/yam.jpg',
      description: 'Large, nutritious yam tubers, traditional African staple.',
      unit: 'Piece',
      sellerId: 's16',
      sellerName: 'Yam Specialists',
      location: 'Bafang, West Region',
    ),

    // OTHERS - 4 products
    Product(
      id: 'p17',
      name: 'Palm Oil',
      category: 'Others',
      price: 15000,
      image: 'assets/images/palm oil.jpg',
      description: 'Pure, unadulterated red palm oil. No additives.',
      unit: '20L Container',
      sellerId: 's17',
      sellerName: 'Eko Village Produce',
      location: 'Edea, Littoral',
    ),
    Product(
      id: 'p18',
      name: 'Groundnuts',
      category: 'Others',
      price: 18000,
      image: 'assets/images/groundnut.jpg',
      description: 'Premium groundnuts, perfect for snacks and oil production.',
      unit: 'Bag (50kg)',
      sellerId: 's18',
      sellerName: 'Nut Producers Union',
      location: 'Garoua, North Region',
    ),
    Product(
      id: 'p19',
      name: 'Cocoa Beans',
      category: 'Others',
      price: 45000,
      image: 'assets/images/cacao beans.jpg',
      description:
          'High-quality cocoa beans, Cameroon\'s famous export product.',
      unit: 'Bag (100kg)',
      sellerId: 's19',
      sellerName: 'Cocoa Farmers Coop',
      location: 'Kumba, South West',
    ),
    Product(
      id: 'p20',
      name: 'Coffee Beans',
      category: 'Others',
      price: 35000,
      image: 'assets/images/coffee beans.jpg',
      description: 'Arabica coffee beans from the highlands, rich flavor.',
      unit: 'Bag (50kg)',
      sellerId: 's20',
      sellerName: 'Mountain Coffee Ltd',
      location: 'Bamenda, North West',
    ),
    Product(
      id: 'p21',
      name: 'Smart Soil Sensor Pro',
      category: 'Others',
      price: 95000,
      image: 'assets/images/garden_hose.jpg',
      description:
          'Advanced soil sensor for monitoring moisture, pH, and nutrient data in real time.',
      unit: 'Unit',
      sellerId: 's21',
      sellerName: 'AgroTech Solutions',
      location: 'Yaounde, Center',
    ),
    Product(
      id: 'p22',
      name: 'Irrigation Kits',
      category: 'Others',
      price: 45000,
      image: 'assets/images/watering_can.jpg',
      description:
          'Complete irrigation kit for small farms and gardens, including hoses and drip fittings.',
      unit: 'Kit',
      sellerId: 's22',
      sellerName: 'GreenFlow Supplies',
      location: 'Douala, Littoral',
    ),
  ];

  Future<void> loadProducts() async {
    // TODO: Integrate Supabase when available
    // For now, use the mock data already defined in _allProducts
    notifyListeners();
  }

  // Get all products
  List<Product> get products => [..._allProducts];

  // Get only favorites for the "Heart" icon functionality
  List<Product> get favorites =>
      _allProducts.where((p) => p.isFavorite).toList();

  // Logic for the Category Filter on Home Screen
  List<Product> getProductsByCategory(String category) {
    if (category == "Others") {
      return _allProducts.where((p) => p.category == "Others").toList();
    }
    return _allProducts.where((p) => p.category == category).toList();
  }

  // CRITICAL for Product Details Screen: Find a product by its ID
  Product findById(String id) {
    return _allProducts.firstWhere((product) => product.id == id);
  }

  // Functional Favorite Toggle
  void toggleFavorite(String productId) {
    final index = _allProducts.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _allProducts[index].isFavorite = !_allProducts[index].isFavorite;
      notifyListeners();
    }
  }

  // Functional Search logic used by the Search Screen
  List<Product> searchProducts(String query) {
    if (query.isEmpty) return [];
    return _allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
          product.category.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
