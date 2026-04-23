import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_agrolync_pro/Features/Farmer/Market.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/drawer.dart';
// Ensure you import your MarketPage file here
// import 'package:your_app/market_page.dart';

class AddNewProductPage extends StatefulWidget {
  final Map<String, String>? editData;
  const AddNewProductPage({super.key, this.editData});

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final Color brandGreen = const Color(0xFF026139);
  String? selectedCrop;
  String? selectedUnit;
  XFile? _pickedFile;
  final ImagePicker _picker = ImagePicker();
  final List<String> crops = [
    'Grains',
    'Vegetables',
    'Fruits',
    'Tubers',
    'Seeds',
    'Fertilizers',
    'Tools',
    'Pesticides',
    'Others',
  ];
  final List<String> units = [
    'KG',
    'Bag',
    'Bag of 100kg',
    'Bag of 50kg',
    'Liter',
    'bucket 15 L',
    'Big Basket',
    'Small Basket',
    'Piece',
    'Bunch'
  ];

  Future<void> _pickImage() async {
    final XFile? result = await _picker.pickImage(source: ImageSource.gallery);
    if (result != null) setState(() => _pickedFile = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerPage(initialSelectedItem: 'Marketplace'),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            widget.editData != null ? "Edit Product" : "Add New Product",
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildDashedPhotoUpload(),
            const SizedBox(height: 25),
            const Text("Product Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),

            _buildLabel("Product Name"),
            _buildTextField("e.g. Fresh Red Onions"),
            const SizedBox(height: 20),

            _buildLabel("Product Type"),
            _buildDropdown(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Quantity"),
                          _buildTextField("0.00", isNumber: true)
                        ])),
                const SizedBox(width: 15),
                Expanded(
                    flex: 1,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildLabel("Unit"), _buildUnitDropdown()])),
              ],
            ),
            const SizedBox(height: 25),
            const Text("Pricing",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),
            _buildLabel("Price per XAF"),
            _buildTextField("0.00 XAF", isNumber: true),
            const SizedBox(height: 25),
            _buildLabel("Description (Optional)"),
            _buildTextField("Tell buyers more about your product...",
                maxLines: 3),
            const SizedBox(height: 30),

            // --- UPDATED PUBLISH BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Direct Routing to MarketPage and clearing navigation history
                  // Replace 'MarketPage()' with your actual Market widget class name
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MarketPage()),
                    (route) => false,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Listing Published Successfully!"),
                      backgroundColor: Color(0xFF026139),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                ),
                child: const Text("Publish Product",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // UI Helper methods (Photo Upload, Labels, TextFields, Dropdown) remain the same as your previous version...
  Widget _buildDashedPhotoUpload() {
    return CustomPaint(
      painter: DashedRectPainter(color: Colors.grey.shade400),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: _pickedFile != null
              ? Stack(
                  children: [
                    Positioned.fill(
                      child: kIsWeb
                          ? Image.network(_pickedFile!.path, fit: BoxFit.cover)
                          : Image.file(File(_pickedFile!.path),
                              fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () => setState(() => _pickedFile = null),
                        child: const CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 15,
                            child: Icon(Icons.close,
                                size: 18, color: Colors.black)),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey.shade100,
                        child: Icon(Icons.add_a_photo_outlined,
                            size: 35, color: brandGreen)),
                    const SizedBox(height: 15),
                    const Text("Upload Crop Photos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    const Text("High-quality photos help you sell faster",
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 15),
                    ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: brandGreen,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text("Add Photo",
                            style: TextStyle(color: Colors.white))),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: TextStyle(
              color: Colors.grey.shade800,
              fontSize: 14,
              fontWeight: FontWeight.w500)));

  Widget _buildTextField(String hint,
          {bool isNumber = false, int maxLines = 1}) =>
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: TextField(
          maxLines: maxLines,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200)),
              contentPadding: const EdgeInsets.all(15)),
        ),
      );

  Widget _buildDropdown() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: brandGreen,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedCrop,
            hint: const Text("Select Product Type",
                style: TextStyle(color: Colors.white)),
            dropdownColor: brandGreen,
            style: const TextStyle(color: Colors.white),
            isExpanded: true,
            items: crops
                .map((v) => DropdownMenuItem(
                    value: v,
                    child: Text(v, style: TextStyle(color: Colors.white))))
                .toList(),
            onChanged: (v) => setState(() => selectedCrop = v),
          ),
        ),
      );

  // ignore: unused_element
  Widget _buildUnitDropdown() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4))
            ]),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedUnit,
            hint: const Text("Unit"),
            isExpanded: true,
            items: units
                .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                .toList(),
            onChanged: (v) => setState(() => selectedUnit = v),
          ),
        ),
      );
}

// RESTORED PAINTER
class DashedRectPainter extends CustomPainter {
  final Color color;
  DashedRectPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(20)));
    for (PathMetric metric in path.computeMetrics()) {
      double dist = 0.0;
      while (dist < metric.length) {
        canvas.drawPath(metric.extractPath(dist, dist + 5), paint);
        dist += 10;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
