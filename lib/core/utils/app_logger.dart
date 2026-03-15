import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

abstract final class AppLogger {
  static final Logger _log = Logger(
    printer: PrettyPrinter(),
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    output: kDebugMode ? ConsoleOutput() : null,
  );

  static void debug(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.d(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  static void info(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.i(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  static void warning(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.w(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  static void error(
    Object? message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log.e(_format(message, tag), error: error, stackTrace: stackTrace);
  }

  static Object _format(Object? message, String? tag) =>
      tag != null ? '[$tag] $message' : '$message';
}
