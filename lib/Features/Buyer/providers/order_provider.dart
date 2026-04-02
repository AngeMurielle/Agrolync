import 'package:flutter/material.dart';
import '../models/order_model.dart';
import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => [..._orders];

  /// --- SORTING METHOD ---
  void sortOrders(String criteria, bool isAscending) {
    if (criteria == "Price") {
      _orders.sort((a, b) => isAscending
          ? a.totalAmount.compareTo(b.totalAmount)
          : b.totalAmount.compareTo(a.totalAmount));
    } else if (criteria == "Date") {
      _orders.sort((a, b) =>
          isAscending ? a.date.compareTo(b.date) : b.date.compareTo(a.date));
    }
    notifyListeners();
  }

  /// --- ADD ORDER METHOD ---
  void addOrder({
    required List<OrderItem> items,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
    required String address,
  }) {
    final now = DateTime.now();

    final newOrder = OrderModel(
      id: now.millisecondsSinceEpoch.toString(),
      date: now, // The order date
      items: items,
      subtotal: subtotal,
      shippingFee: shipping, // Mapped from 'shipping' parameter
      tax: tax,
      totalAmount: total, // Mapped from 'total' parameter
      status: OrderStatus.pending,
      deliveryAddress: address,
      createdAt: now, // FIXED: Added the missing required field
    );

    _orders.insert(0, newOrder);
    notifyListeners();
  }

  /// --- PLACE ORDER METHOD ---
  void placeOrder(
    CartProvider cart,
    double subtotal,
    double shipping,
    double tax,
    double total,
    String address,
  ) {
    final List<OrderItem> orderItems = [];

    // Assuming cart.items is Map<String, int> where key is ID and value is quantity
    cart.items.forEach((productId, quantity) {
      final product = cart.products[productId];
      if (product != null) {
        orderItems.add(OrderItem(
          productId: productId,
          productName: product.name,
          productImage: product.image,
          sellerName: product.sellerName,
          quantity: quantity,
          priceAtPurchase: product.price,
        ));
      }
    });

    addOrder(
      items: orderItems,
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      total: total,
      address: address,
    );
  }
}
