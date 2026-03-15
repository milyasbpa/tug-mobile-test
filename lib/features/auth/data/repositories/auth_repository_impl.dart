import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/storage/local_storage_service.dart';
import 'package:flutter_starter_kit/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

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
      final user = AuthUser(email: email, token: model.accessToken);
      await _localStorage.saveAccessToken(model.accessToken);
      await _localStorage.saveRefreshToken(model.refreshToken);
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
      final user = AuthUser(email: email, token: model.accessToken);
      await _localStorage.saveAccessToken(model.accessToken);
      await _localStorage.saveRefreshToken(model.refreshToken);
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
      await _remoteDataSource.logout();
    } on DioException catch (_) {
      // Best-effort: clear local session even if server call fails.
    } on ServerException catch (_) {
      // Best-effort.
    }
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
      // Verify token is still valid against GET /api/auth/me.
      await _remoteDataSource.me();
      return Right(AuthUser(email: '', token: token));
    } on DioException catch (e) {
      return Left(_failureFromDio(e));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

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
