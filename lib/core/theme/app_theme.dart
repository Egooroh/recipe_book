import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFD4A373);
  static const Color secondary = Color(0xFFFAEDCD);
  static const Color background = Color(0xFFFEFAE0);
  static const Color textDark = Color(0xFF4A3B2A);
  static const Color accent = Color(0xFFE63946);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
        secondary: secondary,
      ),

      textTheme: TextTheme(
        displayLarge: const TextStyle(
            fontFamily: 'PlaypenSans',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: textDark
        ),
        headlineSmall: const TextStyle(
            fontFamily: 'PlaypenSans',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: textDark
        ),
        bodyLarge: const TextStyle(
            fontSize: 16,
            color: textDark
        ),
        bodyMedium: TextStyle(
            fontSize: 14,
            color: textDark.withOpacity(0.8)
        ),
      ),

      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.brown.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.lora(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: textDark
        ),
        iconTheme: const IconThemeData(color: textDark),
      ),
    );
  }
}