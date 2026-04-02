enum OrderStatus { pending, shipped, delivered, cancelled }

class OrderModel {
  final String id;
  final DateTime date;
  final List<OrderItem> items;
  final double subtotal;
  final double shippingFee;
  final double tax;
  final double totalAmount;
  final OrderStatus status;
  final String deliveryAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.date,
    required this.items,
    required this.subtotal,
    required this.shippingFee,
    required this.tax,
    required this.totalAmount,
    required this.status,
    required this.deliveryAddress,
    required this.createdAt,
  });

  // Getter to get human-readable status
  String get statusText => status.toString().split('.').last.toUpperCase();
}

class OrderItem {
  final String productId;
  final String productName;
  final String productImage;
  final String sellerName;
  final int quantity;
  final double priceAtPurchase;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.sellerName,
    required this.quantity,
    required this.priceAtPurchase,
  });
}
