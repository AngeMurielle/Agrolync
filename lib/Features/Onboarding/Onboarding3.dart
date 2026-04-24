import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Core/Utilities/responsive_utils.dart';
//import 'package:flutter_agrolync_pro/Core/Utilities/responsive_utils.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
import 'package:flutter_agrolync_pro/Features/login/signup/signup.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  // --- Design System Constants ---
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
                    _buildIllustration(context),
                    SizedBox(
                        height: context.responsiveGap *
                            0.6), // FIXED: Responsive gap
                    _buildTextContent(),
                  ],
                ),
              ),
            ),

            // Footer (Dots and Final Button)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.responsiveGap * 0.8),
              child: _buildFooter(context),
            ),
            const SizedBox(height: 30),
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

  Widget _buildIllustration(BuildContext context) {
    // FIXED: Responsive image height across all onboarding screens
    return Image.asset(
      AppImages.logo3,
      height: context.responsiveImageHeight,
      width: context.responsiveImageHeight * 0.95,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: const [
        Text(
          'Easy Logistics',
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
          'Integrated payments and reliable\ntracking for every shipment.',
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
        // Indicators: Active dot is now at index 3 (fourth position)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(),
            const SizedBox(width: 6),
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
          ],
        ),
        const SizedBox(height: 32),
        // Final Action Button: "Get Started"
        SizedBox(
          width: double.infinity,
          height: context.responsiveButtonHeight,
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: brandGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot() => Container(
        width: 8,
        height: 8,
        decoration:
            const BoxDecoration(color: inactiveDot, shape: BoxShape.circle),
      );
}
