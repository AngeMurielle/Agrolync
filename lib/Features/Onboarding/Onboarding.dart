import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Onboarding/Onboarding1.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
//import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  // Saved Branding & UI Constants
  static const Color brandGreen = Color(0xFF026139);
  static const Color inactiveDot = Color(0xFFD9D9D9);
  static const Color textMain = Color(0xFF000000);
  static const Color textSub = Color(0xFF4F4F4F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // FIXED: Skip button positioned at top right
            _buildHeader(context),

            // FIXED: Main content area uses Expanded to push footer down
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIllustration(),
                    const SizedBox(height: 30), // Saved Gap
                    _buildTextContent(),
                  ],
                ),
              ),
            ),

            // FIXED: Footer and Elevated Button at the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildFooter(context),
            ),
            const SizedBox(height: 30), // Saved Bottom Safe-Area Padding
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: textSub,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    // SAVED SIZE: 180x180 for logo
    return Image.asset(
      AppImages.logo5,
      height: 180,
      width: 180,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: const [
        Text(
          'Welcome to Agrolync',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textMain,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Your all-in-one digital marketplace\ndesigned to revolutionize how\nyou trade and grow.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: textSub, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // SAVED WIDTH: Long active indicator (70px)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 8,
              decoration: BoxDecoration(
                color: brandGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 6),
            _buildDot(),
            const SizedBox(width: 6),
            _buildDot(),
            const SizedBox(width: 6),
            _buildDot(),
          ],
        ),
        const SizedBox(height: 32),
        // SAVED HEIGHT: Primary Button (56px)
        SizedBox(
          width: double.infinity,
          height: 65.0,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen1(),
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: brandGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_forward, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot() => Container(
    width: 8,
    height: 8,
    decoration: const BoxDecoration(color: inactiveDot, shape: BoxShape.circle),
  );
}
