import 'package:flutter/material.dart';

/// Centralized color palette for the application.
///
/// Usage:
/// ```dart
/// Container(color: AppColors.primary)
/// ```
///
/// All named colors are available as-is. For theme-aware colors (light vs dark)
/// prefer [ColorScheme] values via `Theme.of(context).colorScheme` — this class
/// provides the raw tokens that seed those schemes.
abstract final class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────────

  /// Primary brand blue used for buttons, links, and active indicators.
  static const Color primary = Color(0xFF1B6EF3);

  /// A darker shade of primary — used for pressed/hover states.
  static const Color primaryDark = Color(0xFF0D5ACC);

  /// Secondary accent — soft purple for chips, tags, and secondary actions.
  static const Color secondary = Color(0xFF6C5CE7);

  /// Tertiary accent — mint green for positive trends, tags.
  static const Color tertiary = Color(0xFF00B894);

  // ── Semantic ───────────────────────────────────────────────────────────────

  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF09500);
  static const Color error = Color(0xFFE5384F);
  static const Color info = Color(0xFF3498DB);

  // ── Neutral scale ─────────────────────────────────────────────────────────

  static const Color white = Color(0xFFFFFFFF);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);
  static const Color black = Color(0xFF000000);

  // ── Dark surface scale ────────────────────────────────────────────────────

  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceDark2 = Color(0xFF1E1E1E);
  static const Color surfaceDark3 = Color(0xFF252525);

  // ── Shimmer / skeleton ────────────────────────────────────────────────────

  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2A2A2A);
  static const Color shimmerHighlightDark = Color(0xFF3A3A3A);
}
