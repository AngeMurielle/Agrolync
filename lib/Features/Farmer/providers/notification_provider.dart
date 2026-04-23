import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<FarmerNotification> _notifications = [];

  NotificationProvider() {
    _loadInitialNotifications();
  }

  List<FarmerNotification> get notifications => _notifications;

  List<FarmerNotification> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList();

  int get unreadCount => unreadNotifications.length;

  void _loadInitialNotifications() {
    // Initialize with some sample notifications
    _notifications = [
      FarmerNotification.orderNotification(
        orderId: 'ORD-9928',
        buyerName: 'Green Grocers Ltd.',
        productName: 'Organic Tomatoes',
        quantity: '100kg',
        image: 'assets/images/tomato.jpg',
      ),
      FarmerNotification.agronomicTipsNotification(
        tipsTitle: '5 Ways to Improve Tomato Yield in Dry Season',
        tipsContent:
            'Mulching, consistent watering, proper pruning, pest management, and nutrient management are key techniques.',
        category: 'Vegetables',
      ),
      FarmerNotification.orderNotification(
        orderId: 'ORD-9925',
        buyerName: 'Harvest Market',
        productName: 'Organic Onions',
        quantity: '50 Bags',
        image: 'assets/images/onions.jpg',
      ),
    ];
    notifyListeners();
  }

  /// Add a new order notification
  void addOrderNotification({
    required String orderId,
    required String buyerName,
    required String productName,
    required String quantity,
    required String image,
  }) {
    final notification = FarmerNotification.orderNotification(
      orderId: orderId,
      buyerName: buyerName,
      productName: productName,
      quantity: quantity,
      image: image,
    );
    _notifications.insert(0, notification);
    notifyListeners();
  }

  /// Add a new agronomic tips notification
  void addAgronomicTipsNotification({
    required String tipsTitle,
    required String tipsContent,
    required String category,
  }) {
    final notification = FarmerNotification.agronomicTipsNotification(
      tipsTitle: tipsTitle,
      tipsContent: tipsContent,
      category: category,
    );
    _notifications.insert(0, notification);
    notifyListeners();
  }

  /// Add a new product notification
  void addNewProductNotification({
    required String productName,
    required String category,
  }) {
    final notification = FarmerNotification.newProductNotification(
      productName: productName,
      category: category,
    );
    _notifications.insert(0, notification);
    notifyListeners();
  }

  /// Mark notification as read
  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    for (var notification in _notifications) {
      notification.isRead = true;
    }
    notifyListeners();
  }

  /// Delete a notification
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  /// Delete all notifications
  void deleteAllNotifications() {
    _notifications.clear();
    notifyListeners();
  }

  /// Get notifications by type
  List<FarmerNotification> getNotificationsByType(String type) {
    return _notifications.where((n) => n.type == type).toList();
  }

  /// Accept an order
  void acceptOrder(String orderId) {
    final index = _notifications
        .indexWhere((n) => n.type == 'order' && n.data['orderId'] == orderId);
    if (index != -1) {
      _notifications[index].data['status'] = 'accepted';
      notifyListeners();
    }
  }

  /// Reject an order
  void rejectOrder(String orderId) {
    final index = _notifications
        .indexWhere((n) => n.type == 'order' && n.data['orderId'] == orderId);
    if (index != -1) {
      _notifications[index].data['status'] = 'rejected';
      notifyListeners();
    }
  }
}
