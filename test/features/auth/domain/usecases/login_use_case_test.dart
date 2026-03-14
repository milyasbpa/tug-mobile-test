import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks/mock_auth_repository.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late MockAuthRepository mockRepository;
  late LoginUseCase sut;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = LoginUseCase(mockRepository);
  });

  group('LoginUseCase', () {
    const params = LoginParams(email: tEmail, password: tPassword);

    test(
      'returns Right(AuthUser) when repository.login succeeds',
      () async {
        when(
          () => mockRepository.login(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Right(tAuthUser));

        final result = await sut(params);

        expect(result, const Right<Failure, AuthUser>(tAuthUser));
        verify(() => mockRepository.login(email: tEmail, password: tPassword))
            .called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'returns Left(NetworkFailure) when repository.login fails with network error',
      () async {
        const failure = NetworkFailure();
        when(
          () => mockRepository.login(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Left(failure));

        final result = await sut(params);

        expect(result, const Left<Failure, AuthUser>(failure));
      },
    );

    test(
      'returns Left(ServerFailure) when repository.login fails with server error',
      () async {
        const failure = ServerFailure('Invalid credentials');
        when(
          () => mockRepository.login(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Left(failure));

        final result = await sut(params);

        expect(result, const Left<Failure, AuthUser>(failure));
      },
    );

    test('calls repository exactly once with correct params', () async {
      when(
        () => mockRepository.login(email: tEmail, password: tPassword),
      ).thenAnswer((_) async => const Right(tAuthUser));

      await sut(params);

      verify(() => mockRepository.login(email: tEmail, password: tPassword))
          .called(1);
    });
  });
}
