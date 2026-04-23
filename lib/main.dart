import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter_agrolync_pro/Features/Onboarding/Splash.dart';

import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/order_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/bottom_nav_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/wallet_provider.dart';

import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_cart_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/notification_provider.dart';

import 'package:flutter_agrolync_pro/Features/Buyer/screens/home/home_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/search/search_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/cart/cart_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/orders/orders_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/wallet/wallet_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/profile/profile_screen.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/checkout/checkout_screen.dart';

import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map.dart';

/// ===============================
/// APP ENTRY POINT
/// ===============================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ✅ SUPABASE INITIALIZATION
  await Supabase.initialize(
    url: 'https://supabase.com/dashboard/project/hbxknoolhrqmmvhimmyw/settings/general',
    anonKey: 'sb_publishable_BQZEhzpvBQbOaWJjPWwDew_-3Z8egHt',
  );

  runApp(const AgrolyncApp());
}

/// ===============================
/// ROOT APPLICATION
/// ===============================
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
        ChangeNotifierProvider(create: (_) => FarmerNavigationProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: MaterialApp(
        title: 'Agrolync',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF006837),
          ),
          useMaterial3: true,
        ),

        initialRoute: '/',

        routes: {
          '/': (context) => const SplashScreen(),

          /// BUYER
          '/home': (context) => const HomeScreen(),
          '/search': (context) => const SearchScreen(),
          '/cart': (context) => const CartScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/wallet': (context) => const WalletScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/checkout': (context) => const CheckoutScreen(),

          /// LOGISTICS
          '/map': (context) => const LogisticsMapScreen(),
          '/logistics_home': (context) => const MainNavWrapper(),
          '/market_screen': (context) =>
              const MainNavWrapper(initialIndex: 1),
          '/myroute': (context) =>
              const MainNavWrapper(initialIndex: 2),
        },
      ),
    );
  }
}