class Product {
  final String id;
  final String name;
  final String category; // Grains, Vegetables, Fruits, Tubers, Others
  final double price;
  final String image;
  final String description;
  final String unit; // e.g., "Bag", "Kg", "MT"
  final String sellerId;
  final String sellerName;
  final String location;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    required this.unit,
    required this.sellerId,
    required this.sellerName,
    required this.location,
    this.isFavorite = false,
  });

  // Helper for Search functionality
  bool matchesSearch(String query) {
    return name.toLowerCase().contains(query.toLowerCase()) ||
        category.toLowerCase().contains(query.toLowerCase());
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      price: double.tryParse(map['price']?.toString() ?? '') ?? 0,
      image: map['image']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      unit: map['unit']?.toString() ?? '',
      sellerId: map['seller_id']?.toString() ?? '',
      sellerName: map['seller_name']?.toString() ?? '',
      location: map['location']?.toString() ?? '',
      isFavorite: false,
    );
  }
}