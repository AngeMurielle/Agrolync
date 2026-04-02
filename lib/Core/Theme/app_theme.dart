import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF026139);
  static const Color scaffoldBg = Color(0xFFF8FBF9);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: scaffoldBg,
    colorScheme:
        ColorScheme.fromSeed(seedColor: primaryGreen, primary: primaryGreen),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: AppTheme.primaryGreen,
          fontWeight: FontWeight.bold,
          fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
    ),
  );
}
