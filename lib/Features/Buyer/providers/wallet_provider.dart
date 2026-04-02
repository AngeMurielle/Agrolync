import 'package:flutter/material.dart';
import '../models/order_model.dart';

class WalletTransaction {
  final String id;
  final String title;
  final String? productName;
  final String? productImage;
  final int amount;
  final bool isCredit;
  final DateTime date;
  final String status;
  final IconData icon;
  final Color iconColor;

  WalletTransaction({
    required this.id,
    required this.title,
    this.productName,
    this.productImage,
    required this.amount,
    required this.isCredit,
    required this.date,
    required this.status,
    required this.icon,
    required this.iconColor,
  });
}

class WalletProvider with ChangeNotifier {
  double _balance = 4250000;

  final List<WalletTransaction> _transactions = [
    WalletTransaction(
      id: 'tx1',
      title: 'Purchase: Fertilizer X10',
      productName: 'Fertilizer X10',
      productImage: 'assets/images/sample_product.jpg',
      amount: -240000,
      isCredit: false,
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      status: 'SUCCESS',
      icon: Icons.shopping_cart_outlined,
      iconColor: Colors.green,
    ),
    WalletTransaction(
      id: 'tx2',
      title: 'Wallet Top-up',
      amount: 1500000,
      isCredit: true,
      date: DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      status: 'SUCCESS',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Colors.green,
    ),
    WalletTransaction(
      id: 'tx3',
      title: 'Logistics Fee',
      amount: -15000,
      isCredit: false,
      date: DateTime.now().subtract(const Duration(days: 3, hours: 2)),
      status: 'SUCCESS',
      icon: Icons.local_shipping_outlined,
      iconColor: Colors.green,
    ),
  ];

  double get balance => _balance;
  List<WalletTransaction> get transactions => List.unmodifiable(_transactions);

  void addTransaction(WalletTransaction transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  void deposit(int amount) {
    _balance += amount;
    addTransaction(WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Deposit',
      amount: amount,
      isCredit: true,
      date: DateTime.now(),
      status: 'SUCCESS',
      icon: Icons.account_balance_wallet_outlined,
      iconColor: Colors.green,
    ));
  }

  void withdraw(int amount) {
    _balance -= amount;
    addTransaction(WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Withdraw',
      amount: -amount,
      isCredit: false,
      date: DateTime.now(),
      status: 'SUCCESS',
      icon: Icons.account_balance_outlined,
      iconColor: Colors.red,
    ));
  }

  void quickTopUp(String method, int amount) {
    _balance += amount;
    addTransaction(WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '$method Top-up',
      amount: amount,
      isCredit: true,
      date: DateTime.now(),
      status: 'SUCCESS',
      icon: Icons.add_circle_outline,
      iconColor: Colors.green,
    ));
  }

  void deductPurchase(List<Map<String, dynamic>> orderItems, int amount) {
    final firstItem = orderItems.isNotEmpty ? orderItems.first : null;
    final itemCount = orderItems.length;
    final String title = firstItem != null
        ? '${firstItem['name']} ${itemCount > 1 ? '+${itemCount - 1} more' : ''}'
        : 'Product Purchase';

    _balance -= amount;

    addTransaction(WalletTransaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      productName: firstItem != null ? firstItem['name'] as String? : null,
      productImage: firstItem != null ? firstItem['image'] as String? : null,
      amount: -amount,
      isCredit: false,
      date: DateTime.now(),
      status: 'SUCCESS',
      icon: Icons.shopping_cart_outlined,
      iconColor: Colors.green,
    ));
  }
}
