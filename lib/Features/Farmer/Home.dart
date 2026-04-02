import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Market.dart';
// import unchanged - already correct for order.dart
import 'package:flutter_agrolync_pro/Features/Farmer/profile/profile.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/new_product.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/order.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/drawer.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/search.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/notification.dart';
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
//lib\Features\Farmer\order\order.dart

class FarmerHomeScreen extends StatefulWidget {
  const FarmerHomeScreen({super.key});

  @override
  State<FarmerHomeScreen> createState() => _FarmerHomeScreenState();
}

class _FarmerHomeScreenState extends State<FarmerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const MarketPage(),
    const OrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF026139),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined), label: "Market"),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});
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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DrawerPage())),
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
                radius: 18, backgroundImage: AssetImage(AppImages.person)),
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
        actions: [
          IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()))),
          IconButton(
              icon: const Icon(Icons.notifications_none_rounded,
                  color: Colors.black),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()))),
        ],
      ),
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
            const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("14,250.00 XAF",
                  style: TextStyle(
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: brandGreen,
                    minimumSize: const Size(100, 36),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Details", style: TextStyle(fontSize: 12)),
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
                  context, Icons.playlist_add_check_rounded, "Add Harvest",
                  onTap: () => _navigateToAddProduct(context))),
          Expanded(
              child: _actionItem(
                  context, Icons.local_shipping_outlined, "Logistics")),
          Expanded(
              child: _actionItem(
                  context, Icons.account_balance_wallet_outlined, "Withdraw")),
          Expanded(
              child: _actionItem(
                  context, Icons.shopping_basket_outlined, "Sell Crop")),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          _weatherDay("Mon", Icons.wb_sunny, "28°C", false),
          _weatherDay("Tue", Icons.wb_cloudy, "26°C", true),
          _weatherDay("Wed", Icons.water_drop, "22°C", false),
          _weatherDay("Thu", Icons.cloud, "25°C", false),
          _weatherDay("Fri", Icons.wb_sunny, "28°C", false),
          _weatherDay("Sat", Icons.wb_cloudy, "26°C", true),
          _weatherDay("Sun", Icons.water_drop, "22°C", false),
        ],
      ),
    );
  }

  Widget _weatherDay(String day, IconData icon, String temp, bool active) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
          color: active ? brandGreen : Colors.white,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(day,
              style: TextStyle(
                  color: active ? Colors.white70 : Colors.grey, fontSize: 12)),
          const SizedBox(height: 8),
          Icon(icon, color: active ? Colors.white : Colors.orange, size: 24),
          const SizedBox(height: 8),
          Text(temp,
              style: TextStyle(
                  color: active ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
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
                    Text(tip['tag']!,
                        style: const TextStyle(
                            color: brandGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 10),),
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
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _productItem(
              "Organic Maize",
              "assets/images/maize.jpg",
              "500 bags available",
              "35000 XAF/bag of 100 kg",
              Colors.black54,
              () => _navigateToProduct(context, 0)),
          _productItem(
              "Red Onions",
              "assets/images/onions.jpg",
              "200 bags available",
              "45000 XAF/bag of 100 kg",
              Colors.black54,
              () => _navigateToProduct(context, 1)),
          _productItem(
              "Fresh Tomatoes",
              "assets/images/tomato.jpg",
              "350 baskets available",
              "2500 XAF/basket",
              Colors.black54,
              () => _navigateToProduct(context, 2)),
          _productItem(
              "Green Beans",
              "assets/images/beans.jpg",
              "300 bags available",
              "55000 XAF/bag of 50 kg",
              Colors.black54,
              () => _navigateToProduct(context, 3)),
          _productItem(
              "Carrots",
              "assets/images/carrot.jpg",
              "250 bags available",
              "15000 XAF/bag of 50 kg",
              Colors.black54,
              () => _navigateToProduct(context, 4)),
        ],
      ),
    );
  }

  Widget _productItem(String title, String imagePath, String subtitle,
      String price, Color subColor, VoidCallback onTap) {
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
                    onPressed: () {},
                    icon: const Icon(Icons.edit, size: 18, color: Colors.grey),
                    constraints: const BoxConstraints()),
                IconButton(
                    onPressed: () {},
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
