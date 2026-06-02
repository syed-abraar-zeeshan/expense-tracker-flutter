import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // Shared typography parameters across styles
  static TextStyle _getHeadingStyle(Color color) =>
      GoogleFonts.plusJakartaSans(color: color, fontWeight: FontWeight.w700);

  // ==========================================================================
  // THE LIGHT THEME ENGINE
  // ==========================================================================
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.success,
        error: AppColors.danger,
        surface: AppColors.lightSurface,
      ),
      textTheme:
          GoogleFonts.plusJakartaSansTextTheme(
            ThemeData.light().textTheme,
          ).copyWith(
            headlineMedium: _getHeadingStyle(AppColors.lightTextPrimary),
            titleLarge: _getHeadingStyle(
              AppColors.lightTextPrimary,
            ).copyWith(fontWeight: FontWeight.w600),
            bodyLarge: GoogleFonts.plusJakartaSans(
              color: AppColors.lightTextPrimary,
            ),
            bodyMedium: GoogleFonts.plusJakartaSans(
              color: AppColors.lightTextSecondary,
            ),
          ),
      inputDecorationTheme: _getInputTheme(
        fillColor: AppColors.lightSurface,
        borderColor: AppColors.lightBorder,
        labelColor: AppColors.lightTextSecondary,
      ),
      elevatedButtonTheme: _getButtonTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
    );
  }

  // ==========================================================================
  // THE DARK THEME ENGINE
  // ==========================================================================
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.success,
        error: AppColors.danger,
        surface: AppColors.darkSurface,
      ),
      textTheme:
          GoogleFonts.plusJakartaSansTextTheme(
            ThemeData.dark().textTheme,
          ).copyWith(
            headlineMedium: _getHeadingStyle(AppColors.darkTextPrimary),
            titleLarge: _getHeadingStyle(
              AppColors.darkTextPrimary,
            ).copyWith(fontWeight: FontWeight.w600),
            bodyLarge: GoogleFonts.plusJakartaSans(
              color: AppColors.darkTextPrimary,
            ),
            bodyMedium: GoogleFonts.plusJakartaSans(
              color: AppColors.darkTextSecondary,
            ),
          ),
      inputDecorationTheme: _getInputTheme(
        fillColor: AppColors.darkSurface,
        borderColor: AppColors.darkBorder,
        labelColor: AppColors.darkTextSecondary,
      ),
      elevatedButtonTheme: _getButtonTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
    );
  }

  // Shared Helper Configurations for cleaner code abstraction
  static InputDecorationTheme _getInputTheme({
    required Color fillColor,
    required Color borderColor,
    required Color labelColor,
  }) => InputDecorationTheme(
    filled: true,
    fillColor: fillColor,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    labelStyle: TextStyle(color: labelColor),
    floatingLabelStyle: const TextStyle(color: AppColors.primary),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.danger, width: 1),
    ),
  );

  static ElevatedButtonThemeData _getButtonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      minimumSize: const Size.fromHeight(54),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
