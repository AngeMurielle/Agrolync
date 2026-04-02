import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'new_product.dart';

class Product2Page extends StatefulWidget {
  const Product2Page({super.key});

  @override
  State<Product2Page> createState() => _Product2PageState();
}

class _Product2PageState extends State<Product2Page> {
  final ImagePicker _picker = ImagePicker();

  static const Color brandGreen = Color(0xFF026139);
  // ignore: unused_field
  static const Color lightGreenSurface = Color(0xFFEFF7F2);
  static const Color darkBlueText = Color(0xFF1E293B);
  static const Color greyBodyText = Color(0xFF64748B);

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Image'),
        content: const Text('Choose image source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.camera);
            },
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _pickImage(ImageSource.gallery);
            },
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // For now, show a snackbar with the image path
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selected: ${image.path}')),
      );
      // TODO: Handle the image (upload to server, add to product images list, etc.)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(color: brandGreen, fontWeight: FontWeight.bold),
        ),
        // ✅ CHANGED: Removed the share icon here by setting actions to empty
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Hero Image Section ---
            Stack(
              children: [
                Image.asset(
                  'assets/images/onions.jpg', // Specific asset path
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: brandGreen.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.circle, color: Colors.greenAccent, size: 8),
                        SizedBox(width: 6),
                        Text(
                          "ACTIVE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // --- Translucent Profile Card (Overlaps Image) ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Transform.translate(
                offset: const Offset(0, -50),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vegetable / Bulbs",
                                style: TextStyle(
                                    color: greyBodyText,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Organic Red Onions",
                                style: TextStyle(
                                    color: darkBlueText,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AddNewProductPage()),
                              );
                            },
                            icon: const Icon(Icons.edit_outlined, size: 16),
                            label: const Text("Edit",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC0EAD8),
                              foregroundColor: brandGreen,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: brandGreen, size: 16),
                          SizedBox(width: 8),
                          Text(
                            "Maroua\nGreen Highlands Organic Farm",
                            style: TextStyle(
                                color: brandGreen, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            "Listed 10 days\nago",
                            style: TextStyle(color: greyBodyText, fontSize: 12),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Price/Stock Container ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Transform.translate(
                offset: const Offset(0, -30),
                child: Row(
                  children: [
                    Expanded(
                        child: _buildStatCard(Icons.payments_outlined,
                            "PRICE PER UNIT", "45.000 XAF", "/ Bag of 100kg")),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _buildStatCard(Icons.warehouse_outlined,
                            "STOCK AVAILABLE", "200", "Bags")),
                  ],
                ),
              ),
            ),

            // --- Description/Detail Grid ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PRODUCT DESCRIPTION",
                      style: TextStyle(
                          color: greyBodyText,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Premium Red Organic Onions.These are firm, deep-purple red onions grown using traditional organic methods in the cool, rich soils of the Santa highlands. They have a long shelf life and a sharp, spicy aroma perfect for your Tomato Stew, Kati-Kati, or fresh salads. We sun-dry every harvest to ensure they stay fresh in your kitchen without rotting. No chemical sprays—just pure, natural flavor from our soil to your table!",
                      style: TextStyle(
                          color: darkBlueText, fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),
                    // Detail Grid
                    Table(
                      children: [
                        TableRow(children: [
                          _buildGridItem("HARVEST DATE", "Jan 01, 2026"),
                          _buildGridItem("MOISTURE LEVEL", "6%"),
                        ]),
                        const TableRow(children: [
                          SizedBox(height: 16),
                          SizedBox(height: 16),
                        ]),
                        TableRow(children: [
                          _buildGridItem("CERTIFICATION",
                              "Organic (Cameroon Organic Standard)"),
                          _buildGridItem("STORAGE", "Climate Controlled"),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // --- Market Insight Banner ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: brandGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.trending_up, color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text(
                          "Market Insight",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Demand for Yellow Maize in your region is up by 12% this week. Consider adjusting your price for better visibility.",
                      style: TextStyle(
                          color: Colors.white70, fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),

            // --- Add More Images Dotted Footer ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: brandGreen,
                      width: 1.5,
                      style:
                          BorderStyle.solid), // Dotted requires a CustomPainter
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.add_photo_alternate_outlined,
                        color: brandGreen, size: 40),
                    const SizedBox(height: 16),
                    const Text(
                      "Add more quality images",
                      style: TextStyle(
                          color: brandGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Boost trust with buyers by showing storage conditions",
                      style: TextStyle(color: greyBodyText, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _showImageSourceDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandGreen,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Add Image'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Price/Stock cards
  Widget _buildStatCard(
      IconData icon, String label, String value, String unit) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: brandGreen, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      color: greyBodyText,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              children: [
                TextSpan(
                    text: value, style: const TextStyle(color: brandGreen)),
                TextSpan(
                    text: " $unit",
                    style: const TextStyle(color: darkBlueText, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for the Details grid items
  Widget _buildGridItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: greyBodyText, fontSize: 11, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
              color: darkBlueText, fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
