import 'package:flutter/foundation.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/utils/app_logger.dart';
import 'package:injectable/injectable.dart';

/// Routes uncaught errors to the logger.
@singleton
class ErrorHandler {
  const ErrorHandler();

  void handle(Object error, StackTrace stackTrace) {
    AppLogger.error(
      'Uncaught error: $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void handleFlutterError(FlutterErrorDetails details) {
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
    handle(details.exception, details.stack ?? StackTrace.empty);
  }

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
