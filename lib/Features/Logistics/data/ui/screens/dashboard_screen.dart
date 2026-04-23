import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/market_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map_screen.dart'; // FIX: Added for MapScreen and NavigationSource
import '../widgets/shared/app_drawer.dart';

class DashboardScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const DashboardScreen({super.key, this.onNavigate});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final int _notificationCount = 3;
  // FIX: Removed unused _selectedIndex and _onItemTapped

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(onNavigate: widget.onNavigate),
      appBar: AppBar(
        backgroundColor: const Color(0xFF015E38),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const CircleAvatar(
              backgroundImage:
                  AssetImage("assets/images/ange1.jpeg"), // Your asset
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("John Math",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Row(
              children: [
                Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                        color: Colors.yellow, shape: BoxShape.circle)),
                const SizedBox(width: 5),
                const Text("Active",
                    style: TextStyle(color: Colors.yellow, fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => _showNotificationPanel(context),
                icon: const Icon(Icons.notifications_none_rounded,
                    color: Colors.white, size: 28),
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        color: Colors.yellow, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        _notificationCount.toString(),
                        style: const TextStyle(
                          color: Color(0xFF015E38),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              children: [
                _buildStatCard(
                  title: "Available Jobs",
                  value: "24 New",
                  icon: Icons.local_shipping_outlined,
                  bg: Colors.white,
                  text: Colors.black,
                  cardWidth: MediaQuery.of(context).size.width / 2 - 28,
                  onTap: () {
                    if (widget.onNavigate != null) {
                      widget.onNavigate!(1);
                    } else {
                      Navigator.pushNamed(context, '/market_screen');
                    }
                  },
                ),
                const SizedBox(width: 15),
                _buildStatCard(
                  title: "Active",
                  value: "3 Trips",
                  icon: Icons.route_outlined,
                  bg: const Color(0xFF015E38),
                  text: Colors.white,
                  cardWidth: MediaQuery.of(context).size.width / 2 - 28,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogisticsMarketScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Nearby Requests Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Nearby Requests",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF015E38))),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const MapScreen(source: NavigationSource.logistics),
                    ),
                  ),
                  child: const Text("View Map",
                      style: TextStyle(
                          color: Color(0xFF015E38),
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildFeaturedRequest(),
            const SizedBox(height: 25),
            const Text("TODAY'S OPPORTUNITIES",
                style: TextStyle(
                    color: Color(0xFF015E38),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1)),
            const SizedBox(height: 15),
            _buildOpportunityItem(context, Icons.inventory_2_outlined, "9.850",
                "8.2 km", "West Orchard → City Market"),
            _buildOpportunityItem(context, Icons.ac_unit_rounded, "21.000",
                "45 km", "Dairy Farm → Cold Storage Alpha"),
            _buildOpportunityItem(context, Icons.agriculture, "17.500", "23 km",
                "Green Valley → Food Processing Plant"),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  void _showNotificationPanel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F3EF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.notifications,
                  color: Color(0xFF015E38), size: 24),
            ),
            const SizedBox(width: 12),
            const Text(
              "Notifications",
              style: TextStyle(
                color: Color(0xFF015E38),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationItem(
              "New Job Available",
              "High-priority grain delivery available",
              "2 min ago",
            ),
            const Divider(),
            _buildNotificationItem(
              "Delivery Completed",
              "Your delivery to Central Hub was rated 5 stars!",
              "1 hour ago",
            ),
            const Divider(),
            _buildNotificationItem(
              "New Message",
              "You have a message from the customer",
              "2 hours ago",
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Close",
              style: TextStyle(
                color: Color(0xFF015E38),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String title, String message, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF015E38),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color bg,
    required Color text,
    required double cardWidth,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                // FIX: Replaced deprecated withOpacity with withValues
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
          border: Border.all(
            color: bg == Colors.white
                ? const Color(0xFFE8F3EF)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                color: bg == Colors.white
                    ? const Color(0xFF015E38)
                    : Colors.white70),
            const SizedBox(height: 12),
            Text(title,
                style: TextStyle(
                    // FIX: Replaced deprecated withOpacity with withValues
                    color: text.withValues(alpha: 0.6),
                    fontSize: 13)),
            Text(value,
                style: TextStyle(
                    color: text, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedRequest() {
    const double actionWidth = 120;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8F3EF), width: 2),
          boxShadow: [
            BoxShadow(
                // FIX: Replaced deprecated withOpacity with withValues
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ]),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: const Color(0xFFE8F3EF),
                          borderRadius: BorderRadius.circular(6)),
                      child: const Text("PRIORITY • Grain • 2 Tons",
                          style: TextStyle(
                              color: Color(0xFF015E38),
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 8),
                    const Text("14.500 XAF",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF015E38))),
                    const Row(children: [
                      Icon(Icons.location_on, size: 14, color: Colors.grey),
                      Text(" Central Farm → Metro Hub",
                          style: TextStyle(color: Colors.grey, fontSize: 12))
                    ]),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset("assets/images/maize.jpg",
                    width: 85, height: 85, fit: BoxFit.cover),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
                width: actionWidth,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/market_screen',
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF015E38),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 22)),
                  child: const Text("Accept Job",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 140),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/market_screen'),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color(0xFFE8F3EF),
                      borderRadius: BorderRadius.circular(12),
                      border:
                          Border.all(color: const Color(0xFF015E38), width: 1)),
                  child: const Icon(Icons.more_horiz, color: Color(0xFF015E38)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget _buildOpportunityItem(BuildContext context, IconData icon, String price,
    String dist, String route) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(
      context,
      '/market_screen',
      arguments: {
        'product': route,
        'price': price,
        'distance': dist,
      },
    ),
    child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE8F3EF), width: 1),
          boxShadow: [
            BoxShadow(
                // FIX: Replaced deprecated withOpacity with withValues
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Row(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFFE8F3EF),
                  borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: const Color(0xFF015E38))),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$price XAF",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF015E38))),
                      Text(dist,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12))
                    ]),
                Text(route,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF015E38)),
        ],
      ),
    ),
  );
}
