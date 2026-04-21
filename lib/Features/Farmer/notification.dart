import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/notification_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/models/notification_model.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/order.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip1.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip2.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip3.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip4.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip5.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip6.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip7.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip8.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip9.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tip10.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product1.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product2.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product3.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product4.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/product5.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, provider, child) {
              return provider.notifications.isNotEmpty
                  ? TextButton(
                      onPressed: () => _showClearDialog(context, provider),
                      child: const Text(
                        'Clear All',
                        style: TextStyle(color: Color(0xFF026139)),
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) {
          if (provider.notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('No notifications yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      )),
                  const SizedBox(height: 16),
                  Text('Notifications about orders and agronomic tips will appear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      )),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.notifications.length,
            itemBuilder: (context, index) {
              final notification = provider.notifications[index];
              return NotificationTile(
                notification: notification,
                provider: provider,
              );
            },
          );
        },
      ),
    );
  }

  void _showClearDialog(BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications?'),
        content: const Text(
            'This action will delete all notifications. This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteAllNotifications();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All notifications cleared')),
              );
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final FarmerNotification notification;
  final NotificationProvider provider;

  const NotificationTile({
    super.key,
    required this.notification,
    required this.provider,
  });

  void _navigateToDestination(BuildContext context) {
    // Mark as read when tapping
    if (!notification.isRead) {
      provider.markAsRead(notification.id);
    }

    Widget page;
    
    switch (notification.type) {
      case 'order':
        page = const OrderPage();
        break;
      case 'agronomic_tips':
        // Navigate to a default tips page or based on category
        page = const Tip1Page();
        break;
      case 'new_product':
        // Navigate to products page (default to product 1)
        page = const Product1Page();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDestination(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
          color: notification.isRead ? Colors.white : Colors.blue[50],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Avatar/Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _getNotificationColor(),
                borderRadius: BorderRadius.circular(8),
              ),
              child: notification.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        notification.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(_getNotificationIcon(),
                                color: Colors.white, size: 28),
                      ),
                    )
                  : Icon(_getNotificationIcon(),
                      color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF026139),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  notification.getTimeAgo(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Action Buttons
          PopupMenuButton(
            itemBuilder: (context) => [
              if (!notification.isRead)
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      provider.markAsRead(notification.id);
                    });
                  },
                  child: const Text('Mark as read'),
                ),
              if (notification.type == 'order')
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      final orderId = notification.data['orderId'] as String?;
                      if (orderId != null) {
                        provider.acceptOrder(orderId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order accepted! Navigate to orders to manage it.'),
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text('Accept'),
                ),
              if (notification.type == 'order')
                PopupMenuItem(
                  onTap: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      final orderId = notification.data['orderId'] as String?;
                      if (orderId != null) {
                        provider.rejectOrder(orderId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Order rejected.'),
                            backgroundColor: Colors.orange,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    });
                  },
                  child: const Text('Reject'),
                ),
              PopupMenuItem(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    provider.deleteNotification(notification.id);
                  });
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
            child: Icon(Icons.more_vert, color: Colors.grey[400]),
          ),
        ],
      ),
      ),
    );
  }

  Color _getNotificationColor() {
    switch (notification.type) {
      case 'order':
        return const Color(0xFF026139);
      case 'agronomic_tips':
        return Colors.green[600]!;
      case 'new_product':
        return Colors.blue[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _getNotificationIcon() {
    switch (notification.type) {
      case 'order':
        return Icons.shopping_bag;
      case 'agronomic_tips':
        return Icons.lightbulb;
      case 'new_product':
        return Icons.add_circle;
      default:
        return Icons.notifications;
    }
  }
}