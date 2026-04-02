
import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;

  // Controllers with default values
  final TextEditingController _nameController = TextEditingController(text: "Awagoum Murielle");
  final TextEditingController _emailController = TextEditingController(text: "murielle@agrolync.com");
  final TextEditingController _phoneController = TextEditingController(text: "+237 682 087 287");

  // Function to simulate a database save
  Future<void> _handleSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isSaving = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Profile updated successfully!"),
            backgroundColor: const Color(0xFF015E38),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF015E38);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryGreen, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Personal Details",
          style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ℹ️ Header Text
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contact Information",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryGreen),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Keep your details up to date to receive order updates and stay connected with AgroLync logistics.",
                style: TextStyle(color: Colors.grey, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 35),

              // 🖋️ Input Fields inside a clean container
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInputField(
                      label: "FULL NAME",
                      controller: _nameController,
                      icon: Icons.person_outline_rounded,
                      hint: "Enter your full name",
                    ),
                    const Divider(height: 30, thickness: 0.5),
                    _buildInputField(
                      label: "EMAIL ADDRESS",
                      controller: _emailController,
                      icon: Icons.alternate_email_rounded,
                      hint: "example@mail.com",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || !value.contains('@')) return "Enter a valid email";
                        return null;
                      },
                    ),
                    const Divider(height: 30, thickness: 0.5),
                    _buildInputField(
                      label: "PHONE NUMBER",
                      controller: _phoneController,
                      icon: Icons.phone_iphone_rounded,
                      hint: "+237 ...",
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // 🟢 DYNAMIC SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    disabledBackgroundColor: primaryGreen.withOpacity(0.6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 4,
                    shadowColor: primaryGreen.withOpacity(0.3),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text(
                          "SAVE CHANGES",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    const Color primaryGreen = Color(0xFF015E38);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.1),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.normal),
            prefixIcon: Icon(icon, color: primaryGreen, size: 22),
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            border: InputBorder.none,
            errorStyle: const TextStyle(fontSize: 10),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
          validator: validator ?? (value) {
            if (value == null || value.isEmpty) return "Field required";
            return null;
          },
        ),
      ],
    );
  }
}