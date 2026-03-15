import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:fpdart/fpdart.dart';

/// Contract for authentication operations.
abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String password,
  });

  /// Clears all stored tokens and session data.
  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, AuthUser>> checkAuth();
}
