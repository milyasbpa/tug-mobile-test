/// Spacing constants used throughout the app for consistent padding, gaps,
/// and margins.
///
/// Usage:
/// ```dart
/// SizedBox(height: AppSpacing.md)
/// Padding(padding: EdgeInsets.all(AppSpacing.lg))
/// ```
abstract final class AppSpacing {
  /// 4 — tiny gaps, icon padding
  static const double xs = 4;

  /// 8 — small gaps, inner form spacing
  static const double sm = 8;

  /// 16 — default page/card padding
  static const double md = 16;

  /// 24 — section spacing
  static const double lg = 24;

  /// 32 — large section breaks, hero spacing
  static const double xl = 32;

  /// 48 — extra-large spacing
  static const double xxl = 48;

  /// 64 — full-screen vertical centering gaps
  static const double xxxl = 64;
}
