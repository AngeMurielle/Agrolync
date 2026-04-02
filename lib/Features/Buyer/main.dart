import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import Core
import 'package:flutter_agrolync_pro/Core/Theme/app_theme.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';

// Import Providers
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';

// Change these in main.dart
//import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/order_provider.dart';
//import 'providers/cart_provider.dart';
//import 'providers/product_provider.dart';
//import 'providers/order_provider.dart';

// Import Screens (All screens must be imported for routes to work)
import 'screens/home/home_screen.dart';
import 'screens/orders/orders_screen.dart';
import 'screens/wallet/wallet_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/checkout/checkout_screen.dart';
import 'screens/notifications/notifications_screen.dart';
import 'package:flutter_agrolync_pro/Features/Onboarding/Splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ],
      child: const AgroLyncApp(),
    ),
  );
}

class AgroLyncApp extends StatelessWidget {
  const AgroLyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroLync',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,

      // The starting point of the app
      home: const SplashScreen(),

      // --- NAMED ROUTES UPDATE ---
      // This allows you to use Navigator.pushNamed(context, '/route_name')
      routes: {
        '/search': (ctx) => const SearchScreen(),
        '/cart': (ctx) => const CartScreen(),
        '/checkout': (ctx) => const CheckoutScreen(),
        '/notifications': (ctx) => const NotificationsScreen(),
        '/home': (ctx) => const MainNavigationWrapper(),
        // Note: ProductDetails usually requires an ID,
        // but we define the route here for general access.
      },
    );
  }
}

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  final List<Widget> _pages = [
    const HomeScreen(),
    const OrdersScreen(),
    const WalletScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavigationProvider>().currentIndex;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          context.read<BottomNavigationProvider>().setIndex(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF015E38),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
