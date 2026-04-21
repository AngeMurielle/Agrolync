import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import '../services/farmer_delivery_service.dart';

class FarmerCartProvider with ChangeNotifier {
  // Map of ProductID to Quantity
  final Map<String, int> _items = {};
  // Map of ProductID to the actual Product object for easy access
  final Map<String, Product> _products = {};

  CameroonRegion _selectedRegion = CameroonRegion.sameTown;

  Map<String, int> get items => _items;
  Map<String, Product> get products => _products;
  CameroonRegion get selectedRegion => _selectedRegion;

  // Change delivery region and notify UI to recalculate fees
  void updateRegion(CameroonRegion region) {
    _selectedRegion = region;
    notifyListeners();
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (qty) => qty + 1);
    } else {
      _items[product.id] = 1;
      _products[product.id] = product;
    }
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _items.remove(productId);
    _products.remove(productId);
    notifyListeners();
  }

  // Removes the entire product entry from the cart regardless of quantity
  void removeItemCompletely(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]! > 1) {
      _items.update(productId, (qty) => qty - 1);
    } else {
      removeFromCart(productId);
    }
    notifyListeners();
  }

  void increaseQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (qty) => qty + 1);
      notifyListeners();
    }
  }

  // --- MATHEMATICAL LOGIC ---
  double get subtotal {
    double total = 0.0;
    _items.forEach((id, qty) {
      total += _products[id]!.price * qty;
    });
    return total;
  }

  double get shippingFee => FarmerDeliveryService.calculateShippingFee(
      subtotal: subtotal, region: _selectedRegion);

  double get tax => FarmerDeliveryService.calculateTax(subtotal);

  double get totalAmount => subtotal + shippingFee + tax;

  void clearCart() {
    _items.clear();
    _products.clear();
    notifyListeners();
  }

  int get itemCount => _items.length;
}
