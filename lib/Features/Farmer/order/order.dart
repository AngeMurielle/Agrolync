import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/pending_orders.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/active_orders.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/completed_orders.dart';
// ignore: unused_import
import '../Home.dart' as home_page;
import '../drawer.dart';
import '../wallet/wallet_screen.dart';
import '../profile/profile.dart';
import '../Market.dart';
import 'package:provider/provider.dart';
import '../providers/farmer_navigation_provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color brandGreen = const Color(0xFF026139);

  // Product stock tracking
  Map<String, int> productStock = {
    'tomato': 350, // 350 baskets of tomatoes (matching Listing.dart)
    'onion': 200, // 200 bags of onions (matching Listing.dart)
    'maize': 500, // 500 bags of maize (matching Listing.dart)
    'beans': 300, // 300 bags of beans (matching Listing.dart)
    'carrot': 0, // 0 kg of carrots (SOLD OUT in Listing.dart)
  };

  // Shared state for all orders
  List<Map<String, dynamic>> pendingOrders = [
    {
      'id': '#ORD-9928',
      'buyer': 'Green Grocers Ltd.',
      'item': '100kg Organic Tomatoes',
      'quantity': 100,
      'quantityUnit': 'kg',
      'image': 'assets/images/tomato.jpg',
      'buyerPhone': '+1 (555) 123-4567',
      'buyerEmail': 'contact@greengrocer.com',
      'location': '123 Market St, Lagos, Nigeria',
      'productType': 'tomato',
    },
    {
      'id': '#ORD-9925',
      'buyer': 'Harvest Market',
      'item': '50 Bags of Onions',
      'quantity': 50,
      'quantityUnit': 'Bags',
      'image': 'assets/images/onions.jpg',
      'buyerPhone': '+1 (555) 234-5678',
      'buyerEmail': 'info@harvestmarket.com',
      'location': '456 Farm Ave, Abuja, Nigeria',
      'productType': 'onion',
    },
    {
      'id': '#ORD-9912',
      'buyer': 'Sun-Kissed Grains',
      'item': '500kg Premium Maize',
      'quantity': 500,
      'quantityUnit': 'kg',
      'image': 'assets/images/maize.jpg',
      'buyerPhone': '+1 (555) 345-6789',
      'buyerEmail': 'sales@sunskissedgrains.com',
      'location': '789 Agricultural Rd, Kano, Nigeria',
      'productType': 'maize',
    },
    {
      'id': '#ORD-9910',
      'buyer': 'Fresh Produce Co.',
      'item': '150 Bags of Organic Green Beans',
      'quantity': 150,
      'quantityUnit': 'Bags',
      'image': 'assets/images/beans.jpg',
      'buyerPhone': '+1 (555) 456-7890',
      'buyerEmail': 'orders@freshproduce.com',
      'location': '321 Produce St, Port Harcourt, Nigeria',
      'productType': 'beans',
    },
    {
      'id': '#ORD-9908',
      'buyer': 'City Market Distributors',
      'item': '200 Bags of Organic Carrots',
      'quantity': 200,
      'quantityUnit': 'Bags',
      'image': 'assets/images/carrot.jpg',
      'buyerPhone': '+1 (555) 567-8901',
      'buyerEmail': 'procurement@citymarket.com',
      'location': '654 Distribution Ave, Ibadan, Nigeria',
      'productType': 'carrot',
    },
  ];

  List<Map<String, dynamic>> activeOrders = [];
  List<Map<String, dynamic>> completedOrders = [];

  void _rejectOrder(int index) {
    setState(() {
      pendingOrders.removeAt(index);
    });
  }

  void _acceptOrder(int index) {
    setState(() {
      final order = pendingOrders[index];
      final productType = order['productType'] as String;
      final quantity = order['quantity'] as int;

      // Reduce stock when order is accepted
      if (productStock.containsKey(productType)) {
        productStock[productType] = (productStock[productType]! - quantity)
            .clamp(0, double.maxFinite)
            .toInt();
      }

      activeOrders.add({
        ...order,
        'status': 'Truck Available',
        'statusIcon': Icons.local_shipping_outlined,
        'acceptedDate': DateTime.now(),
      });
      pendingOrders.removeAt(index);
    });
  }

  void _completeOrder(int index) {
    setState(() {
      final order = activeOrders[index];
      completedOrders.add({
        ...order,
        'completedDate': DateTime.now(),
        'earned': '\$1,240.00',
      });
      activeOrders.removeAt(index);
    });
  }

  void _selectTruck(int orderIndex, Map<String, dynamic> truck) {
    setState(() {
      activeOrders[orderIndex]['truck'] = truck;
      activeOrders[orderIndex]['status'] = 'In Transit';
      activeOrders[orderIndex]['statusIcon'] = Icons.local_shipping;
      activeOrders[orderIndex]['truckAssignedDate'] = DateTime.now();
    });
  }

  void _markOrderDelivered(int orderIndex) {
    setState(() {
      final order = activeOrders[orderIndex];
      completedOrders.add({
        ...order,
        'completedDate': DateTime.now(),
        'deliveredDate': DateTime.now(),
        'earned': '\$1,240.00',
        'status': 'Delivered',
      });
      activeOrders.removeAt(orderIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Important for memory management
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      drawer: const DrawerPage(initialSelectedItem: 'My Orders'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () {
            try {
              final navProvider = context.read<FarmerNavigationProvider>();
              navProvider.setIndex(2); // Set to Orders index
              Navigator.of(context).pop();
            } catch (e) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const home_page.FarmerHomeScreen()),
              );
            }
          },
        ),
        centerTitle: false,
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: brandGreen,
          unselectedLabelColor: Colors.grey,
          indicatorColor: brandGreen,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          tabs: const [
            Tab(text: "Pending"),
            Tab(text: "Active"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PendingOrdersView(
            orders: pendingOrders,
            onReject: _rejectOrder,
            onAccept: _acceptOrder,
            productStock: productStock,
          ),
          ActiveOrdersView(
            orders: activeOrders,
            onComplete: _completeOrder,
            onTruckSelected: _selectTruck,
            onOrderDelivered: _markOrderDelivered,
          ),
          CompletedOrdersView(
            orders: completedOrders,
          ),
        ],
      ),
    );
  }
}
