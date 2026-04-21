import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../drawer.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  // Logic: Variable to hold the dynamically picked image file
  File? _uploadedImage;
  final ImagePicker _picker = ImagePicker();

  // Branding Colors
  static const Color brandGreen = Color(0xFF026139);
  static const Color lightGreenAccent = Color(0xFF99CC33);
  static const Color fieldBorderColor = Color(0xFFE0E0E0);
  static const Color fieldIconColor = Color(0xFF9E9E9E);
  static const Color textColor = Color(0xFF424242);

  // Controllers for text fields (Retaining original data for display)
  final _nameController = TextEditingController(text: "Ange Awagoum");
  final _phoneController = TextEditingController(text: "+237 682 123 456");
  final _emailController =
      TextEditingController(text: "ange.angemurielle@gmail.com");

  // Logic: Dynamic method to handle image selection via BottomSheet
  Future<void> _pickImage() async {
    final BuildContext currentContext = context;
    showModalBottomSheet(
        context: currentContext,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        builder: (context) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                    leading: const Icon(Icons.photo_library, color: brandGreen),
                    title: const Text('Upload from Gallery'),
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null && mounted) {
                        setState(() => _uploadedImage = File(image.path));
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(currentContext).pop();
                    }),
                ListTile(
                    leading: const Icon(Icons.photo_camera, color: brandGreen),
                    title: const Text('Take a Photo'),
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.camera);
                      if (image != null && mounted) {
                        setState(() => _uploadedImage = File(image.path));
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(currentContext).pop();
                    }),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Standardized Button dimensions (Matching your Sign In/Sign Up buttons)
    const double standardButtonHeight = 65.0;
    const double standardButtonWidthRatio = 0.90; // 90% of screen width

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerPage(initialSelectedItem: 'Profile'),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Personal Information',
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 22)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // --- Interactive Avatar Stack ---
            Stack(
              children: [
                // Display dynamic file image if available, else show default asset image
                CircleAvatar(
                  radius: 75,
                  backgroundColor: lightGreenAccent.withValues(alpha: 0.1),
                  child: ClipOval(
                    child: _uploadedImage != null
                        ? Image.file(_uploadedImage!,
                            fit: BoxFit.cover, width: 150, height: 150)
                        // Requirement: Default image is the local asset for ange
                        : Image.asset('assets/images/ange1.jpeg',
                            fit: BoxFit.cover),
                  ),
                ),
                // --- Tap-to-Upload Camera Badge ---
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: _pickImage, // Connect to the picker logic
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2))
                        ],
                        border: Border.all(color: lightGreenAccent, width: 2),
                      ),
                      child: const Icon(Icons.photo_camera_rounded,
                          color: brandGreen, size: 24),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text("ANGE AWAGOUM",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: textColor)),
            const Text("AGROLYNC MEMBER",
                style: TextStyle(
                    color: brandGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.5)),
            const SizedBox(height: 35),

            // --- Multi-Step Information Form ---
            _buildStyledTextField(
                label: "Full Name",
                controller: _nameController,
                icon: Icons.person),
            const SizedBox(height: 20),
            _buildStyledTextField(
                label: "Phone Number",
                controller: _phoneController,
                icon: Icons.phone),
            const SizedBox(height: 20),
            _buildStyledTextField(
                label: "Email",
                controller: _emailController,
                icon: Icons.email),
          ],
        ),
      ),

      // --- Standardized Update Profile Button ---
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: standardButtonHeight, // Force exact height symmetry
                width: MediaQuery.of(context).size.width *
                    standardButtonWidthRatio, // Standardized width
                child: ElevatedButton(
                  onPressed: () {
                    // Save changes logic
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Profile details updated")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check_circle_outline_rounded,
                          size: 22, color: Colors.white70),
                      SizedBox(width: 10),
                      Text("Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Original Security disclaimer remains
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for consistent input fields
  Widget _buildStyledTextField(
      {required String label,
      required TextEditingController controller,
      required IconData icon}) {
    // Logic: Standardize height with button height variable (if desired) or use fixed height
    const double standardFieldHeight = 60.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
        const SizedBox(height: 8),
        Container(
          height: standardFieldHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: fieldBorderColor),
          ),
          child: Row(
            children: [
              Icon(icon, color: fieldIconColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 16, color: textColor),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
