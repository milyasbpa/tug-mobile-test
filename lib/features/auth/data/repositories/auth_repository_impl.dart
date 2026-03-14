import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/storage/local_storage_service.dart';
import 'package:flutter_starter_kit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Concrete implementation of [AuthRepository].
///
/// Bridges the data layer ([AuthRemoteDataSource], [LocalStorageService])
/// with the domain layer by converting raw exceptions into typed [Failure]s.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._remoteDataSource,
    this._localStorage,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final LocalStorageService _localStorage;

  @override
  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      final user = AuthUser(id: model.id, email: email, token: model.token);
      await _localStorage.saveAccessToken(model.token);
      return Right(user);
    } on DioException catch (e) {
      return Left(_failureFromDio(e));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String password,
  }) async {
    try {
      final model = await _remoteDataSource.register(
        email: email,
        password: password,
      );
      final user = AuthUser(id: model.id, email: email, token: model.token);
      await _localStorage.saveAccessToken(model.token);
      return Right(user);
    } on DioException catch (e) {
      return Left(_failureFromDio(e));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _localStorage.clearAll();
      return const Right(unit);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> checkAuth() async {
    try {
      final token = await _localStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        return const Left(UnauthorizedFailure('No active session found.'));
      }
      // reqres.in has no /me endpoint, so a stored token means authenticated.
      // Replace with a token-verification call when using a real backend.
      return Right(AuthUser(email: '', token: token));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  /// Unwraps the typed [AppException] embedded by [ErrorInterceptor] inside
  /// [DioException.error] and converts it to a [Failure].
  Failure _failureFromDio(DioException e) {
    final inner = e.error;
    if (inner is UnauthorizedException) {
      return UnauthorizedFailure(inner.message);
    }
    if (inner is NetworkException) {
      return NetworkFailure(inner.message);
    }
    if (inner is ServerException) {
      return ServerFailure(inner.message);
    }
    return ServerFailure(e.message ?? 'Unexpected network error.');
  }
}
