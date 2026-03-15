import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/app_spacing.dart';
import 'package:flutter_starter_kit/shared/widgets/app_loading.dart';

/// A shimmer skeleton list displayed while [WellnessPackagesLoading] is active.
///
/// Renders [itemCount] skeleton cards that mimic the shape of [WellnessPackageCard].
class WellnessPackageLoadingView extends StatelessWidget {
  const WellnessPackageLoadingView({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm / 2,
        ),
        child: AppLoading.skeletonCard(height: 110),
      ),
    );
  }
}
