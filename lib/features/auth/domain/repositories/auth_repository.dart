import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:fpdart/fpdart.dart';

/// Contract for authentication operations.
///
/// All concrete implementations live in the data layer
/// ([AuthRepositoryImpl]) and should never leak into domain or presentation.
abstract class AuthRepository {
  /// Authenticates the user with [email] and [password].
  ///
  /// Persists the returned token to secure storage on success.
  Future<Either<Failure, AuthUser>> login({
    required String email,
    required String password,
  });

  /// Creates a new account with [email] and [password].
  ///
  /// Persists the returned token to secure storage on success.
  Future<Either<Failure, AuthUser>> register({
    required String email,
    required String password,
  });

  /// Clears all stored tokens and session data.
  Future<Either<Failure, Unit>> logout();

  /// Checks whether a valid token is present in local storage.
  ///
  /// Returns [AuthUser] if a token is found, or [UnauthorizedFailure]
  /// if the user needs to log in.
  Future<Either<Failure, AuthUser>> checkAuth();
}
