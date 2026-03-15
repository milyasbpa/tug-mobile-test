import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/core/utils/app_logger.dart';

/// Logs all bloc transitions and errors.
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
  }
}
