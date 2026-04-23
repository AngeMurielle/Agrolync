import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/order_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/providers/product_provider.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/order_model.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/models/product_model.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/drawer/drawer.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/screens/product/product_details_screen.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/order/chat_page.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map_screen.dart'; // Import the new MapScreen

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // Filter States for the Bottom Sheet
  String _sortBy = "Date";
  bool _isAscending = false; // Default: Newest/Highest first

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to tab changes to rebuild the custom toggle
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // --- CUSTOM EXACT TOGGLE (MATCHING DESIGN) ---
  Widget _buildExactTabToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      height: 48, // Fixed height from design
      decoration: BoxDecoration(
        color: const Color(0xFFE9EBE9), // Light grey background
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double totalWidth = constraints.maxWidth;
          double tabWidth = (totalWidth / 2);

          return Stack(
            children: [
              // Sliding White Background (The Indicator)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                // Positions the white capsule with 4px internal padding
                left: _tabController.index == 0 ? 4 : tabWidth,
                top: 4,
                bottom: 4,
                child: Container(
                  width: tabWidth -
                      8, // Adjusting for the 4px padding on each side
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
              // The Actual Buttons
              Row(
                children: [
                  _buildTabButton("Active", 0),
                  _buildTabButton("Past", 1),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    bool isSelected = _tabController.index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _tabController.animateTo(index);
          });
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF015E38)
                  : const Color(0xFF7A7A7A),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // --- FILTER BOTTOM SHEET ---
  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Sort By",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  _buildSortOption(setSheetState, "Date", Icons.calendar_today),
                  _buildSortOption(
                      setSheetState, "Price", Icons.payments_outlined),
                  const SizedBox(height: 24),
                  const Text("Order Priority",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildOrderChip(setSheetState, "High/Newest", false),
                      const SizedBox(width: 8),
                      _buildOrderChip(setSheetState, "Low/Oldest", true),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF015E38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Provider.of<OrderProvider>(context, listen: false)
                            .sortOrders(_sortBy, _isAscending);
                        Navigator.pop(context);
                      },
                      child: const Text("Apply Filters",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    List<OrderModel> displayedOrders = orderProvider.orders.where((order) {
      bool isPast = order.status == OrderStatus.delivered ||
          order.status == OrderStatus.cancelled;
      bool matchesTab = _tabController.index == 0 ? !isPast : isPast;
      bool matchesSearch = order.id.toLowerCase().contains(_searchQuery);
      return matchesTab && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF015E38)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: const InputDecoration(
                    hintText: "Search ID...", border: InputBorder.none),
              )
            : const Text("My Orders",
                style: TextStyle(
                    color: Color(0xFF1C1B1B),
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,
                color: Colors.black54),
            onPressed: () => setState(() {
              _isSearching = !_isSearching;
              if (!_isSearching) _searchController.clear();
            }),
          ),
          _buildCustomMenu(),
        ],
      ),
      body: Column(
        children: [
          _buildExactTabToggle(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                if (displayedOrders.isEmpty)
                  _buildEmptyState()
                else
                  ...displayedOrders.map((order) => _buildOrderCard(order)),
                const SizedBox(height: 24),
                if (!_isSearching) _buildSuggestedSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- UI HELPER WIDGETS ---

  Widget _buildOrderCard(OrderModel order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 70,
                  height: 70,
                  color: const Color(0xFFF0F0F0),
                  child: order.items.isNotEmpty
                      ? Image.asset(
                          order.items.first.productImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.eco,
                            color: Color(0xFF015E38),
                          ),
                        )
                      : const Icon(Icons.eco, color: Color(0xFF015E38)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "ORDER #${order.id.substring(order.id.length - 4).toUpperCase()}",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      order.items.isNotEmpty
                          ? order.items.first.productName +
                              (order.items.length > 1
                                  ? ' +${order.items.length - 1} more'
                                  : '')
                          : 'AgroLync Order Item',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text("XAF ${order.totalAmount.toInt()}",
                        style: const TextStyle(
                            color: Color(0xFF015E38),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              _buildStatusBadge(order),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _tabController.index == 0
                        ? () {
                            Navigator.push(
                              context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const MapScreen(source: NavigationSource.buyer),
                                ),
                              );
                            }
                          : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF015E38),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: Text(
                        _tabController.index == 0
                            ? "Track Shipment"
                            : "View Details",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () => _openChat(order),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.chat_bubble,
                      size: 22, color: Color(0xFF535353)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusBadge(OrderModel order) {
    bool isPending = order.status == OrderStatus.pending;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFFFFF4EB) : const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(isPending ? "PENDING" : "COMPLETED",
          style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: isPending ? Colors.orange[700] : Colors.green[700])),
    );
  }

  void _openChat(OrderModel order) {
    final farmerName =
        order.items.isNotEmpty ? order.items.first.sellerName : 'Farmer';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          farmerName: farmerName,
          isBuyer: true,
        ),
      ),
    );
  }

  void _openSuggestedProduct(String title) {
    final provider = Provider.of<ProductProvider>(context, listen: false);
    Product? product;

    try {
      product = provider.products.firstWhere(
        (product) => product.name.toLowerCase() == title.toLowerCase(),
      );
    } catch (_) {
      try {
        product = provider.products.firstWhere(
          (product) =>
              product.name.toLowerCase().contains(title.toLowerCase()) ||
              title.toLowerCase().contains(product.name.toLowerCase()),
        );
      } catch (_) {
        product = null;
      }
    }

    if (product == null) {
      if (title.toLowerCase() == 'smart soil sensor pro') {
        product = provider.findById('p21');
      } else if (title.toLowerCase() == 'irrigation kits') {
        product = provider.findById('p22');
      }
    }

    if (product == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product "$title" is not available yet.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product!),
      ),
    );
  }

  Widget _buildCustomMenu() {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      icon: const Icon(Icons.more_vert, color: Colors.black54),
      onSelected: (val) {
        if (val == "Filter") _showFilterSheet();
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
            value: "Filter",
            child: Row(children: [
              Icon(Icons.filter_list, size: 18, color: Color(0xFF015E38)),
              SizedBox(width: 10),
              Text("Filter Orders")
            ])),
        const PopupMenuItem(
            value: "Help",
            child: Row(children: [
              Icon(Icons.help_outline, size: 18, color: Color(0xFF015E38)),
              SizedBox(width: 10),
              Text("Get Help")
            ])),
      ],
    );
  }

  Widget _buildSortOption(
      StateSetter setSheetState, String title, IconData icon) {
    bool isSelected = _sortBy == title;
    return ListTile(
      leading:
          Icon(icon, color: isSelected ? const Color(0xFF015E38) : Colors.grey),
      title: Text(title,
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: Color(0xFF015E38))
          : null,
      onTap: () => setSheetState(() => _sortBy = title),
    );
  }

  Widget _buildOrderChip(StateSetter setSheetState, String label, bool val) {
    bool isSelected = _isAscending == val;
    return Expanded(
      child: GestureDetector(
        onTap: () => setSheetState(() => _isAscending = val),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFE9F5EF) : Colors.transparent,
            border: Border.all(
              color:
                  isSelected ? const Color(0xFF015E38) : Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? const Color(0xFF015E38) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
        child: Padding(
            padding: EdgeInsets.only(top: 80),
            child: Column(children: [
              Icon(Icons.shopping_basket_outlined,
                  size: 60, color: Colors.grey),
              SizedBox(height: 16),
              Text("No matching orders found",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500))
            ])));
  }

  Widget _buildSuggestedSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Suggested for you",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Row(children: [
        _suggestedCard("Smart Soil Sensor Pro", const Color(0xFF0D633E), true),
        const SizedBox(width: 12),
        _suggestedCard("Irrigation Kits", const Color(0xFFD3E7D7), false),
      ])
    ]);
  }

  Widget _suggestedCard(String title, Color bg, bool isDark) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _openSuggestedProduct(title),
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("NEW ARRIVAL",
                  style: TextStyle(
                      fontSize: 8,
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF015E38),
                      fontSize: 14)),
              const Spacer(),
              if (isDark)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("Shop Now",
                      style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF015E38))),
                )
            ],
          ),
        ),
      ),
    );
  }
}
