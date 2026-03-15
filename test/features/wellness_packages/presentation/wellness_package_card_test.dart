import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/l10n/translations.g.dart';
import 'package:flutter_starter_kit/core/theme/app_theme.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/widgets/wellness_package_card.dart';
import 'package:flutter_test/flutter_test.dart';

// ── Helpers ───────────────────────────────────────────────────────────────────

/// Wraps [child] in a minimal [MaterialApp] with English translations and the
/// app's light theme so that [WellnessPackageCard] can access [Theme.of] and
/// [Translations.of].
Widget _wrap(Widget child) {
  LocaleSettings.setLocaleSync(AppLocale.en);
  return TranslationProvider(
    child: MaterialApp(
      theme: AppTheme.light,
      home: Scaffold(body: child),
    ),
  );
}

// ── Fixtures ──────────────────────────────────────────────────────────────────

final _tPackage = WellnessPackage(
  id: 'pkg-001',
  name: 'Swedish Massage',
  description: 'A relaxing full-body massage.',
  price: 150000,
  durationMinutes: 60,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  group('WellnessPackageCard', () {
    testWidgets('displays package name', (tester) async {
      await tester.pumpWidget(_wrap(WellnessPackageCard(package: _tPackage)));

      expect(find.text('Swedish Massage'), findsOneWidget);
    });

    testWidgets('displays package description', (tester) async {
      await tester.pumpWidget(_wrap(WellnessPackageCard(package: _tPackage)));

      expect(find.text('A relaxing full-body massage.'), findsOneWidget);
    });

    testWidgets('displays price formatted as IDR currency', (tester) async {
      await tester.pumpWidget(_wrap(WellnessPackageCard(package: _tPackage)));

      // 150000 → "Rp 150.000"
      expect(find.text('Rp 150.000'), findsOneWidget);
    });

    testWidgets('displays duration in minutes via i18n string', (tester) async {
      await tester.pumpWidget(_wrap(WellnessPackageCard(package: _tPackage)));

      // En translation: "$minutes min"
      expect(find.text('60 min'), findsOneWidget);
    });

    testWidgets('formats price with dot separator for thousands', (tester) async {
      final package = WellnessPackage(
        id: 'pkg-002',
        name: 'Premium Package',
        description: 'Premium experience.',
        price: 1500000, // 1.500.000
        durationMinutes: 120,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026),
      );

      await tester.pumpWidget(_wrap(WellnessPackageCard(package: package)));

      expect(find.text('Rp 1.500.000'), findsOneWidget);
    });
  });
}
