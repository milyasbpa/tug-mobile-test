import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

/// Logs HTTP requests and responses in debug mode only.
@injectable
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── REQUEST ─────────────────────────────');
      debugPrint('│ ${options.method} ${options.uri}');
      if (options.headers.isNotEmpty) {
        debugPrint('│ Headers: ${options.headers}');
      }
      if (options.data != null) {
        debugPrint('│ Body: ${options.data}');
      }
      debugPrint('└────────────────────────────────────────');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint('┌── RESPONSE ────────────────────────────');
      debugPrint('│ ${response.statusCode} ${response.requestOptions.uri}');
      debugPrint('│ Data: ${response.data}');
      debugPrint('└────────────────────────────────────────');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('┌── ERROR ───────────────────────────────');
      debugPrint('│ ${err.type} ${err.requestOptions.uri}');
      debugPrint('│ Message: ${err.message}');
      debugPrint('└────────────────────────────────────────');
    }
    handler.next(err);
  }
}
