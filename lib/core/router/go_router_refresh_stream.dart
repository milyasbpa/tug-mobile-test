import 'dart:async';

import 'package:flutter/foundation.dart';

/// Adapts a [Stream] into a [ChangeNotifier] so [GoRouter.refreshListenable]
/// re-evaluates its redirect logic whenever the stream emits a new value.
///
/// Typically used with [AuthBloc.stream]:
/// ```dart
/// refreshListenable: GoRouterRefreshStream(getIt<AuthBloc>().stream),
/// ```
///
/// Dispose is handled automatically when [GoRouter] is disposed.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
