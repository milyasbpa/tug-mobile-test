import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/storage/local_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Injects the Bearer token into outgoing requests.
@injectable
class AuthInterceptor extends Interceptor {
  const AuthInterceptor(this._storage);

  final LocalStorageService _storage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
