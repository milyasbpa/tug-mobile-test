import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/usecases/get_wellness_packages_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks/mock_wellness_package_repository.dart';

// ── Fixtures ──────────────────────────────────────────────────────────────────

final _tPackage = WellnessPackage(
  id: 'pkg-001',
  name: 'Swedish Massage',
  description: 'A relaxing full-body massage.',
  price: 150000,
  durationMinutes: 60,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

final _tPaginatedPackages = PaginatedPackages(
  packages: [_tPackage],
  total: 1,
  page: 1,
  limit: 10,
  totalPages: 1,
);

const _tParams = GetPackagesParams();

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockWellnessPackageRepository mockRepository;
  late GetWellnessPackagesUseCase sut;

  setUpAll(() {
    registerFallbackValue(const GetPackagesParams());
  });

  setUp(() {
    mockRepository = MockWellnessPackageRepository();
    sut = GetWellnessPackagesUseCase(mockRepository);
  });

  group('GetWellnessPackagesUseCase', () {
    test(
      'returns Right(PaginatedPackages) when repository.getPackages succeeds',
      () async {
        when(() => mockRepository.getPackages(any()))
            .thenAnswer((_) async => Right(_tPaginatedPackages));

        final result = await sut(_tParams);

        expect(result, Right<Failure, PaginatedPackages>(_tPaginatedPackages));
        verify(() => mockRepository.getPackages(_tParams)).called(1);
        verifyNoMoreInteractions(mockRepository);
      },
    );

    test(
      'returns Left(NetworkFailure) when repository.getPackages fails with '
      'network error',
      () async {
        const failure = NetworkFailure();
        when(() => mockRepository.getPackages(any()))
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(_tParams);

        expect(result, const Left<Failure, PaginatedPackages>(failure));
      },
    );

    test(
      'returns Left(ServerFailure) when repository.getPackages fails with '
      'server error',
      () async {
        const failure = ServerFailure('Internal server error');
        when(() => mockRepository.getPackages(any()))
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(_tParams);

        expect(result, const Left<Failure, PaginatedPackages>(failure));
      },
    );

    test(
      'returns Left(UnauthorizedFailure) when repository.getPackages fails '
      'with 401',
      () async {
        const failure = UnauthorizedFailure();
        when(() => mockRepository.getPackages(any()))
            .thenAnswer((_) async => const Left(failure));

        final result = await sut(_tParams);

        expect(result, const Left<Failure, PaginatedPackages>(failure));
      },
    );

    test(
      'forwards search param to repository',
      () async {
        const params = GetPackagesParams(search: 'massage');
        when(() => mockRepository.getPackages(params))
            .thenAnswer((_) async => Right(_tPaginatedPackages));

        await sut(params);

        verify(() => mockRepository.getPackages(params)).called(1);
      },
    );
  });
}
