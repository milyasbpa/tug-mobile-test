import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_starter_kit/features/auth/data/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';

/// Mock implementation of [AuthRemoteDataSource] for the **dev** environment.
@LazySingleton(as: AuthRemoteDataSource, env: ['test'])
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  const AuthRemoteDataSourceMock();

  static const _fakeAccessToken = 'dev-mock-access-token-QpwL5tpe83iIkJO';
  static const _fakeRefreshToken = 'dev-mock-refresh-token-abcdef123456';
  static const _fakeDelay = Duration(milliseconds: 800);

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_fakeDelay);

    if (password == 'wrong') {
      throw const UnauthorizedException(
        'Invalid credentials. (Mock: use any email + any password except "wrong")',
      );
    }
    if (email.isEmpty || password.isEmpty) {
      throw const UnauthorizedException('Email and password are required.');
    }

    return AuthResponseModel(
      accessToken: _fakeAccessToken,
      refreshToken: _fakeRefreshToken,
      email: email,
    );
  }

  @override
  Future<AuthResponseModel> register({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(_fakeDelay);

    if (email.isEmpty || password.isEmpty) {
      throw const UnauthorizedException('Email and password are required.');
    }

    return AuthResponseModel(
      accessToken: _fakeAccessToken,
      refreshToken: _fakeRefreshToken,
      email: email,
    );
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(_fakeDelay);
  }

  @override
  Future<void> me() async {
    await Future<void>.delayed(_fakeDelay);
    // Mock: always succeeds — token considered valid in dev.
  }
}
