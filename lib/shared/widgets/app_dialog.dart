import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter_starter_kit/shared/widgets/app_button.dart';

abstract final class AppDialog {
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
