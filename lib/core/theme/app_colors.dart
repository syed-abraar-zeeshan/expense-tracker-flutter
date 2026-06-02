import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Prevent instantiation

  // ==========================================================================
  // Global Semantic Colors (Identical in both themes for data consistency)
  // ==========================================================================
  static const Color primary = Color(
    0xFF4F46E5,
  ); // Deep Indigo (Primary Actions / Branding)
  static const Color primaryLight = Color(
    0xFF818CF8,
  ); // Muted Indigo (Focus rings / Accents)
  static const Color success = Color(
    0xFF10B981,
  ); // Emerald Green (Income / Positive Cashflow)
  static const Color error = Color(
    0xFFEF4444,
  ); // Coral Red (Expenses / Outflow / Alerts)
  static const Color warning = Color(
    0xFFF59E0B,
  ); // Amber (Pending Sync / Budget Warnings)

  // Decorative Chart Category Extensions (Kept strict and clean)
  static const Color chartBlue = Color(0xFF0EA5E9);
  static const Color chartPurple = Color(0xFFA855F7);

  // ==========================================================================
  // Dark Theme Palette (Deep Slate Canvas)
  // ==========================================================================
  static const Color darkBackground = Color(0xFF0F172A); // Midnight Slate Blue
  static const Color darkSurface = Color(0xFF1E293B); // Solid Slate Card Fill
  static const Color darkBorder = Color(0xFF334155); // Clean Boundary Outlines
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Crisp Off-White
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Cool Muted Grey

  // ==========================================================================
  // Light Theme Palette (Clean Executive Studio Canvas)
  // ==========================================================================
  static const Color lightBackground = Color(
    0xFFF8FAFC,
  ); // Soft Light Ice-Blue/White
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure White Card Fill
  static const Color lightBorder = Color(0xFFE2E8F0); // Subtle Divider Grey
  static const Color lightTextPrimary = Color(0xFF0F172A); // Deep Midnight Text
  static const Color lightTextSecondary = Color(
    0xFF64748B,
  ); // Professional Slate Grey
}
