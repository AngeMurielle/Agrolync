import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_screen.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/app_drawer.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/myroute.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/delivered.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';

//import 'package:flutter_agrolync_pro/Features/Farmer/order/complete.dart';

class LogisticsMarketScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigate;
  const LogisticsMarketScreen({super.key, this.onNavigate});

  @override
  State<LogisticsMarketScreen> createState() => _LogisticsMarketScreenState();
}

class _LogisticsMarketScreenState extends State<LogisticsMarketScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // List to hold jobs moved from "Available" to "My Routes"
  final List<Map<String, dynamic>> _myActiveRoutes = [];

  // Sort + filter state
  String _sortBy = 'Pay';
  bool _isAscending = true;
  String _selectedTag = 'All';

  // All available jobs
  final List<Map<String, dynamic>> _allAvailableJobs = [
    {
      'title': 'Potato Transport - 15 Tons',
      'pickup': 'Bafoussam Market',
      'dropoff': 'Douala Port',
      'price': '250,000',
      'distance': '265 km',
      'weight': '15,000 kg',
      'duration': '6.0 hrs est.',
      'tag': 'EXPRESS',
      'location': const LatLng(5.4777, 10.4176),
    },
    {
      'title': 'Coffee Beans Shipment',
      'pickup': 'Bamenda Coffee Hub',
      'dropoff': 'Douala Export Port',
      'price': '280,000',
      'distance': '310 km',
      'weight': '16,000 kg',
      'duration': '6.5 hrs est.',
      'tag': 'PRIORITY',
      'location': const LatLng(5.9595, 10.1634),
    },
    {
      'title': 'Packaged Goods - Mixed',
      'pickup': 'Bertoua Distribution Center',
      'dropoff': 'Douala Warehouse',
      'price': '215,000',
      'distance': '230 km',
      'weight': '9,800 kg',
      'duration': '4.5 hrs est.',
      'tag': 'STANDARD',
      'location': const LatLng(4.5773, 13.6848),
    },
    {
      'title': 'Cocoa Bulk Transport',
      'pickup': 'Kumba Processing Plant',
      'dropoff': 'Yaoundé Commodity Exchange',
      'price': '295,000',
      'distance': '380 km',
      'weight': '18,500 kg',
      'duration': '7.2 hrs est.',
      'tag': 'HEAVY LOAD',
      'location': const LatLng(4.6363, 9.4469),
    },
    {
      'title': 'Fresh Produce Delivery',
      'pickup': 'Ebolowa Farm Depot',
      'dropoff': 'Yaoundé Central Market',
      'price': '190,000',
      'distance': '185 km',
      'weight': '7,200 kg',
      'duration': '4.0 hrs est.',
      'tag': 'PERISHABLE',
      'location': const LatLng(2.9000, 11.1500),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Logic to move job and switch tabs
  void _acceptJob(Map<String, dynamic> jobData) {
    setState(() {
      _myActiveRoutes.add(jobData);
    });
    // Programmatically switch to the "My Routes" tab (index 1)
    _tabController.animateTo(1);
  }

  // Get available jobs excluding accepted ones, plus filter/sort
  List<Map<String, dynamic>> get _availableJobs {
    var jobs = _allAvailableJobs
        .where((job) =>
            !_myActiveRoutes.any((route) => route['title'] == job['title']))
        .toList();

    if (_selectedTag != 'All') {
      jobs = jobs.where((job) => job['tag'] == _selectedTag).toList();
    }

    jobs.sort((a, b) {
      double aValue = 0, bValue = 0;

      switch (_sortBy) {
        case 'Distance':
          aValue = double.tryParse(a['distance']
                  .toString()
                  .replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          bValue = double.tryParse(b['distance']
                  .toString()
                  .replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          break;
        case 'Weight':
          aValue = double.tryParse(
                  a['weight'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          bValue = double.tryParse(
                  b['weight'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          break;
        case 'Duration':
          aValue = double.tryParse(a['duration']
                  .toString()
                  .replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          bValue = double.tryParse(b['duration']
                  .toString()
                  .replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          break;
        case 'Pay':
        default:
          aValue = double.tryParse(
                  a['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
          bValue = double.tryParse(
                  b['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ??
              0;
      }

      return _isAscending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });

    return jobs;
  }

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
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children:
                        ['Pay', 'Distance', 'Weight', 'Duration'].map((option) {
                      return ChoiceChip(
                        label: Text(option),
                        selected: _sortBy == option,
                        onSelected: (_) {
                          setSheetState(() {
                            _sortBy = option;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setSheetState(() => _isAscending = !_isAscending);
                          },
                          child:
                              Text(_isAscending ? 'Ascending' : 'Descending'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setSheetState(() => _selectedTag = 'All');
                          },
                          child: const Text('Clear Tag'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text("Filter by Tag",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      'All',
                      'EXPRESS',
                      'PRIORITY',
                      'STANDARD',
                      'HEAVY LOAD',
                      'PERISHABLE'
                    ].map((tag) {
                      return ChoiceChip(
                        label: Text(tag),
                        selected: _selectedTag == tag,
                        onSelected: (_) {
                          setSheetState(() {
                            _selectedTag = tag;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF015E38),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Apply',
                          style: TextStyle(color: Colors.white)),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      drawer: AppDrawer(onNavigate: widget.onNavigate),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF015E38)),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainNavWrapper(initialIndex: 0),
                  ),
                  (route) => false,
                ),
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xFF015E38)),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        title: const Text(
          "Logistics Market",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF015E38)),
            onPressed: _showFilterSheet,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF015E38),
          labelColor: const Color(0xFF015E38),
          unselectedLabelColor: Colors.grey,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: const [
            Tab(text: "Available Jobs"),
            Tab(text: "My Routes"),
            Tab(text: "Completed"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAvailableJobsTab(),
          MyRouteTab(activeRoutes: _myActiveRoutes),
          const Delivery(),
        ],
      ),
    );
  }

  Widget _buildAvailableJobsTab() {
    final availableJobs = _availableJobs;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("${availableJobs.length} SHIPMENTS NEARBY"),
          const SizedBox(height: 10),
          if (availableJobs.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(Icons.inbox_outlined,
                        size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    const Text(
                      "No available jobs",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          else
            ...availableJobs
                .map((job) => [
                      JobCard(
                        title: job['title'],
                        pickup: job['pickup'],
                        dropoff: job['dropoff'],
                        price: job['price'],
                        distance: job['distance'],
                        weight: job['weight'],
                        duration: job['duration'],
                        tag: job['tag'],
                        location: job['location'],
                        onAccept: (data) => _acceptJob(data),
                      ),
                      const SizedBox(height: 16),
                    ])
                .expand((element) => element),
          const SpecialOfferCard(
            title: "Onion Transport (Bulk)",
            price: "450,000",
            routeType: "Garoua → Yaoundé",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.grey, fontSize: 11, fontWeight: FontWeight.bold)),
        TextButton.icon(
          onPressed: _showFilterSheet,
          icon: Text("Sort by: $_sortBy",
              style: const TextStyle(fontSize: 11, color: Colors.grey)),
          label: const Icon(Icons.keyboard_arrow_down,
              size: 14, color: Colors.grey),
        )
      ],
    );
  }
}

class JobCard extends StatelessWidget {
  final String title, pickup, dropoff, price, distance, weight, duration, tag;
  final LatLng location;
  final Function(Map<String, dynamic>) onAccept;

  const JobCard({
    super.key,
    required this.title,
    required this.pickup,
    required this.dropoff,
    required this.price,
    required this.distance,
    required this.weight,
    required this.duration,
    required this.tag,
    required this.location,
    required this.onAccept,
  });

  void _showAcceptConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10))),
            const SizedBox(height: 25),
            const Icon(Icons.check_circle_outline,
                color: Color(0xFF015E38), size: 60),
            const SizedBox(height: 15),
            const Text("Confirm Shipment",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              "By accepting, you agree to transport $title from $pickup to $dropoff.",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"))),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Trigger the callback to move the job
                      onAccept({
                        'title': title,
                        'pickup': pickup,
                        'dropoff': dropoff,
                        'price': price,
                        'location': location,
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF015E38),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Confirm & Start",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 140,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: location, zoom: 11),
                    liteModeEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("$price XAF",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    _buildTag(tag),
                  ],
                ),
                const SizedBox(height: 12),
                _buildRouteRow(
                    Icons.location_on, pickup, "Pickup: Tomorrow, 07:00 AM"),
                const SizedBox(height: 8),
                _buildRouteRow(Icons.flag, dropoff, "Distance: $distance"),
                const Divider(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapScreen())),
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: const Text("View Route",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () => _showAcceptConfirmation(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF015E38),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Accept Job",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(5)),
      child: Text(text,
          style: const TextStyle(
              color: Color(0xFF015E38),
              fontSize: 10,
              fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildRouteRow(IconData icon, String title, String sub) {
    return Row(
      children: [
        Icon(icon,
            size: 18,
            color: icon == Icons.flag ? Colors.red : const Color(0xFF015E38)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        )
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  final String title, price, routeType;
  const SpecialOfferCard(
      {super.key,
      required this.title,
      required this.price,
      required this.routeType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8F4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF015E38).withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SPECIAL OFFER",
                  style: TextStyle(
                      color: Color(0xFF015E38),
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              Text("$price XAF",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(routeType,
              style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF015E38),
                minimumSize: const Size(double.infinity, 45)),
            child: const Text("Quick Accept",
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
