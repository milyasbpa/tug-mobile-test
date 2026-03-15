import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/constants/env_config.dart';
import 'package:flutter_starter_kit/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/error_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/logging_interceptor.dart';
import 'package:injectable/injectable.dart';

@singleton
class DioClient {
  DioClient(
    AuthInterceptor authInterceptor,
    LoggingInterceptor loggingInterceptor,
    ErrorInterceptor errorInterceptor,
  ) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )..interceptors.addAll([
        loggingInterceptor,
        authInterceptor,
        errorInterceptor,
      ]);
  }

  late final Dio _dio;

  /// The configured [Dio] instance for making HTTP requests.
  Dio get dio => _dio;
}
