import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/widgets/shared/logistics_bottom_nav.dart';

class VehicleInfoPage extends StatelessWidget {
  const VehicleInfoPage({super.key});

  final Color primaryGreen = const Color(0xFF015E38);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Subtle light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Vehicle Details",
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Vehicle Card
            _buildVehicleHeroCard(),
            const SizedBox(height: 25),

            // 2. Technical Specifications Section
            _buildSectionLabel("TECHNICAL SPECIFICATIONS"),
            const SizedBox(height: 12),
            _buildInfoCard([
              _infoRow(Icons.straighten, "Truck Model", "Mercedes-Benz Actros"),
              _divider(),
              _infoRow(Icons.pin_drop, "License Plate", "LT 123 AA"),
              _divider(),
              _infoRow(Icons.shutter_speed, "Capacity", "20 Tons"),
            ]),

            const SizedBox(height: 25),

            // 3. Operational Details Section
            _buildSectionLabel("OPERATIONAL DETAILS"),
            const SizedBox(height: 12),
            _buildInfoCard([
              _infoRow(Icons.calendar_today, "Last Maintenance", "12 Oct 2025"),
              _divider(),
              _infoRow(Icons.verified_user, "Insurance Status",
                  "Valid until Dec 2026"),
            ]),

            const SizedBox(height: 35),

            // 4. Update Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                child: const Text(
                  "Update Vehicle Info",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: LogisticsBottomNavBar(
        selectedIndex: 3,
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

  Widget _buildVehicleHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: primaryGreen.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.local_shipping, color: Colors.white, size: 50),
          ),
          const SizedBox(height: 15),
          const Text(
            "Mercedes-Benz Actros",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "ACTIVE",
              style: TextStyle(
                  color: primaryGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 22),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.edit_outlined, color: Colors.grey, size: 18),
        ],
      ),
    );
  }

  Widget _divider() =>
      Divider(height: 1, color: Colors.grey.shade100, indent: 50);
}
