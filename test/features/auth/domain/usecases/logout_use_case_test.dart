import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockRepository;
  late LogoutUseCase sut;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = LogoutUseCase(mockRepository);
  });

  group('LogoutUseCase', () {
    test(
      'returns Right(unit) when repository.logout succeeds',
      () async {
        when(() => mockRepository.logout())
            .thenAnswer((_) async => const Right(unit));

        final result = await sut(const NoParams());

        expect(result, const Right<Failure, Unit>(unit));
        verify(() => mockRepository.logout()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'returns Left(CacheFailure) when clearing storage fails',
      () async {
        const failure = CacheFailure();
        when(() => mockRepository.logout())
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(const NoParams());

        expect(result, const Left<Failure, Unit>(failure));
      },
    );

    test('never calls login or checkAuth', () async {
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Right(unit));

      await sut(const NoParams());

      verifyNever(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      );
      verifyNever(() => mockRepository.checkAuth());
    });
  });
}
