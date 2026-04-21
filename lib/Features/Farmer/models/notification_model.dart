class FarmerNotification {
  final String id;
  final String type; // 'order' or 'agronomic_tips' or 'new_product'
  final String title;
  final String message;
  final String? image;
  final DateTime timestamp;
  bool isRead;
  final Map<String, dynamic> data; // Additional data for handling actions

  FarmerNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    this.image,
    required this.timestamp,
    this.isRead = false,
    Map<String, dynamic>? data,
  }) : data = data ?? {};

  // Factory constructors for different notification types
  factory FarmerNotification.orderNotification({
    required String orderId,
    required String buyerName,
    required String productName,
    required String quantity,
    required String image,
  }) {
    return FarmerNotification(
      id: 'order_$orderId',
      type: 'order',
      title: 'New Order from $buyerName',
      message: '$buyerName ordered $quantity of $productName. Tap to accept or reject.',
      image: image,
      timestamp: DateTime.now(),
      data: {
        'orderId': orderId,
        'buyerName': buyerName,
        'productName': productName,
        'quantity': quantity,
      },
    );
  }

  factory FarmerNotification.agronomicTipsNotification({
    required String tipsTitle,
    required String tipsContent,
    required String category,
  }) {
    return FarmerNotification(
      id: 'tips_${DateTime.now().millisecondsSinceEpoch}',
      type: 'agronomic_tips',
      title: 'New Agronomic Tips Available',
      message: tipsTitle,
      image: 'assets/images/agronomic_tips.jpg',
      timestamp: DateTime.now(),
      data: {
        'tipsTitle': tipsTitle,
        'tipsContent': tipsContent,
        'category': category,
      },
    );
  }

  factory FarmerNotification.newProductNotification({
    required String productName,
    required String category,
  }) {
    return FarmerNotification(
      id: 'product_${DateTime.now().millisecondsSinceEpoch}',
      type: 'new_product',
      title: 'Product Added Successfully',
      message: '$productName has been listed in $category.',
      image: 'assets/images/success.jpg',
      timestamp: DateTime.now(),
      data: {
        'productName': productName,
        'category': category,
      },
    );
  }

  String getTimeAgo() {
    final difference = DateTime.now().difference(timestamp);
    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.month}/${timestamp.day}/${timestamp.year}';
    }
  }
}
