import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

/// Abstract base class for all use cases in the domain layer.
///
/// [Output] — the data type returned on success.
/// [Params] — the input parameters required by the use case.
///
/// Usage example:
/// ```dart
/// class LoginUseCase implements UseCase<AuthUser, LoginParams> {
///   @override
///   Future<Either<Failure, AuthUser>> call(LoginParams params) =>
///       _repository.login(email: params.email, password: params.password);
/// }
/// ```
// UseCase intentionally has one abstract method — this is the Command pattern.
// ignore: one_member_abstracts
abstract interface class UseCase<Output, Params> {
  Future<Either<Failure, Output>> call(Params params);
}

/// Use [NoParams] for use cases that require no input.
///
/// Example: [LogoutUseCase], [CheckAuthUseCase]
final class NoParams {
  const NoParams();
}
