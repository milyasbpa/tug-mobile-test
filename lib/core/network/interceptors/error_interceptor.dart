import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:injectable/injectable.dart';

/// Converts HTTP and connection errors into typed [AppException]s so
/// upper layers never deal with raw [DioException]s.
@injectable
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Use handler.reject() — NOT throw — so the typed exception is embedded in
    // DioException.error and Dio does not double-wrap it into a second [unknown].
    Exception appException;
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        appException = const NetworkException(
          'No internet connection or request timed out.',
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        if (statusCode == 401) {
          appException = const UnauthorizedException(
            'Session expired. Please log in again.',
          );
        } else {
          appException = ServerException(
            message: 'Request failed with status $statusCode.',
            statusCode: statusCode,
          );
        }

      case DioExceptionType.cancel:
        // Request was cancelled — propagate as-is.
        handler.next(err);
        return;

      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        appException = ServerException(
          message: err.message ?? 'An unexpected error occurred.',
        );
    }

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        error: appException,
      ),
    );
  }
}
