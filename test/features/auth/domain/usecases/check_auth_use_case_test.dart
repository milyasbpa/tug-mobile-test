import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/check_auth_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/mocks/mock_auth_repository.dart';
import '../../../../helpers/test_helpers.dart';

void main() {
  late MockAuthRepository mockRepository;
  late CheckAuthUseCase sut;

  setUp(() {
    mockRepository = MockAuthRepository();
    sut = CheckAuthUseCase(mockRepository);
  });

  group('CheckAuthUseCase', () {
    test(
      'returns Right(AuthUser) when a valid token exists in storage',
      () async {
        when(() => mockRepository.checkAuth())
            .thenAnswer((_) async => const Right(tStoredAuthUser));

        final result = await sut(const NoParams());

        expect(result, const Right<Failure, AuthUser>(tStoredAuthUser));
        verify(() => mockRepository.checkAuth()).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'returns Left(UnauthorizedFailure) when no token is stored',
      () async {
        const failure = UnauthorizedFailure();
        when(() => mockRepository.checkAuth())
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(const NoParams());

        expect(result, const Left<Failure, AuthUser>(failure));
      },
    );

    test(
      'returns Left(CacheFailure) when reading from storage fails',
      () async {
        const failure = CacheFailure('Failed to read token');
        when(() => mockRepository.checkAuth())
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(const NoParams());

        expect(result, isA<Left<Failure, dynamic>>());
      },
    );
  });
}
