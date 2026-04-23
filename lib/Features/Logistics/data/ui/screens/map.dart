import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Required for kIsWeb
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:flutter_agrolync_pro/Features/Farmer/order/chat_page.dart';
import 'package:flutter_agrolync_pro/Features/Buyer/main.dart' as buyer_main;
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';
import 'complete.dart';

class LogisticsMapScreen extends StatefulWidget {
  final LatLng? pickupLocation;
  final LatLng? dropoffLocation;
  final String? pickupAddress;
  final String? dropoffAddress;
  final Map<String, dynamic>? jobData;
  final bool fromBuyer;

  const LogisticsMapScreen({
    super.key,
    this.pickupLocation,
    this.dropoffLocation,
    this.pickupAddress,
    this.dropoffAddress,
    this.jobData,
    this.fromBuyer = false,
  });

  @override
  State<LogisticsMapScreen> createState() => _LogisticsMapScreenState();
}

class _LogisticsMapScreenState extends State<LogisticsMapScreen> {
  late GoogleMapController _mapController;
  final Location _location = Location();
  final ImagePicker _picker = ImagePicker();

  // FIX: Use XFile instead of File to support Web paths
  XFile? _proofFile;

  final String kGoogleApiKey = "AIzaSyBF1MKDfD7gMuWFki1FvmzXPcnvfDbWaWc";
  final String contactNumber = "+237682087287";

  // Use dynamic coordinates based on job data or defaults
  late final LatLng _pickupLocation;
  late final LatLng _dropoffLocation;
  late final String _pickupAddress;
  late final String _dropoffAddress;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    // Initialize locations from widget parameters or use defaults
    _pickupLocation =
        widget.pickupLocation ?? const LatLng(4.0511, 9.7679); // Douala default
    _dropoffLocation = widget.dropoffLocation ??
        const LatLng(3.8480, 11.5021); // Yaounde default
    _pickupAddress = widget.pickupAddress ?? "Douala";
    _dropoffAddress = widget.dropoffAddress ?? "Yaoundé";

    _addDefaultMarkers();
    _getPolyline();
    _initLocationTracking();
  }

  // --- Functional: Communication ---
  Future<void> _makeCall() async {
    final Uri url = Uri.parse("tel:$contactNumber");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _openChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatPage(
          isBuyer: false, // Assuming logistics is for farmers/drivers
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    final Widget destination = widget.fromBuyer
        ? const buyer_main.MainNavigationWrapper()
        : MainNavWrapper(initialIndex: index);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => destination),
      (route) => false,
    );
  }

  // --- Logic: Proof of Delivery (Cross-Platform) ---
  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1200, // Optimization for upload
    );
    if (photo != null) {
      setState(() {
        _proofFile = photo;
      });
    }
  }

  // --- Logic: Routing ---
  Future<void> _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey,
      PointLatLng(_pickupLocation.latitude, _pickupLocation.longitude),
      PointLatLng(_dropoffLocation.latitude, _dropoffLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      _calculateRouteDistance();
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: const Color(0xFF015E38), // AgroLync Green
          points: polylineCoordinates,
          width: 6,
        ),
      );
    });
  }

  Future<void> _initLocationTracking() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        LatLng pos =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
        setState(() {
          _markers.add(
            Marker(
              markerId: const MarkerId("current_driver"),
              position: pos,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
            ),
          );
        });
      }
    });
  }

  void _addDefaultMarkers() {
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId("pickup"),
        position: _pickupLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(title: "Pickup: $_pickupAddress"),
      ));
      _markers.add(Marker(
        markerId: const MarkerId("dropoff"),
        position: _dropoffLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(title: "Dropoff: $_dropoffAddress"),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _pickupLocation, zoom: 10),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (widget.fromBuyer) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            const buyer_main.MainNavigationWrapper(),
                      ),
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                            const MainNavWrapper(initialIndex: 0),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
          ),
          _buildDraggableSheet(),
        ],
      ),
      bottomNavigationBar:
          LogisticsBottomNavBar(selectedIndex: 0, onTap: _onBottomNavTap),
    );
  }

  Widget _buildDraggableSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                  child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 25),
              const Text("PROOF OF DELIVERY",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _takePhoto,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey[300]!, width: 1),
                  ),
                  child: _proofFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.camera_alt_outlined,
                                color: Color(0xFF015E38), size: 40),
                            SizedBox(height: 8),
                            Text("Tap to capture cargo photo",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: kIsWeb
                              ? Image.network(_proofFile!.path,
                                  fit: BoxFit.cover)
                              : Image.file(File(_proofFile!.path),
                                  fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 25),
              _buildStep(
                  Icons.radio_button_unchecked, "PICKUP", "Bonabéri, Douala"),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                    height: 20,
                    child: VerticalDivider(
                        thickness: 1, color: Color(0xFFEEEEEE))),
              ),
              _buildStep(Icons.location_on, "DROP-OFF", "Mvan Market, Yaoundé"),
              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                      child: _buildActionBtn(Icons.phone, "Call",
                          Colors.grey[100]!, Colors.black, _makeCall)),
                  const SizedBox(width: 15),
                  Expanded(
                      child: _buildActionBtn(Icons.message, "Chat",
                          const Color(0xFF015E38), Colors.white, _openChat)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _proofFile == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeliveryCompleteScreen(
                                orderId:
                                    widget.jobData?['title'] ?? "AGL-237-99",
                                earnings:
                                    widget.jobData?['price'] ?? "15,000 XAF",
                                jobData: widget.jobData,
                              ),
                            ),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF015E38),
                    disabledBackgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                      _proofFile == null
                          ? "Capture Proof First"
                          : "Complete Delivery",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _calculateRouteDistance() {
    double totalDistance = 0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += _coordinateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    // You can use totalDistance here if needed for display
  }

  double _coordinateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    double p = 0.017453292519943295;
    final c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget _buildStep(IconData icon, String label, String location) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF015E38)),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            Text(location,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        )
      ],
    );
  }

  Widget _buildActionBtn(
      IconData icon, String label, Color bg, Color text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 55,
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: text, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: TextStyle(color: text, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
