import 'dart:async';

import 'package:flutter/foundation.dart';

/// Bridges a [Stream] to [ChangeNotifier] so [GoRouter] re-evaluates
/// its redirect on every stream event.
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
