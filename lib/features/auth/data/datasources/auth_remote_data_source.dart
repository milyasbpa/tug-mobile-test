import 'package:flutter_starter_kit/features/auth/data/models/auth_response_model.dart';

/// Abstract contract for the auth remote data source.
abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> register({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> me();
}
