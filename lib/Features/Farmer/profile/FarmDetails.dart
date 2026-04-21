import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Line 2
import '../drawer.dart';

class FarmDetailsPage extends StatefulWidget {
  const FarmDetailsPage({super.key});

  @override
  State<FarmDetailsPage> createState() => _FarmDetailsScreenState();
}

class _FarmDetailsScreenState extends State<FarmDetailsPage> {
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkTextColor = Color(0xFF1E293B);
  static const Color subTextColor = Color(0xFF64748B);
  static const Color fieldBorderColor = Color(0xFFE2E8F0);

  // Use a nullable controller to avoid 'late initialization' errors (Line 19)
  // ignore: unused_field
  GoogleMapController? _mapController;

  // Line 21
  LatLng _pickedLocation = const LatLng(4.1560, 9.2435);

  final _farmNameController = TextEditingController(text: "Angie Farm");
  final _locationController =
      TextEditingController(text: "Behind Muea Market, Buea, Cameroon");
  final _sizeController = TextEditingController(text: "120.5");
  String _selectedCrop = "Corn & Soybeans";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerPage(initialSelectedItem: 'Profile'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkTextColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Farm Details',
            style: TextStyle(
                color: darkTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("General Information",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkTextColor)),
            const SizedBox(height: 4),
            const Text("Update your farm profile and location settings.",
                style: TextStyle(fontSize: 14, color: subTextColor)),
            const SizedBox(height: 25),

            _buildLabel("Farm Name"),
            _buildTextField(controller: _farmNameController),
            const SizedBox(height: 20),

            _buildLabel("Farm Location"),
            _buildLocationInput(),
            const SizedBox(height: 12),

            _buildInteractiveMap(), // The Map widget

            const SizedBox(height: 20),
            _buildLabel("Primary Crop Types"),
            _buildDropdown(),
            const SizedBox(height: 20),

            _buildLabel("Farm Size (in Kilometers)"),
            _buildTextField(controller: _sizeController, suffixText: "Km"),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildSaveButton(),
    );
  }

  Widget _buildInteractiveMap() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: fieldBorderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _pickedLocation, zoom: 14.0),
              onMapCreated: (controller) => _mapController = controller,
              mapType: MapType.hybrid,
              markers: {
                Marker(
                  markerId: const MarkerId("farm_loc"),
                  position: _pickedLocation,
                  draggable: true,
                  onDragEnd: (pos) => setState(() => _pickedLocation = pos),
                ),
              },
            ),
            // Fix for Lines 108/109: Correct const placement
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4)
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.crop_free, size: 16, color: darkTextColor),
                    SizedBox(width: 6),
                    Text("Adjust Pin",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods ---
  Widget _buildLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: subTextColor,
                fontSize: 14)),
      );

  Widget _buildTextField(
      {required TextEditingController controller, String? suffixText}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: fieldBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(border: InputBorder.none))),
          if (suffixText != null)
            Text(suffixText,
                style: const TextStyle(
                    color: subTextColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLocationInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: fieldBorderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(border: InputBorder.none)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Icons.map_outlined, color: brandGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: fieldBorderColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedCrop,
          isExpanded: true,
          items: [
            "Corn & Soybeans",
            "Wheat",
            "Coffee",
            "Tomatoes",
            "Pepper",
            "Onions",
            "Cabbage"
          ].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: (v) => setState(() => _selectedCrop = v!),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Saved!"))),
          style: ElevatedButton.styleFrom(
              backgroundColor: brandGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: const Text("Save Changes",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
