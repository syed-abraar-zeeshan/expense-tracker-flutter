import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ----------------------------------------------------
  // BRAND COLORS (Premium Fintech Palette)
  // ----------------------------------------------------
  static const primary = Color(0xFF5D5FEF); // Vibrant Indigo
  static const secondary = Color(0xFF3ACADF); // Modern Cyan
  static const accent = Color(0xFF7000FF); // Electric Violet

  // ----------------------------------------------------
  // PREMIUM GRADIENTS
  // ----------------------------------------------------
  static const primaryGradient = [
    Color(0xFF5D5FEF),
    Color(0xFF7000FF),
  ];

  static const surfaceGradient = [
    Color(0xFF1E293B),
    Color(0xFF0F172A),
  ];

  static const accentGradient = [
    Color(0xFF3ACADF),
    Color(0xFF5D5FEF),
  ];

  // ----------------------------------------------------
  // STATUS COLORS
  // ----------------------------------------------------
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // ----------------------------------------------------
  // LIGHT THEME (Monzo/Jupiter Inspired)
  // ----------------------------------------------------
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFFFFFFF);
  static const lightBorder = Color(0xFFE2E8F0);
  static const lightDivider = Color(0xFFF1F5F9);
  
  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightTextDisabled = Color(0xFF94A3B8);

  // ----------------------------------------------------
  // DARK THEME (CRED/Revolut Inspired)
  // ----------------------------------------------------
  static const darkBackground = Color(0xFF020617); // Deepest Navy/Black
  static const darkSurface = Color(0xFF0F172A); // Slate 900
  static const darkCard = Color(0xFF1E293B); // Slate 800
  static const darkBorder = Color(0xFF334155); // Slate 700
  static const darkDivider = Color(0xFF1E293B); 
  
  static const darkTextPrimary = Color(0xFFF8FAFC);
  static const darkTextSecondary = Color(0xFFCBD5E1); // Lightened from Slate 400 to 300
  static const darkTextDisabled = Color(0xFF64748B); // Lightened from Slate 600 to 500

  // ----------------------------------------------------
  // UTILITIES
  // ----------------------------------------------------
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Colors.transparent;

  // Glassmorphism effects
  static final glassWhite = Colors.white.withValues(alpha: 0.1);
  static final glassBlack = Colors.black.withValues(alpha: 0.1);
  
  // Backward compatibility (Mapping to new colors)
  static const dashboardBackground = lightBackground;
  static const balanceGradientStart = Color(0xFF5D5FEF);
  static const balanceGradientEnd = Color(0xFF7000FF);

  // Restored Legacy Colors
  static const grey = Color(0xFF94A3B8); // Mapped to Slate 400
  static const greyLight = Color(0xFFE2E8F0); // Mapped to Slate 200
  static const black87 = Color(0xDE000000);
  static const black54 = Color(0x8A000000);
  static const avatarBackground = Color(0xFFF1F5F9);
  static const transactionCountBg = Color(0xFFF1F5F9);
  static const transactionIconOrange = warning;
}


