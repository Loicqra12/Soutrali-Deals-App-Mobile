import 'package:flutter/material.dart';

class FreelanceTheme {
  static const Color primaryColor = Color(0xFF27AE60);
  static const Color secondaryColor = Color(0xFF2D3748);
  static const Color accentColor = Color(0xFFFFA726);
  
  static const double cardBorderRadius = 12.0;
  static const double categoryCardHeight = 120.0;
  static const double categoryCardWidth = 100.0;
  
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(cardBorderRadius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static BoxDecoration selectedCardDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(cardBorderRadius),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.3),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: secondaryColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    color: Colors.black87,
  );

  static InputDecoration searchInputDecoration = InputDecoration(
    hintText: 'Rechercher un freelance',
    hintStyle: TextStyle(color: Colors.grey[400]),
    border: InputBorder.none,
    prefixIcon: const Icon(Icons.search, color: primaryColor),
    suffixIcon: const Icon(Icons.tune, color: primaryColor),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: primaryColor),
    ),
  );
}
