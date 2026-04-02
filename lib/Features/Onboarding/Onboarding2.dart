import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Onboarding/Onboarding3.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

//import 'package:flutter_agrolync_pro/Features/Farmer/Home.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

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
            // Header (Skip Button)
            _buildHeader(context),

            // Main Content Area (Centralized)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIllustration(),
                    const SizedBox(height: 30), // Consistent 30px gap
                    _buildTextContent(),
                  ],
                ),
              ),
            ),

            // Footer (Dots and Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildFooter(context),
            ),
            const SizedBox(height: 30), // Consistent bottom padding
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
    // REDUCED SIZE: 180x180 to match previous screens
    return Image.asset(
      AppImages.logo4,
      height: 150,
      width: 150,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: const [
        Text(
          'Real-Time Price',
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
          'Get instant market prices and\nmake informed decisions',
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
        // Indicators: Active dot is now at index 2 (third position)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(),
            const SizedBox(width: 6),
            _buildDot(),
            const SizedBox(width: 6),
            Container(
              width: 70, // Consistent 70px width
              height: 8,
              decoration: BoxDecoration(
                color: brandGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 6),
            _buildDot(),
          ],
        ),
        const SizedBox(height: 32),
        // Primary Action Button
        SizedBox(
          width: double.infinity,
          height: 65.0, // Consistent 65.0px height
          child: ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen3(),
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
