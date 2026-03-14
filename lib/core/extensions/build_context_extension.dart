import 'package:flutter/material.dart';

/// Extension on [BuildContext] for convenient access to theme, media query, etc.
/// without repeating `Theme.of(context)` everywhere.
///
/// For translations, use `context.t` provided by the slang-generated
/// [BuildContextTranslationsExtension] from `translations.g.dart`.
///
/// Example usage:
/// ```dart
/// // Without extension
/// Theme.of(context).colorScheme.primary
///
/// // With extension
/// context.colorScheme.primary
///
/// // Translations (via slang)
/// context.t.auth.loginTitle
/// ```
extension BuildContextX on BuildContext {
  // ─── Theme ──────────────────────────────────────────────────────────────────
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // ─── Media Query ────────────────────────────────────────────────────────────
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // ─── Navigation ─────────────────────────────────────────────────────────────
  // TODO(step-7): Add context.go(), context.push() after go_router is added
}
