import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/widgets/app_empty_state.dart';

/// Displayed when the API returns an empty packages list.
class WellnessPackagesEmptyView extends StatelessWidget {
  const WellnessPackagesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppEmptyState(
      icon: Icons.spa_outlined,
      title: 'No packages available',
      subtitle: 'Check back later for wellness packages.',
    );
  }
}
