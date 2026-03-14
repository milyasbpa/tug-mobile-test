import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/storage/local_storage_service.dart';
import 'package:injectable/injectable.dart';

/// Injects the Bearer token into every outgoing request.
///
/// Reads the access token from [LocalStorageService] (secure storage).
/// If no token is present the request is forwarded unmodified — public
/// endpoints and the login endpoint do not require authorisation.
///
// TODO(step-10): Handle 401 by triggering silent token-refresh / logout.
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
