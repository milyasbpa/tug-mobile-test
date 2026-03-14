import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Convenience typedef for async operations that can fail.
///
/// All repository methods and use cases return [ApiResult] so the
/// caller always gets either a [Failure] or a value of type [T].
///
/// Usage:
/// ```dart
/// ApiResult<User> login(String email, String password);
/// ```
typedef ApiResult<T> = Future<Either<Failure, T>>;
