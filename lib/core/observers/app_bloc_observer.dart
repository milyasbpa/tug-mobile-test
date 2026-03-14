import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/utils/app_logger.dart';

/// Global observer for all Blocs and Cubits in the application.
///
/// Registered once in [main] via `Bloc.observer = const AppBlocObserver()`.
///
/// - [onTransition]: logs every state change in debug mode.
/// - [onError]: logs errors via [AppLogger] and will forward to Crashlytics
///   in Step 14.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    AppLogger.debug(
      '${bloc.runtimeType} '
      '${transition.event.runtimeType} → '
      '${transition.nextState.runtimeType}',
      tag: 'BLoC',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogger.error(
      'Error in ${bloc.runtimeType}',
      tag: 'BLoC',
      error: error,
      stackTrace: stackTrace,
    );
    // TODO(step-14): getIt<CrashlyticsService>().recordError(error, stackTrace);
  }
}
