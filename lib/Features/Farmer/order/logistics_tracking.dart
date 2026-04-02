import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class LogisticsTrackingPage extends StatefulWidget {
  final Map<String, dynamic> order;
  final Function()? onDeliveryConfirmed;

  const LogisticsTrackingPage({
    super.key,
    required this.order,
    this.onDeliveryConfirmed,
  });

  @override
  State<LogisticsTrackingPage> createState() => _LogisticsTrackingPageState();
}

class _LogisticsTrackingPageState extends State<LogisticsTrackingPage> {
  final Color brandGreen = const Color(0xFF026139);

  // ignore: unused_field
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};

  final LatLng _pickupLocation = const LatLng(4.1560, 9.2435); // Buea
  final LatLng _destinationLocation = const LatLng(4.1660, 9.2535);
  final LatLng _truckLocation = const LatLng(4.1610, 9.2485);

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
        markerId: const MarkerId("pickup"),
        position: _pickupLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: "Pickup Location"),
      ),
      Marker(
        markerId: const MarkerId("truck"),
        position: _truckLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: "Truck Location"),
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: _destinationLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: "Destination"),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Track Delivery",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Map
              Container(
                height: 300,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: _truckLocation, zoom: 14.0),
                        onMapCreated: (controller) => _mapController = controller,
                        mapType: MapType.hybrid,
                        markers: _markers,
                      ),
                  // Live Tracking overlay
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Live Tracking",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Order Details
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order ${widget.order['id']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildTrackingStep(
                    "Order Accepted",
                    "Your order has been accepted and assigned to a driver",
                    Icons.check_circle,
                    Colors.green,
                    true,
                  ),
                  _buildTrackingStep(
                    "In Transit",
                    "Driver is on the way to pickup location",
                    Icons.local_shipping,
                    brandGreen,
                    true,
                  ),
                  _buildTrackingStep(
                    "Picked Up",
                    "Driver has picked up the goods",
                    Icons.inventory_2,
                    Colors.orange,
                    false,
                  ),
                  _buildTrackingStep(
                    "Delivered",
                    "Order delivered successfully",
                    Icons.flag,
                    Colors.grey,
                    false,
                  ),

                  const Spacer(),

                  // Driver Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Color(0xFF026139),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Driver: Emma",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Vehicle: ABC-1234",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final Uri phoneUri =
                                Uri(scheme: 'tel', path: '+237678010040');
                            if (await canLaunchUrl(phoneUri)) {
                              await launchUrl(phoneUri);
                            } else {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Cannot open phone dialer.")),
                                );
                              }
                            }
                          },
                          icon:
                              const Icon(Icons.phone, color: Color(0xFF026139)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Confirm Delivery Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm Delivery"),
                              content: const Text(
                                  "Please confirm that you have received the order. This action cannot be undone."),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                    if (widget.onDeliveryConfirmed != null) {
                                      widget.onDeliveryConfirmed!();
                                    }
                                    Navigator.pop(context); // Go back to orders
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Order delivered successfully!"),
                                        backgroundColor: Color(0xFF026139),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: brandGreen,
                                  ),
                                  child: const Text("Confirm Delivery"),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle),
                        label: const Text("Confirm Delivery Received"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
        )
      )
    );
  }

  Widget _buildTrackingStep(String title, String description, IconData icon,
      Color color, bool isCompleted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted ? color : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isCompleted ? Colors.black87 : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
