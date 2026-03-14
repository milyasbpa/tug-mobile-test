import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';

/// Variant controls the visual style of [AppButton].
enum AppButtonVariant {
  /// [FilledButton] — primary CTA, high emphasis.
  primary,

  /// [FilledButton.tonal] — secondary CTA, medium emphasis.
  secondary,

  /// [OutlinedButton] — outlined, medium emphasis.
  outlined,

  /// [TextButton] — low emphasis, ghost action.
  text,
}

/// Standardised application button with consistent sizing, loading state,
/// and four visual variants.
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Sign In',
///   onPressed: _submit,
///   isLoading: state is AuthLoading,
///   isFullWidth: true,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.size = AppButtonSize.medium,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final AppButtonSize size;

  @override
  Widget build(BuildContext context) {
    final child = isLoading ? _loadingIndicator() : _labelChild();
    final effectiveCallback = isLoading ? null : onPressed;

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = icon != null && !isLoading
            ? FilledButton.icon(
                onPressed: effectiveCallback,
                icon: icon,
                label: child,
              )
            : FilledButton(
                onPressed: effectiveCallback,
                child: child,
              );
      case AppButtonVariant.secondary:
        button = icon != null && !isLoading
            ? FilledButton.tonalIcon(
                onPressed: effectiveCallback,
                icon: icon,
                label: child,
              )
            : FilledButton.tonal(
                onPressed: effectiveCallback,
                child: child,
              );
      case AppButtonVariant.outlined:
        button = icon != null && !isLoading
            ? OutlinedButton.icon(
                onPressed: effectiveCallback,
                icon: icon,
                label: child,
              )
            : OutlinedButton(
                onPressed: effectiveCallback,
                child: child,
              );
      case AppButtonVariant.text:
        button = icon != null && !isLoading
            ? TextButton.icon(
                onPressed: effectiveCallback,
                icon: icon,
                label: child,
              )
            : TextButton(
                onPressed: effectiveCallback,
                child: child,
              );
    }

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _loadingIndicator() => SizedBox.square(
        dimension: size == AppButtonSize.small ? 16 : 20,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      );

  Widget _labelChild() => Padding(
        padding: EdgeInsets.symmetric(
          vertical: size == AppButtonSize.small ? 0 : AppSpacing.xs / 2,
        ),
        child: Text(label),
      );
}

/// Controls the height / padding of [AppButton].
enum AppButtonSize {
  small,
  medium,
  large,
}
