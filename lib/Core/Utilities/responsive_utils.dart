import 'package:flutter/material.dart';

extension ResponsiveUtils on BuildContext {
  /// Responsive gap: 16px on small screens, 24px on larger
  double get responsiveGap => MediaQuery.of(this).size.width < 375 ? 16.0 : 24.0;

  /// Responsive image height for illustrations: 22% of screen height, clamped 120-200px
  double get responsiveImageHeight {
    final height = MediaQuery.of(this).size.height;
    return (height * 0.22).clamp(120.0, 200.0);
  }

  /// Standard button height (Material Design spec)
  double get responsiveButtonHeight => 56.0;

  /// Bottom navigation safe padding
  double get bottomNavPadding => MediaQuery.paddingOf(this).bottom;

  /// Screen width utility
  double get screenWidth => MediaQuery.of(this).size.width;
}
