import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map.dart' as route_map;

//import 'package:flutter_agrolync_pro/Features/Farmer/order/complete.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/delivered.dart';

class MyRouteTab extends StatelessWidget {
  final List<Map<String, dynamic>> activeRoutes;
  final Function(Map<String, dynamic>)? onDeliveryCompleted;
  final TabController? tabController;

  const MyRouteTab({
    super.key,
    required this.activeRoutes,
    this.onDeliveryCompleted,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    if (activeRoutes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping_outlined,
                size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text("No active routes. Accept a job to start tracking.",
                style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: activeRoutes.length,
      itemBuilder: (context, index) {
        final job = activeRoutes[index];
        return _buildShipmentCard(context, job);
      },
    );
  }

  Widget _buildShipmentCard(BuildContext context, Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header: Pickup, Drop-off and Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Vertical Stepper
              Column(
                children: [
                  const Icon(Icons.radio_button_unchecked,
                      color: Color(0xFF015E38), size: 18),
                  // Dotted line
                  ...List.generate(
                    4,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      width: 1,
                      height: 5,
                      color: Colors.grey[300],
                    ),
                  ),
                  const Icon(Icons.circle, color: Color(0xFF015E38), size: 18),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("PICKUP",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(job['pickup'] ?? 'Unknown Hub',
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18)),
                    const SizedBox(height: 24),
                    const Text("DROP-OFF",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(job['dropoff'] ?? 'Unknown Silo',
                        style: const TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18)),
                  ],
                ),
              ),
              // "IN PROGRESS" Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2F0E9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "IN PROGRESS",
                  style: TextStyle(
                      color: Color(0xFF015E38),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),

          const SizedBox(height: 24),

          // 2. Shipment Detail Box (Light Gray Container)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.inventory_2,
                      color: Color(0xFF015E38), size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("SHIPMENT TYPE",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9,
                              fontWeight: FontWeight.bold)),
                      Text(job['title'] ?? 'General Cargo',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 15)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text("ETA",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 9,
                            fontWeight: FontWeight.bold)),
                    Text(job['duration'] ?? '2h 45m',
                        style: const TextStyle(
                            color: Color(0xFF015E38),
                            fontWeight: FontWeight.w900,
                            fontSize: 15)),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 3. Track Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () {
                // Create dropoff location based on dropoff address
                LatLng dropoffLocation;
                if (job['dropoff'].toString().contains('Douala')) {
                  dropoffLocation = const LatLng(4.0511, 9.7679); // Douala
                } else if (job['dropoff'].toString().contains('Yaoundé')) {
                  dropoffLocation = const LatLng(3.8480, 11.5021); // Yaoundé
                } else {
                  dropoffLocation =
                      const LatLng(4.0511, 9.7679); // Default to Douala
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => route_map.LogisticsMapScreen(
                              pickupLocation: job['location'] as LatLng,
                              dropoffLocation: dropoffLocation,
                              pickupAddress: job['pickup'] as String,
                              dropoffAddress: job['dropoff'] as String,
                              jobData: job,
                            )));
              },
              icon: const Icon(Icons.map, color: Colors.white),
              label: const Text("Track on Map",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF015E38),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 4. Complete Delivery Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: OutlinedButton.icon(
              onPressed: () {
                if (onDeliveryCompleted != null) {
                  onDeliveryCompleted!(job);
                }
              },
              icon: const Icon(Icons.check_circle_outline,
                  color: Color(0xFF015E38)),
              label: const Text("Complete Delivery",
                  style: TextStyle(
                      color: Color(0xFF015E38),
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF015E38)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
