import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/theme/app_radius.dart';

/// Loading and skeleton placeholder widgets.
///
/// Usage:
/// ```dart
/// // Full-screen blocking loader
/// AppLoading.circular()
///
/// // Inline spinner
/// const AppLoading.inline()
///
/// // Shimmer skeleton block
/// AppLoading.skeleton(width: 200, height: 20)
/// ```
abstract final class AppLoading {
  /// Centered [CircularProgressIndicator] — use as a page-level loader.
  static Widget circular({Color? color}) => Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );

  /// Small inline [CircularProgressIndicator] — use inside buttons or lists.
  static Widget inline({
    double size = 20,
    double strokeWidth = 2,
    Color? color,
  }) =>
      SizedBox.square(
        dimension: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
        ),
      );

  /// Shimmer skeleton rectangle.
  ///
  /// Animates a gradient sweep to indicate loading content.
  static Widget skeleton({
    double? width,
    double height = 16,
    BorderRadius borderRadius = AppRadius.smBorderRadius,
  }) =>
      _ShimmerBox(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );

  /// A full card-shaped skeleton — useful for list items.
  static Widget skeletonCard({double height = 80}) => _ShimmerBox(
        height: height,
        borderRadius: AppRadius.mdBorderRadius,
      );
}

/// Animated shimmer widget that does not require an external package.
class _ShimmerBox extends StatefulWidget {
  const _ShimmerBox({
    required this.height,
    this.width,
    this.borderRadius = AppRadius.smBorderRadius,
  });

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    unawaited(_controller.repeat());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(-1.5 + _controller.value * 3, 0),
              end: Alignment(-0.5 + _controller.value * 3, 0),
              colors: isDark
                  ? [
                      AppColors.shimmerBaseDark,
                      AppColors.shimmerHighlightDark,
                      AppColors.shimmerBaseDark,
                    ]
                  : [
                      AppColors.shimmerBase,
                      AppColors.shimmerHighlight,
                      AppColors.shimmerBase,
                    ],
            ),
          ),
        );
      },
    );
  }
}
