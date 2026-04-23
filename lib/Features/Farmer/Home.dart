import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Market.dart';
// import unchanged - already correct for order.dart
import 'package:flutter_agrolync_pro/Features/Farmer/profile/profile.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/new_product.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/order.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/truck_selection.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/drawer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/search.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/notification.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/wallet/wallet_screen.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/seeds.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/fertilizers.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/tools.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/pesticides.dart';
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
import 'package:flutter_agrolync_pro/Features/Farmer/providers/farmer_navigation_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/providers/notification_provider.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/services/WeatherService.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/models/WeatherModel.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class FarmerHomeScreen extends StatefulWidget {
  final int initialTabIndex;

  const FarmerHomeScreen({super.key, this.initialTabIndex = 0});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
  }

  final List<Widget> _pages = [
    const HomeContent(),
    const MarketPage(),
    const OrderPage(),
    const FarmerWalletScreen(),
    const ProfilePage(),
    const SeedsPage(),
    const FertilizersPage(),
    const ToolsPage(),
    const PesticidesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FarmerNavigationProvider>(
      builder: (context, navProvider, child) {
        // Update local index when provider changes
        _currentIndex = navProvider.currentIndex;
        // For category pages (indices 5-8), show Market (index 1) as selected in bottom nav
        int bottomNavIndex = _currentIndex > 4 ? 1 : _currentIndex;
        return Scaffold(
          body: IndexedStack(index: _currentIndex, children: _pages),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF026139),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: bottomNavIndex,
            onTap: (index) {
              navProvider.setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined), label: "Market"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  label: "Wallet"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "Profile"),
            ],
          ),
        );
      },
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late GlobalKey<ScaffoldState> _scaffoldKey;

  late List<Map<String, String>> products = [
    {
      'title': 'Organic Maize',
      'image': 'assets/images/maize.jpg',
      'subtitle': '500 bags available',
      'price': '35000 XAF/bag of 100 kg',
    },
    {
      'title': 'Red Onions',
      'image': 'assets/images/onions.jpg',
      'subtitle': '200 bags available',
      'price': '45000 XAF/bag of 100 kg',
    },
    {
      'title': 'Fresh Tomatoes',
      'image': 'assets/images/tomato.jpg',
      'subtitle': '350 baskets available',
      'price': '2500 XAF/basket',
    },
    {
      'title': 'Green Beans',
      'image': 'assets/images/beans.jpg',
      'subtitle': '300 bags available',
      'price': '55000 XAF/bag of 50 kg',
    },
    {
      'title': 'Carrots',
      'image': 'assets/images/carrot.jpg',
      'subtitle': '250 bags available',
      'price': '15000 XAF/bag of 50 kg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  static const Color brandGreen = Color(0xFF026139);

  static const List<Map<String, String>> _tips = [
    {
      'tag': 'Nutrient Management',
      'title': 'Soil Nutrient Analysis',
      'desc':
          'Treat your soil like a living organism by testing it every season.',
      'image': 'assets/images/Tip1.jpg'
    },
    {
      'tag': 'Genetics & Germination',
      'title': 'Certified Seed Selection',
      'desc': 'Start with seeds suited to your specific climate and soil.',
      'image': 'assets/images/Tip2.jpg'
    },
    {
      'tag': 'Irrigation Management',
      'title': 'Precision Irrigation Control',
      'desc':
          'Water deeply and less frequently to encourage strong root development.',
      'image': 'assets/images/Trip3.jpg'
    },
    {
      'tag': 'Fertilization Strategy',
      'title': 'Strategic Fertilization Scheduling',
      'desc':
          'Apply nutrients when your crops can use them most, not after they look "hungry".',
      'image': 'assets/images/Tip4.jpg'
    },
    {
      'tag': 'Soil Health & Fertility',
      'title': 'Systematic Crop Rotation',
      'desc':
          'Rotate different types of crops sequentially on the same land to boost fertility..',
      'image': 'assets/images/Tip5.png'
    },
    {
      'tag': 'Pest & Disease Control',
      'title': 'Integrated Pest Management (IPM)',
      'desc':
          'Manage pests through a mix of biological, physical, and chemical controls.',
      'image': 'assets/images/Tip6.jpg'
    },
    {
      'tag': 'Resource Competition',
      'title': 'Early-Stage Weed Suppression',
      'desc':
          'Remove weeds in the first month to stop them from stealing nutrients.',
      'image': 'assets/images/Tip7.jpg'
    },
    {
      'tag': 'Canopy & Airflow',
      'title': 'Geometric Plant Spacing',
      'desc':
          'Use actual measurements to avoid overcrowding and ensure enough airflow.',
      'image': 'assets/images/Tip8.jpg'
    },
    {
      'tag': 'Farm Administration',
      'title': 'Digital Farm Record-Keeping',
      'desc':
          'Track your expenses, planting dates, and yields to learn from every season.',
      'image': 'assets/images/Tip9.jpg'
    },
    {
      'tag': ' Operational Safety',
      'title': 'Preventive Equipment Maintenance',
      'desc':
          'Inspect equipment before the busy season to avoid costly delays.',
      'image': 'assets/images/Tip10.jpg'
    },
  ];

  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewProductPage()));
  }

  void _editProduct(BuildContext context, int index) {
    // Navigate to new_product.dart with product data
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNewProductPage(
                  editData: products[index],
                )));
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Product"),
        content: Text(
            "Are you sure you want to delete ${products[index]['title']}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                products.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Product deleted successfully")),
              );
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _navigateToTip(BuildContext context, int tipIndex) {
    Widget page;
    switch (tipIndex) {
      case 0:
        page = const Tip1Page();
        break;
      case 1:
        page = const Tip2Page();
        break;
      case 2:
        page = const Tip3Page();
        break;
      case 3:
        page = const Tip4Page();
        break;
      case 4:
        page = const Tip5Page();
        break;
      case 5:
        page = const Tip6Page();
        break;
      case 6:
        page = const Tip7Page();
        break;
      case 7:
        page = const Tip8Page();
        break;
      case 8:
        page = const Tip9Page();
        break;
      case 9:
        page = const Tip10Page();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _navigateToProduct(BuildContext context, int productIndex) {
    Widget page;
    switch (productIndex) {
      case 0:
        page = const Product1Page();
        break;
      case 1:
        page = const Product2Page();
        break;
      case 2:
        page = const Product3Page();
        break;
      case 3:
        page = const Product4Page();
        break;
      case 4:
        page = const Product5Page();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: Row(
            children: [
              Consumer<FarmerNavigationProvider>(
                builder: (context, navProvider, child) {
                  final imagePath = navProvider.profileImagePath;
                  return CircleAvatar(
                    radius: 18,
                    backgroundImage: imagePath != null
                        ? (kIsWeb
                            ? NetworkImage(imagePath)
                            : FileImage(File(imagePath))) as ImageProvider
                        : AssetImage(AppImages.person),
                  );
                },
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Welcome back,",
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                    Text("Ange Murielle",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()))),
          Consumer<NotificationProvider>(
            builder: (context, notificationProvider, child) {
              final unreadCount = notificationProvider.unreadCount ?? 0;
              return Stack(
                children: [
                  IconButton(
                      icon: const Icon(Icons.notifications_none_rounded,
                          color: Colors.black),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()))),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: const DrawerPage(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildEarningsCard(),
            const SizedBox(height: 25),
            _buildQuickActions(context),
            const SizedBox(height: 30),
            _buildSectionHeader("Weather Forecast", actionText: "Local: Buea"),
            const SizedBox(height: 15),
            _buildWeatherForecast(),
            const SizedBox(height: 30),
            _buildSectionHeader("Agronomic Tips"),
            const SizedBox(height: 15),
            _buildAgronomicTipsGrid(),
            const SizedBox(height: 30),
            _buildSectionHeader("My Products",
                actionText: "+ Add New",
                onActionTap: () => _navigateToAddProduct(context)),
            const SizedBox(height: 15),
            _buildProductList(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28), color: brandGreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Total Earnings",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("250000 XAF",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold)),
            ),
            const Divider(color: Colors.white24, height: 30),
            Row(
              children: [
                const Expanded(
                  child: Text("12 Active Orders",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Flexible(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FarmerNavigationProvider>().setIndex(3);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: brandGreen,
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      "View Details", 
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              child: _actionItem(
                  context, Icons.playlist_add_check_rounded, "Add Product",
                  onTap: () => _navigateToAddProduct(context))),
        
          Expanded(
              child: _actionItem(
                  context, Icons.account_balance_wallet_outlined, "Withdraw",
                  onTap: () {
            context.read<FarmerNavigationProvider>().setIndex(3);
          })),
          Expanded(
              child: _actionItem(
                  context, Icons.shopping_basket_outlined, "Sell Product",
                  onTap: () {
            context.read<FarmerNavigationProvider>().setIndex(1);
          })),
        ],
      ),
    );
  }

  Widget _actionItem(BuildContext context, IconData icon, String label,
      {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: Icon(icon, color: brandGreen, size: 24),
          ),
          const SizedBox(height: 8),
          Text(label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
              maxLines: 1),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title,
      {String? actionText, VoidCallback? onActionTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold))),
          if (actionText != null)
            GestureDetector(
              onTap: onActionTap,
              child: Text(actionText,
                  style: const TextStyle(
                      color: brandGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
        ],
      ),
    );
  }

  Widget _buildWeatherForecast() {
    return FutureBuilder<WeatherForecast>(
      future: WeatherService.getWeatherForecast(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Loading state
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 150,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(brandGreen),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          // Error state
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning_rounded, color: Colors.red.shade700),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Weather unavailable',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    snapshot.error.toString(),
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.forecast.isEmpty) {
          // No data state
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'No weather data available',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          );
        }

        // Success state - display weather forecast
        final weatherForecast = snapshot.data!;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: weatherForecast.forecast
                .map((weatherDay) => _weatherDay(weatherDay))
                .toList(),
          ),
        );
      },
    );
  }

  Widget _weatherDay(WeatherDay weatherData) {
    final isToday = weatherData.isToday;
    final icon = WeatherService.getWeatherIcon(weatherData.weatherCondition);
    final tempRounded = weatherData.temperatureCelsius.toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: isToday ? brandGreen : Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(
            weatherData.dayName,
            style: TextStyle(
              color: isToday ? Colors.white70 : Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Icon(
            icon,
            color: isToday ? Colors.white : Colors.orange,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            "$tempRounded°C",
            style: TextStyle(
              color: isToday ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgronomicTipsGrid() {
    return Column(
      children: [
        _tipRow(0),
        const SizedBox(height: 15),
        _tipRow(5),
      ],
    );
  }

  Widget _tipRow(int startIdx) {
    return SizedBox(
      height:
          230, // Defined height to prevent vertical expansion issues in horizontal list
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        itemBuilder: (context, index) {
          final gridIndex = startIdx + index;
          final tip = _tips[gridIndex];
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: _tipCard(tip, () => _navigateToTip(context, gridIndex)),
          );
        },
      ),
    );
  }

  Widget _tipCard(Map<String, String> tip, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.asset(tip['image']!,
                    fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: Replace 'tag' here for each Agronomic Tip (e.g., 'CROP CARE')
                    Text(
                      tip['tag']!,
                      style: const TextStyle(
                          color: brandGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    // TODO: Replace 'title' here for each Agronomic Tip (e.g., 'Pro Tip #1')
                    Text(tip['title']!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 1),
                    const SizedBox(height: 2),
                    // TODO: Replace 'desc' here for each Agronomic Tip (e.g., 'Best practices for yield.')
                    Text(tip['desc']!,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _productItem(
            product['title']!,
            product['image']!,
            product['subtitle']!,
            product['price']!,
            Colors.black54,
            () => _navigateToProduct(context, index),
            onEdit: () => _editProduct(context, index),
            onDelete: () => _deleteProduct(index),
          );
        },
      ),
    );
  }

  Widget _productItem(String title, String imagePath, String subtitle,
      String price, Color subColor, VoidCallback onTap,
      {required VoidCallback onEdit, required VoidCallback onDelete}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                        width: 50,
                        height: 50,
                        color: Colors.grey,
                        child: Icon(Icons.image, color: Colors.white, size: 24),
                      )),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(subtitle,
                      style: TextStyle(color: subColor, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(price,
                        style: const TextStyle(
                            color: brandGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                    constraints: const BoxConstraints()),
                IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline,
                        size: 18, color: Colors.redAccent),
                    constraints: const BoxConstraints()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
