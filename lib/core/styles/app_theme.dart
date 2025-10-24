import 'package:eventara/core/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.poppinsTextTheme(),
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColor.primary.color,
        secondary: AppColor.accent.color,
        surface: AppColor.surfaceLight.color,
        error: AppColor.error.color,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColor.textPrimaryLight.color,
      ),
      scaffoldBackgroundColor: AppColor.backgroundLight.color,
      cardColor: AppColor.surfaceLight.color,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.surfaceLight.color,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primary.color),
        titleTextStyle: TextStyle(
          color: AppColor.textPrimaryLight.color,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.surfaceLight.color,
        selectedItemColor: AppColor.primary.color,
        unselectedItemColor: AppColor.textSecondaryLight.color,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surfaceLight.color,
        labelStyle: TextStyle(color: AppColor.textSecondaryLight.color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.primary.color, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.error.color),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary.color,
          foregroundColor: Colors.white,
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: GoogleFonts.poppinsTextTheme(),
      colorScheme: ColorScheme.dark(
        primary: AppColor.primaryLight.color,
        secondary: AppColor.accentLight.color,
        surface: AppColor.surfaceDark.color,

        error: AppColor.error.color,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: AppColor.textPrimaryDark.color,
      ),
      scaffoldBackgroundColor: AppColor.backgroundDark.color,
      cardColor: AppColor.surfaceDark.color,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColor.surfaceDark.color,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColor.primaryLight.color),
        titleTextStyle: TextStyle(
          color: AppColor.textPrimaryDark.color,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColor.surfaceDark.color,
        selectedItemColor: AppColor.primaryLight.color,
        unselectedItemColor: AppColor.textSecondaryDark.color,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColor.surfaceDark.color,
        labelStyle: TextStyle(color: AppColor.textSecondaryDark.color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.textSecondaryDark.color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.primaryLight.color, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.error.color),
        ),
      ),
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primary.color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
      ),
    );
  }
}
