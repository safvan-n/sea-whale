import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color darkBg = Color(0xFF070D1E);
  static const Color cardBg = Color(0xFF0F1B38);
  static const Color cardBgElevated = Color(0xFF16254C);
  static const Color primaryTeal = Color(0xFF0077B6);
  static const Color accentCyan = Color(0xFF00B4D8);
  static const Color lightCyan = Color(0xFF90E0EF);
  static const Color oceanWhite = Color(0xFFF1F8FD);
  static const Color goldAccent = Color(0xFFF4A261);
  static const Color textMuted = Color(0xFF8E9BB0);
  static const Color borderLight = Color(0x1F90E0EF);
  static const Color successGreen = Color(0xFF06D6A0);

  static ThemeData get luxuryDarkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBg,
      primaryColor: accentCyan,
      canvasColor: darkBg,
      cardColor: cardBg,
      colorScheme: const ColorScheme.dark(
        primary: accentCyan,
        secondary: lightCyan,
        surface: cardBg,
        error: Color(0xFFEF476F),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBg.withAlpha(220),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: oceanWhite,
          letterSpacing: 0.5,
        ),
        iconTheme: const IconThemeData(color: oceanWhite),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          color: oceanWhite,
          fontWeight: FontWeight.w800,
        ),
        displayMedium: GoogleFonts.outfit(
          color: oceanWhite,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: GoogleFonts.outfit(
          color: oceanWhite,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        titleMedium: GoogleFonts.outfit(
          color: oceanWhite,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        bodyLarge: GoogleFonts.inter(
          color: oceanWhite,
          fontSize: 15,
        ),
        bodyMedium: GoogleFonts.inter(
          color: textMuted,
          fontSize: 13,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentCyan,
          foregroundColor: darkBg,
          elevation: 4,
          shadowColor: accentCyan.withAlpha(100),
          textStyle: GoogleFonts.outfit(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF0A132C),
        selectedItemColor: accentCyan,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),
    );
  }
}
