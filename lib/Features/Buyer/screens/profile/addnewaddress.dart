//import 'package:flutter/material.dart';

//class AddNewAddressPage extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({super.key});

  @override
  State<AddNewAddressPage> createState() => _MapAddressPickerState();
}

class _MapAddressPickerState extends State<AddNewAddressPage> {
  static const Color brandGreen = Color(0xFF015E38);

  // Starting position (Buea, Cameroon)
  LatLng _currentPosition = const LatLng(4.1560, 9.2435);
  String _addressPreview = "Fetching address...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. THE FULL SCREEN MAP
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: _currentPosition, zoom: 16),
            onMapCreated: (controller) {},
            onCameraMove: (position) {
              setState(() => _currentPosition = position.target);
            },
            onCameraIdle: () {
              // Here you would normally call a Reverse Geocoding API
              // to turn coordinates into a street name
              setState(() => _addressPreview = "Molyko, near Jongo Hub");
            },
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // 2. THE CUSTOM CENTER PIN (Stays fixed while map moves)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40), // Adjust for pin tip
              child: Icon(Icons.location_on, color: brandGreen, size: 45),
            ),
          ),

          // 3. FLOATING TOP BAR (Back & Search)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: brandGreen),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey, size: 20),
                        SizedBox(width: 10),
                        Text("Search for area...",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 4. BOTTOM CONFIRMATION CARD
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: brandGreen),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("DELIVERY LOCATION",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            Text(_addressPreview,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // Return the picked location to the previous screen
                        Navigator.pop(context, _currentPosition);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text("CONFIRM LOCATION",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
