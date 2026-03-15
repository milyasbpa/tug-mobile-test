import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/shared/widgets/app_empty_state.dart';

class WellnessPackagesEmptyView extends StatelessWidget {
  const WellnessPackagesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).wellnessPackages;
    return AppEmptyState(
      icon: Icons.spa_outlined,
      title: t.empty,
      subtitle: t.emptySubtitle,
    );
  }
}
