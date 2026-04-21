import 'package:flutter/material.dart';
import '../drawer.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  // Logic: Variable to hold the current language selection code (e.g., 'en' or 'fr')
  String? _selectedLanguageCode = 'en'; // Requirement: Set default to English

  // Requirement: Asset image path for the central icon
  final String _languageIconPath = 'assets/images/Lang.png';

  // Specific Branding Colors from the design
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkTextColor = Color(0xFF1E293B);
  static const Color subTextColor = Color(0xFF64748B);
  static const Color borderGrey = Color(0xFFE2E8F0);
  static const Color backgroundGrey = Color(0xFFF8FAFC);
  static const Color activeGreen = Color(0xFF007E47);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      drawer: const DrawerPage(initialSelectedItem: 'Profile'),
      appBar: AppBar(
        backgroundColor: backgroundGrey,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Language Settings',
          style: TextStyle(
            color: darkTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // --- The Core Language Icon ---
                    // Requirement: Using the asset image Lang.png
                    Image.asset(
                      _languageIconPath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                      // Handle missing asset gracefully during development
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.public_rounded,
                        color: activeGreen,
                        size: 48,
                      ),
                    ),

                    const SizedBox(height: 02),
                    const Text(
                      "Select Language",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: darkTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Choose your preferred language for Agrolync",
                      style: TextStyle(fontSize: 16, color: subTextColor),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),

                    // --- Interactive Selection List ---
                    _buildLanguageItem(
                      code: 'en',
                      languageName: 'English',
                      subName: 'International',
                    ),
                    const SizedBox(height: 20),
                    _buildLanguageItem(
                      code: 'fr',
                      languageName: 'Français',
                      subName: 'French',
                    ),
                  ],
                ),
              ),
            ),

            // --- The Confirmation Action ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 65.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic: Apply the selection to the app locale/configuration
                    _applySelectedLanguage();

                    // UX: Show feedback and navigate back or proceed
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Locale setting updated')),
                    );
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brandGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Confirm Selection",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        Icons.check_circle_outline_rounded,
                        size: 22,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget for consistent list items
  Widget _buildLanguageItem({
    required String code,
    required String languageName,
    required String subName,
  }) {
    final bool isSelected = _selectedLanguageCode == code;
    return GestureDetector(
      onTap: () {
        // Logic: Update the state when a farmer taps the row
        setState(() => _selectedLanguageCode = code);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderGrey),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: subTextColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  code.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: subTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: darkTextColor,
                    ),
                  ),
                  Text(
                    subName,
                    style: const TextStyle(fontSize: 14, color: subTextColor),
                  ),
                ],
              ),
            ),
            // Requirement: Selection radio indicator logic
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? activeGreen : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected ? activeGreen : subTextColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.circle, color: Colors.white, size: 10),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // --- Logic for Application Locale Update ---
  void _applySelectedLanguage() {
    // You must implement the logic here to change your app's locale globally.
    // Example using standard localization packages like easy_localization or flutter_localizations:
    // context.setLocale(Locale(_selectedLanguageCode!));
    debugPrint('Farmer selected: $_selectedLanguageCode');
  }
}
