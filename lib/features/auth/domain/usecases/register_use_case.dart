import 'package:equatable/equatable.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Creates a new user account and persists the returned session token.
@injectable
class RegisterUseCase implements UseCase<AuthUser, RegisterParams> {
  const RegisterUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthUser>> call(RegisterParams params) =>
      _repository.register(
        email: params.email,
        password: params.password,
      );
}

/// Input parameters for [RegisterUseCase].
final class RegisterParams extends Equatable {
  const RegisterParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
