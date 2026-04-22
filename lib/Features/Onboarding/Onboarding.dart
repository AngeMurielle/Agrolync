import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Core/Utilities/responsive_utils.dart';
//import 'package:flutter_agrolync_pro/Core/Utilities/responsive_utils.dart';
import 'package:flutter_agrolync_pro/Features/Onboarding/Onboarding1.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';
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
                    _buildIllustration(context),
                    SizedBox(
                        height: context.responsiveGap *
                            0.6), // FIXED: Responsive gap
                    _buildTextContent(),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.responsiveGap * 0.8),
              child: _buildFooter(context),
            ),
            SizedBox(
                height: context.bottomNavPadding *
                    0.5), // Extra safe bottom padding
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
    // FIXED: Responsive image height - prevents overflow on small/landscape devices
    // Uses responsiveImageHeight (20% screen height, clamped 120-180px)
    return Image.asset(
      AppImages.logo5,
      height: context.responsiveImageHeight,
      width: context.responsiveImageHeight,
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
        // FIXED: Responsive active indicator width (15% screen width)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.screenWidth * 0.18, // Responsive width
              height: 8,
              decoration: BoxDecoration(
                color: brandGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(width: 6),
            _buildDot(),
            SizedBox(width: 6),
            _buildDot(),
            SizedBox(width: 6),
            _buildDot(),
          ],
        ),
        const SizedBox(height: 32),
        // FIXED: Responsive button using responsiveButtonHeight
        SizedBox(
          width: double.infinity,
          height: context.responsiveButtonHeight,
          child: ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingScreen1(),
              ),
            ),
            icon: const Icon(Icons.arrow_forward, size: 20),
            label: const Text(
              'Next',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: brandGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
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
