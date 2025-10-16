import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF064A58);
  static const Color secondaryColor = Color(0xFFE04703);
  static const Color lightBlue = Color(0xFFC7FBF9);

  // Background gradient colors
  static const List<Color> backgroundGradient = [
    Color(0xFFFFFFFF), // White at top
    Color(0xFFB9FAF8), // Light teal at bottom
  ];

  static const List<double> backgroundStops = [0.2404, 1.0];

  static BoxDecoration get backgroundDecoration => const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: backgroundGradient,
      stops: backgroundStops,
    ),
  );

  static ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    // Default to Mulish for body/content
    fontFamily: 'Mulish',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w500),
      bodySmall: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w500),
      labelLarge: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w600),
      labelMedium: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w600),
      labelSmall: TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w600),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF83B8C6)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF83B8C6)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF83B8C6), width: 2),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF83B8C6)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade700),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade700, width: 2),
      ),
    ),
  );

  // Text styles
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 40,
    height: 1.1,
    color: primaryColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 30,
    height: 1.1,
    color: primaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontFamily: 'Mulish',
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.1,
    color: primaryColor,
  );

  static const TextStyle skipButtonStyle = TextStyle(
    fontFamily: 'Mulish',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: primaryColor,
  );

  // Navigation button decoration
  static BoxDecoration get navigationButtonDecoration => BoxDecoration(
    color: secondaryColor,
    shape: BoxShape.circle,
    border: Border.all(color: lightBlue, width: 2.18),
  );

  // Pagination dot decoration
  static BoxDecoration get activeDotDecoration =>
      const BoxDecoration(color: primaryColor, shape: BoxShape.circle);

  static BoxDecoration get inactiveDotDecoration =>
      const BoxDecoration(color: Colors.white, shape: BoxShape.circle);
}
