import '../models/product_model.dart';

class CartService {
  // Logic to calculate subtotal for a list of items
  static double calculateSubtotal(Map<String, int> cartItems, List<Product> products) {
    double subtotal = 0;
    cartItems.forEach((productId, quantity) {
      final product = products.firstWhere((p) => p.id == productId);
      subtotal += product.price * quantity;
    });
    return subtotal;
  }

  // Future-proofing: Logic to save cart to local storage (SharedPreferences)
  Future<void> persistCart(Map<String, int> items) async {
    // Implementation for local storage would go here
  }
}