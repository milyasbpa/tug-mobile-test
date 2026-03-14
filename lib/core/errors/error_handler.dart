import 'package:flutter/foundation.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/utils/app_logger.dart';
import 'package:injectable/injectable.dart';

/// Global error handler — the single entry point for all uncaught errors.
///
/// Registered as a singleton so it can be wired into:
/// - `FlutterError.onError` (Flutter framework errors)
/// - `PlatformDispatcher.instance.onError` (platform / async errors)
/// - `runZonedGuarded` callback (zone-escaped errors)
/// - `AppBlocObserver.onError` (Bloc/Cubit errors)
///
/// In Step 14 a `CrashlyticsService` dependency will be added here so every
/// error is automatically forwarded to Firebase Crashlytics in production.
@singleton
class ErrorHandler {
  const ErrorHandler();

  /// Handle a raw [error] with its [stackTrace].
  ///
  /// Logs the error in debug mode and — after Step 14 — forwards it to
  /// Crashlytics in release mode.
  void handle(Object error, StackTrace stackTrace) {
    AppLogger.error(
      'Uncaught error: $error',
      error: error,
      stackTrace: stackTrace,
    );
    // TODO(step-14): getIt<CrashlyticsService>().recordError(error, stackTrace);
  }

  /// Adapter for [FlutterError.onError].
  ///
  /// In debug mode the default Flutter error widget behaviour is preserved
  /// so the red screen is still shown.
  void handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      // Preserve Flutter's default error reporting in debug.
      FlutterError.presentError(details);
    }
    handle(details.exception, details.stack ?? StackTrace.empty);
  }

  // ---------------------------------------------------------------------------
  // Failure → user-facing message mapping
  // ---------------------------------------------------------------------------

  /// Converts a domain [Failure] to a user-friendly message string.
  ///
  /// Use this in BLoC states / Cubit methods where [BuildContext] is not
  /// available. For full i18n support consider using `context.t.*` directly
  /// in the presentation layer.
  ///
  // TODO(i18n): replace hardcoded strings with slang keys once the
  //   `common` namespace has error message entries.
  static String failureToMessage(Failure failure) {
    return switch (failure) {
      NetworkFailure() => failure.message.isNotEmpty
          ? failure.message
          : 'No internet connection. Please check your network.',
      UnauthorizedFailure() =>
        'Your session has expired. Please sign in again.',
      ServerFailure() => failure.message.isNotEmpty
          ? failure.message
          : 'Something went wrong on our end. Please try again later.',
      CacheFailure() => 'Failed to load saved data. Please restart the app.',
      ValidationFailure() =>
        failure.message.isNotEmpty ? failure.message : 'Invalid input.',
      _ => 'An unexpected error occurred. Please try again.',
    };
  }
}
