import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_agrolync_pro/Core/Constants/colors.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';
import 'package:google_maps_webservice/places.dart' hide TravelMode;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapScreen extends StatefulWidget {
  final LatLng? pickupLocation;
  final LatLng? dropoffLocation;
  final String? pickupName;
  final String? dropoffName;

  const MapScreen({
    super.key,
    this.pickupLocation,
    this.dropoffLocation,
    this.pickupName,
    this.dropoffName,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;

  final kGoogleApiKey = "AIzaSyBF1MKDfD7gMuWFki1FvmzXPcnvfDbWaWc";
  late GoogleMapsPlaces _places;

  final LatLng _douala = const LatLng(4.0511, 9.7679);
  final LatLng _yaounde = const LatLng(3.8480, 11.5021);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    _addDefaultMarkers();
    _getPolyline(); // Fetch the route on load
  }

  LatLng get _pickup => widget.pickupLocation ?? _douala;
  LatLng get _dropoff => widget.dropoffLocation ?? _yaounde;

  void _addDefaultMarkers() {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId("pickup"),
          position: _pickup,
          infoWindow:
              InfoWindow(title: "Pickup: ${widget.pickupName ?? 'Bonabéri'}"),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
      _markers.add(
        Marker(
          markerId: const MarkerId("dropoff"),
          position: _dropoff,
          infoWindow: InfoWindow(
              title: "Drop-off: ${widget.dropoffName ?? 'Mvan Market'}"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    });
  }

  // UPDATED: Compatibility for flutter_polyline_points ^1.0.0
  Future<void> _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      kGoogleApiKey, // No parameter label for API Key in v1.0.0
      PointLatLng(_pickup.latitude, _pickup.longitude),
      PointLatLng(_dropoff.latitude, _dropoff.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear(); // Ensure list is clean
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId("route"),
          color: AppColors.primaryGreen,
          points: polylineCoordinates,
          width: 5,
        ),
      );
    });
  }

  Future<void> _handleSearchAction() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay,
      language: "fr",
      components: [Component(Component.country, "cm")],
      logo: const SizedBox.shrink(),
    );

    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;
      var target = LatLng(lat, lng);

      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: target, zoom: 14.0)),
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(p.placeId!),
            position: target,
            infoWindow: InfoWindow(title: p.description),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _douala, zoom: 7.5),
            onMapCreated: (controller) => _mapController = controller,
            markers: _markers,
            polylines: _polylines, // Renders the green route line
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              children: [
                _buildCircularButton(
                  icon: Icons.arrow_back_ios_new,
                  onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) =>
                          const MainNavWrapper(initialIndex: 0),
                    ),
                    (route) => false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _handleSearchAction,
                    child: Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text("Search Cameroon markets...",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomDetails(),
          ),
        ],
      ),
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: 1,
        onTap: (index) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainNavWrapper(initialIndex: index),
            ),
            (route) => false,
          );
        },
      ),
    );
  }

  Widget _buildCircularButton(
      {required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: Icon(icon, size: 20, color: Colors.black),
      ),
    );
  }

  Widget _buildBottomDetails() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.52,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
      ),
      child: Column(
        children: [
          Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.pickupName ?? 'Douala'} → ${widget.dropoffName ?? 'Yaoundé'}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text("175.500 XAF",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text("Pickup: Today • 06:30 AM",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 20),
                  GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: const [
                      _DetailCard(Icons.inventory_2_outlined, "COMMODITY",
                          "Cocoa Beans"),
                      _DetailCard(
                          Icons.monitor_weight_outlined, "WEIGHT", "5.0 Tons"),
                      _DetailCard(Icons.route_outlined, "DISTANCE", "240 km"),
                      _DetailCard(
                          Icons.local_shipping_outlined, "TRUCK", "10-Wheeler"),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(thickness: 1, color: Color(0xFFEEEEEE))),
                  const _RouteRow(
                      isFirst: true,
                      location: "Bonabéri Industrial Zone",
                      city: "Douala, Littoral"),
                  const _RouteRow(
                      isFirst: false,
                      location: "Mvan Tropical Market",
                      city: "Yaoundé, Centre"),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    child: const Text("Accept Delivery Job",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _DetailCard(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 8,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                Text(value,
                    style: const TextStyle(
                        fontSize: 11, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  final bool isFirst;
  final String location, city;
  const _RouteRow(
      {required this.isFirst, required this.location, required this.city});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(isFirst ? Icons.circle : Icons.location_on,
                color: isFirst ? AppColors.primaryGreen : Colors.orange,
                size: 18),
            if (isFirst)
              Container(width: 2, height: 30, color: Colors.grey[200]),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(location,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(city,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
