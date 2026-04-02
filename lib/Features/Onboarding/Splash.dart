import 'dart:async';
import 'package:flutter/material.dart';
// Note: Ensure these paths match your project structure exactly
import 'package:flutter_agrolync_pro/Features/Onboarding/Onboarding.dart';
import 'package:flutter_agrolync_pro/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() {
    Timer(const Duration(seconds: 3), () {
      // ✅ FIX: Check if the widget is still in the tree before navigating
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF026139),
      // ✅ FIX: Added the missing 'child' parameter for Center
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Image.asset(
            AppImages.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}