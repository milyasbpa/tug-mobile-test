import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_starter_kit/features/auth/data/models/auth_response_model.dart';
import 'package:injectable/injectable.dart';

/// Mock implementation of [AuthRemoteDataSource] for the **dev** environment.
///
/// Simulates network latency and returns fixture data so the auth flow can be
/// tested without a real backend or internet connection.
///
/// Accepted credentials (login):
///   email: any valid-looking email  |  password: any non-empty string
///
/// Rejected credentials (triggers [UnauthorizedException]):
///   password: "wrong" (literal string — useful for testing error state)
@LazySingleton(as: AuthRemoteDataSource, env: ['dev'])
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  const AuthRemoteDataSourceMock();

  static const _fakeToken = 'dev-mock-token-QpwL5tpe83iIkJO';
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

    return AuthResponseModel(token: _fakeToken, email: email);
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

    return AuthResponseModel(id: 99, token: _fakeToken, email: email);
  }
}
