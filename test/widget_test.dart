// Widget smoke tests for self-contained shared widgets.
//
// Note: Full app widget tests require DI setup and are placed under
// test/features/*/presentation/ alongside their feature tests.

import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/widgets/app_empty_state.dart';
import 'package:flutter_starter_kit/shared/widgets/app_error_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEmptyState', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(title: 'Nothing here yet'),
          ),
        ),
      );

      expect(find.text('Nothing here yet'), findsOneWidget);
    });

    testWidgets('renders subtitle when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Empty',
              subtitle: 'Try adding something',
            ),
          ),
        ),
      );

      expect(find.text('Try adding something'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Empty',
              icon: Icons.inbox_outlined,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
    });

    testWidgets('renders action button when actionLabel + onAction provided',
        (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Empty',
              actionLabel: 'Retry',
              onAction: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Retry'));
      expect(tapped, isTrue);
    });
  });

  group('AppErrorWidget', () {
    testWidgets('renders error message', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(message: 'Failed to load data'),
          ),
        ),
      );

      // Default title and custom message are two distinct Text widgets
      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Failed to load data'), findsOneWidget);
    });

    testWidgets('calls onRetry when retry button is tapped', (tester) async {
      var retried = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppErrorWidget(
              message: 'Error',
              onRetry: () => retried = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.refresh));
      expect(retried, isTrue);
    });
  });
}
