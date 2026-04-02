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
}