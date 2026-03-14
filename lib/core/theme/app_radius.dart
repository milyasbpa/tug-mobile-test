import 'package:flutter/material.dart';

/// Border-radius tokens for consistent rounded corners.
///
/// Usage:
/// ```dart
/// // Scalar value
/// borderRadius: BorderRadius.circular(AppRadius.md)
///
/// // Pre-built BorderRadius
/// borderRadius: AppRadius.mdBorderRadius
/// ```
abstract final class AppRadius {
  static const double none = 0;

  /// 4 — very subtle rounding (chips, tags)
  static const double xs = 4;

  /// 8 — standard card / input rounding
  static const double sm = 8;

  /// 12 — default card radius
  static const double md = 12;

  /// 16 — larger cards, sheets
  static const double lg = 16;

  /// 24 — hero cards, hero images
  static const double xl = 24;

  /// 999 — fully circular (pills, FABs)
  static const double full = 999;

  // Pre-computed [BorderRadius] constants for convenience.
  static const BorderRadius noneBorderRadius = BorderRadius.zero;
  static const BorderRadius xsBorderRadius =
      BorderRadius.all(Radius.circular(xs));
  static const BorderRadius smBorderRadius =
      BorderRadius.all(Radius.circular(sm));
  static const BorderRadius mdBorderRadius =
      BorderRadius.all(Radius.circular(md));
  static const BorderRadius lgBorderRadius =
      BorderRadius.all(Radius.circular(lg));
  static const BorderRadius xlBorderRadius =
      BorderRadius.all(Radius.circular(xl));
  static const BorderRadius fullBorderRadius =
      BorderRadius.all(Radius.circular(full));
}
