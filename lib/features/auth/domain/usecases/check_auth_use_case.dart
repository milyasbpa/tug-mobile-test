import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Checks whether a valid session already exists in local storage.
///
/// Returns [AuthUser] if a token is found so the app can skip the login
/// screen on subsequent launches. Returns [UnauthorizedFailure] when no
/// token is present, directing the router to the login page.
@injectable
class CheckAuthUseCase implements UseCase<AuthUser, NoParams> {
  const CheckAuthUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthUser>> call(NoParams params) =>
      _repository.checkAuth();
}
