import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';

/// Severity type for [AppSnackBar].
enum AppSnackBarType { info, success, warning, error }

/// Utility class for displaying floating snack bars with semantic coloring.
///
/// Usage:
/// ```dart
/// AppSnackBar.show(context, 'Saved successfully!', type: AppSnackBarType.success);
/// AppSnackBar.show(context, 'Something went wrong.', type: AppSnackBarType.error);
/// ```
abstract final class AppSnackBar {
  /// Displays a themed [SnackBar] anchored to the nearest [Scaffold].
  static void show(
    BuildContext context,
    String message, {
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final (backgroundColor, icon) = switch (type) {
      AppSnackBarType.success => (
          AppColors.success,
          Icons.check_circle_outline
        ),
      AppSnackBarType.warning => (
          AppColors.warning,
          Icons.warning_amber_rounded
        ),
      AppSnackBarType.error => (AppColors.error, Icons.error_outline),
      AppSnackBarType.info => (AppColors.info, Icons.info_outline),
    };

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration,
          backgroundColor: backgroundColor,
          action: action,
          content: Row(
            children: [
              Icon(icon, color: AppColors.white, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
