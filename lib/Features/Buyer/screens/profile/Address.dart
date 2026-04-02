import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'addnewaddress.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  static const Color brandGreen = Color(0xFF015E38);
  static const Color subTextColor = Color(0xFF64748B);

  // Mock data with LatLng coordinates
  final List<Map<String, dynamic>> _addresses = [
    {
      "type": "Home",
      "address": "123 Green Valley, Molyko, Buea",
      "isDefault": true,
      "coords":
          const LatLng(4.1560, 9.2435), // Coordinates from your Farm Details
      "icon": Icons.home_rounded
    },
    {
      "type": "Work",
      "address": "Jongo Hub, Opposite UB, Buea",
      "isDefault": false,
      "coords": const LatLng(4.1511, 9.2714),
      "icon": Icons.work_rounded
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios_new, color: brandGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Delivery Addresses",
          style: TextStyle(
              color: brandGreen, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          return _buildAddressCard(_addresses[index], index);
        },
      ),
      bottomNavigationBar: _buildAddButton(),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          // 🗺️ MINI MAP PREVIEW
          SizedBox(
            height: 120,
            width: double.infinity,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              child: IgnorePointer(
                // Makes the map non-interactive inside the card
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: item['coords'], zoom: 15),
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                        markerId: MarkerId("addr_$index"),
                        position: item['coords']),
                  },
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(item['icon'],
                        color: item['isDefault'] ? brandGreen : subTextColor,
                        size: 22),
                    const SizedBox(width: 12),
                    Text(item['type'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const Spacer(),
                    if (item['isDefault']) _buildBadge("DEFAULT", brandGreen),
                  ],
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item['address'],
                    style: const TextStyle(color: subTextColor, fontSize: 13),
                  ),
                ),
                const Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildActionButton(
                        Icons.edit_outlined, "Edit", brandGreen, () {}),
                    const SizedBox(width: 15),
                    _buildActionButton(
                        Icons.delete_outline, "Delete", Colors.redAccent, () {
                      setState(() => _addresses.removeAt(index));
                    }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 55,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddNewAddressPage()),
            );
          },
          icon: const Icon(Icons.add_location_alt_rounded, color: Colors.white),
          label: const Text("ADD NEW ADDRESS",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: brandGreen,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
