import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks/mock_auth_repository.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late MockAuthRepository mockRepository;
  late RegisterUseCase sut;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = RegisterUseCase(mockRepository);
  });

  group('RegisterUseCase', () {
    const params = RegisterParams(email: tEmail, password: tPassword);

    test(
      'returns Right(AuthUser) when repository.register succeeds',
      () async {
        when(
          () => mockRepository.register(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Right(tAuthUser));

        final result = await sut(params);

        expect(result, const Right<Failure, AuthUser>(tAuthUser));
        verify(
          () => mockRepository.register(email: tEmail, password: tPassword),
        ).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'returns Left(ServerFailure) when email is already in use',
      () async {
        const failure =
            ServerFailure('Note: Only defined users succeed registration');
        when(
          () => mockRepository.register(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Left(failure));

        final result = await sut(params);

        expect(result, const Left<Failure, AuthUser>(failure));
      },
    );

    test(
      'returns Left(NetworkFailure) when network is unavailable',
      () async {
        const failure = NetworkFailure();
        when(
          () => mockRepository.register(email: tEmail, password: tPassword),
        ).thenAnswer((_) async => const Left(failure));

        final result = await sut(params);

        expect(result, isA<Left<Failure, dynamic>>());
      },
    );
  });
}
