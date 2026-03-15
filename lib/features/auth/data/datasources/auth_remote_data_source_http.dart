import 'package:flutter_starter_kit/core/network/dio_client.dart';
import 'package:flutter_starter_kit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_starter_kit/features/auth/data/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';

/// Real HTTP implementation of [AuthRemoteDataSource].
///
/// Used in [Environment.prod] and `staging`.
/// Calls the configured [DioClient] base URL (swap `.env.*` per environment).
@LazySingleton(as: AuthRemoteDataSource, env: ['staging', 'production'])
class AuthRemoteDataSourceHttp implements AuthRemoteDataSource {
  const AuthRemoteDataSourceHttp(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.dio.post<Map<String, dynamic>>(
      '/api/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<AuthResponseModel> register({
    required String email,
    required String password,
  }) async {
    final response = await _dioClient.dio.post<Map<String, dynamic>>(
      '/api/auth/register',
      data: {'email': email, 'password': password},
    );
    return AuthResponseModel.fromJson(response.data!);
  }

  @override
  Future<void> logout() async {
    await _dioClient.dio.post<void>('/api/auth/logout');
  }

  @override
  Future<void> me() async {
    await _dioClient.dio.get<void>('/api/auth/me');
  }
}
