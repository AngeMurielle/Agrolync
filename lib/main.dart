import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Onboarding/Splash.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/order_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/wallet_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/home/home_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/search/search_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/cart/cart_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/orders/orders_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/wallet/wallet_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/profile_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/checkout/checkout_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/myroute.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/market_screen.dart';
// Make sure to import the file where your SplashScreen is defined
// import 'splash_screen.dart';

void main() async {
  // 1. Ensure Flutter is ready
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Start the App
  runApp(const AgrolyncApp());
}

class AgrolyncApp extends StatelessWidget {
  const AgrolyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(create: (_) => FarmerCartProvider()),
      ],
      child: MaterialApp(
        title: 'Agrolync',
        debugShowCheckedModeBanner: false, // Cleaner look without the banner
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006837)),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/search': (context) => const SearchScreen(),
          '/cart': (context) => const CartScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/map': (context) => const LogisticsMapScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/logistics_home': (context) => const MainNavWrapper(),
          '/market_screen': (context) => const MainNavWrapper(initialIndex: 1),
          '/myroute': (context) => const MainNavWrapper(initialIndex: 2),
        },
      ),
    );
  }
}
