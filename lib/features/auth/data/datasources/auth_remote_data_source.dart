import 'package:flutter_starter_kit/features/auth/data/models/auth_response_model.dart';

/// Abstract contract for the auth remote data source.
///
/// Implementations:
/// - [AuthRemoteDataSourceHttp] — real HTTP calls (staging / production)
/// - [AuthRemoteDataSourceMock] — hard-coded fixture data (dev / test)
abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String email,
    required String password,
  });

  /// Revokes the session server-side (`POST /api/auth/logout`).
  Future<void> logout();

  /// Verifies the access token against `GET /api/auth/me`.
  /// Throws [UnauthorizedException] if the token is invalid or expired.
  Future<void> me();
}
