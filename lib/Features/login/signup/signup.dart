import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:flutter_agrolync_pro/Core/utils/supabase_service.dart';
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)
import 'package:flutter_agrolync_pro/Features/Buyer/main.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/main_nav_wrapper.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/login.dart';
//import 'package:flutter_agrolync_pro/Features/Buyer/screens/home/home_screen.dart';
//import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/map_screen.dart';
//C:\flutter\flutter_agrolync_pro\lib\Features\Logistics\data\ui\screens\map_screen.dart
// C:\flutter\flutter_agrolync_pro\lib\Features\Buyer\screens\home\home_screen.dart

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkGreen = Color(0xFF014D2E);
  static const double globalHeight = 65.0;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedRole;
  bool agreeToTerms = false;
<<<<<<< HEAD
  final bool _isLoading = false;
=======
  bool _isLoading = false;
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 420.0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildHeader(headerHeight),
                Padding(
                  padding: const EdgeInsets.only(
                    top: headerHeight - 120,
                    left: 20,
                    right: 20,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Full Name"),
                        _buildStyledTextField(
                          hint: "Ange Awagoum",
                          controller: _fullNameController,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Email Address"),
                        _buildStyledTextField(
                          hint: "ange@gmail.com",
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Phone Number"),
                        _buildStyledTextField(
                          hint: "+237",
                          controller: _phoneController,
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Password"),
                        _buildStyledTextField(
                          hint: "••••••••",
                          controller: _passwordController,
                          isPassword: true,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "CHOOSE YOUR ROLE",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
<<<<<<< HEAD
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child:
                                    _roleCard("FARMER", Icons.eco, "Farmer")),
                            const SizedBox(width: 10),
                            Expanded(
                                child: _roleCard(
                                    "BUYER", Icons.shopping_cart, "Buyer")),
                            const SizedBox(width: 10),
                            Expanded(
                                child: _roleCard("LOGISTICS",
                                    Icons.local_shipping, "Logistics")),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildTermsCheckbox(),
                        const SizedBox(height: 30),
                        _buildCreateAccountButton(context),
                        const SizedBox(height: 25),
                        _buildDivider(),
                        const SizedBox(height: 25),
                        _buildGoogleButton(),
                      ],
=======
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel("Full Name"),
                          _buildStyledTextField(
                            hint: "Ange Awagoum",
                            controller: _fullNameController,
                          ),
                          const SizedBox(height: 20),
                          _buildLabel("Email Address"),
                          _buildStyledTextField(
                            hint: "ange@gmail.com",
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          _buildLabel("Phone Number"),
                          _buildStyledTextField(
                            hint: "+237",
                            controller: _phoneController,
                          ),
                          const SizedBox(height: 20),
                          _buildLabel("Password"),
                          _buildStyledTextField(
                            hint: "••••••••",
                            controller: _passwordController,
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "CHOOSE YOUR ROLE",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildRoleDropdownField(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  child:
                                      _roleCard("FARMER", Icons.eco, "Farmer")),
                              Expanded(
                                  child: _roleCard(
                                      "BUYER", Icons.shopping_cart, "Buyer")),
                              Expanded(
                                  child: _roleCard("LOGISTICS",
                                      Icons.local_shipping, "Logistics")),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildTermsCheckbox(),
                          const SizedBox(height: 30),
                          _buildCreateAccountButton(context),
                          const SizedBox(height: 25),
                          _buildDivider(),
                          const SizedBox(height: 25),
                          _buildGoogleButton(),
                        ],
                      ),
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildFooter(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildHeader(double height) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        color: brandGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Image.asset(AppImages.logo,
                    height: 160, fit: BoxFit.contain),
              ),
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Start Connecting Farmers & Sellers',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDropdownField() {
    return Container(
      height: globalHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedRole,
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(Icons.people_outline, color: brandGreen),
              SizedBox(width: 12),
              Text("Select your account type",
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            ],
          ),
          icon: const Icon(Icons.swap_vert, color: Colors.grey),
          items: ["Farmer", "Buyer", "Logistics"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: const TextStyle(color: Colors.black, fontSize: 16)),
            );
          }).toList(),
          onChanged: (val) => setState(() => selectedRole = val),
        ),
      ),
    );
  }

  Widget _roleCard(String label, IconData icon, String roleKey) {
    bool isSelected = selectedRole == roleKey;
    return GestureDetector(
      onTap: () => setState(() => selectedRole = roleKey),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF1F8F4) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? brandGreen : Colors.grey.shade200,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected ? brandGreen : Colors.black45, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? brandGreen : Colors.black45)),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: globalHeight,
      child: ElevatedButton(
        onPressed: _isLoading ? null : () => _handleSignUp(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: darkGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Create Account",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSignUp(BuildContext context) async {
<<<<<<< HEAD
    // Since the UI doesn't use controllers anymore, we'll just proceed with role-based navigation
    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please select your role (Farmer, Buyer, or Logistics)')),
=======
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields.')),
      );
      return;
    }

    if (selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select your role (Farmer, Buyer, or Logistics)')),
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)
      );
      return;
    }

    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
        const SnackBar(
            content: Text('Please agree to the Terms and Conditions')),
=======
        const SnackBar(content: Text('Please agree to the Terms and Conditions')), 
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)
      );
      return;
    }

<<<<<<< HEAD
    // TODO: Integrate authentication when available
    // For now, proceed with role-based navigation
    await Future.delayed(const Duration(seconds: 2)); // Simulate signup delay
=======
    setState(() {
      _isLoading = true;
    });

    final signup = await SupabaseService.signUpWithEmail(
      email: email,
      password: password,
    );

    if (signup.error != null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(signup.error!.message)),
      );
      return;
    }

    final userId = signup.user?.id;
    if (userId == null) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to create account. Please try again.')),
      );
      return;
    }

    final profile = await SupabaseService.createUserProfile(
      userId: userId,
      fullName: fullName,
      email: email,
      role: selectedRole!,
      phoneNumber: phone.isEmpty ? null : phone,
    );

    setState(() {
      _isLoading = false;
    });

    if (profile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created but profile save failed.')),
      );
      return;
    }
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)

    Widget destination;
    switch (selectedRole) {
      case 'Farmer':
        destination = const FarmerHomeScreen();
        break;
      case 'Buyer':
        destination = const MainNavigationWrapper();
        break;
      case 'Logistics':
        destination = const MainNavWrapper();
        break;
      default:
        destination = const FarmerHomeScreen();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  // --- REUSABLE WIDGETS ---
  Widget _buildStyledTextField({
    required String hint,
    required TextEditingController controller,
    bool isPassword = false,
    Widget? suffixIcon,
<<<<<<< HEAD
  }) =>
      Container(
=======
  }) => Container(
>>>>>>> 263150e (add row level security and superbase policies, connect to frontend and sumarise all work done so far)
        height: globalHeight,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2))
            ]),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.grey.shade300)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.grey.shade300)),
          ),
        ),
      );

  Widget _buildTermsCheckbox() => Row(
        children: [
          Checkbox(
              value: agreeToTerms,
              activeColor: brandGreen,
              shape: const CircleBorder(),
              onChanged: (val) => setState(() => agreeToTerms = val!)),
          const Expanded(
              child: Text("I agree to the Terms of Service and Privacy Policy",
                  style: TextStyle(fontSize: 11, color: Colors.black54))),
        ],
      );

  Widget _buildGoogleButton() => Container(
        height: globalHeight,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.grey.shade300)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(AppImages.logo6, height: 20),
          const SizedBox(width: 12),
          const Text("Sign up with Google")
        ]),
      );

  Widget _buildDivider() => Row(children: const [
        Expanded(child: Divider()),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:
                Text("OR", style: TextStyle(color: Colors.grey, fontSize: 12))),
        Expanded(child: Divider())
      ]);

  Widget _buildFooter(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Already have an account? "),
        GestureDetector(
            onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                ),
            child: const Text("Sign In",
                style:
                    TextStyle(color: brandGreen, fontWeight: FontWeight.bold)))
      ]);

  Widget _buildLabel(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)));
}
