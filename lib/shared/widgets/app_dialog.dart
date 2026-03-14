import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter_starter_kit/shared/widgets/app_button.dart';

/// Helper class for displaying standard dialogs.
///
/// Usage:
/// ```dart
/// // Informational dialog
/// await AppDialog.show(
///   context,
///   title: 'Notice',
///   content: 'Your session has expired.',
/// );
///
/// // Confirmation dialog — returns true if confirmed
/// final confirmed = await AppDialog.confirm(
///   context,
///   title: 'Delete account?',
///   content: 'This action cannot be undone.',
///   confirmLabel: 'Delete',
///   isDanger: true,
/// );
/// ```
abstract final class AppDialog {
  /// Shows a standard alert dialog with optional custom [actions].
  ///
  /// Returns when the dialog is dismissed.
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
    String closeLabel = 'OK',
    List<Widget>? actions,
  }) =>
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions ??
              [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(closeLabel),
                ),
              ],
        ),
      );

  /// Shows a confirmation dialog.
  ///
  /// Returns `true` if the user confirms, `false` if cancelled, `null` if
  /// dismissed via back-press.
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String content,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDanger = false,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            AppButton(
              label: cancelLabel,
              variant: AppButtonVariant.text,
              onPressed: () => Navigator.of(ctx).pop(false),
            ),
            const SizedBox(width: AppSpacing.xs),
            AppButton(
              label: confirmLabel,
              variant: isDanger
                  ? AppButtonVariant.primary
                  : AppButtonVariant.primary,
              onPressed: () => Navigator.of(ctx).pop(true),
            ),
          ],
        ),
      );
}
