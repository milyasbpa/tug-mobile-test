import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Application-wide structured logger.
///
/// Wraps the `logger` package so the rest of the codebase stays decoupled.
///
/// Behaviour:
/// - **Debug**: all levels printed to console with pretty formatting.
/// - **Release**: printing suppressed; `warning`/`error` will forward to
///   Crashlytics in Step 14.
///
/// Usage:
/// ```dart
/// AppLogger.debug('Fetching user data');
/// AppLogger.error('Login failed', error: e, stackTrace: s);
/// ```
abstract final class AppLogger {
  static final Logger _log = Logger(
    printer: PrettyPrinter(),
    // DevelopmentFilter logs all levels; ProductionFilter only W+E.
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    // Suppress console output entirely in release — Crashlytics handles it.
    output: kDebugMode ? ConsoleOutput() : null,
  );

  /// Fine-grained diagnostic messages.
  static void debug(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.d(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  /// Confirmation that things are working as expected.
  static void info(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.i(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  /// Potentially harmful situations that may lead to errors.
  static void warning(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.w(_format(message, tag), error: error, stackTrace: stackTrace);
    // TODO(step-14): FirebaseCrashlytics.instance.log('WARNING: $message');
  }

  /// Error events — may still allow the app to continue running.
  static void error(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(_format(message, tag), error: error, stackTrace: stackTrace);
    // TODO(step-14): FirebaseCrashlytics.instance.recordError(error ?? message, stackTrace);
  }

  static Object _format(Object? message, String? tag) =>
      tag != null ? '[$tag] $message' : '$message';
}
