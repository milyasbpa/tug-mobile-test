import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/usecases/get_wellness_packages_use_case.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_bloc.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_event.dart';
import 'package:flutter_starter_kit/features/wellness_packages/presentation/blocs/wellness_packages_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

// ── Mock ──────────────────────────────────────────────────────────────────────

class _MockGetWellnessPackagesUseCase extends Mock
    implements GetWellnessPackagesUseCase {}

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

final _tPackagePage2 = WellnessPackage(
  id: 'pkg-002',
  name: 'Deep Tissue Massage',
  description: 'Targets deep muscle layers.',
  price: 200000,
  durationMinutes: 90,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

/// Page 1 of 2 — `hasNextPage` is `true`.
final _tPage1 = PaginatedPackages(
  packages: [_tPackage],
  total: 2,
  page: 1,
  limit: 10,
  totalPages: 2,
);

/// Page 2 of 2 — `hasNextPage` is `false`.
final _tPage2 = PaginatedPackages(
  packages: [_tPackagePage2],
  total: 2,
  page: 2,
  limit: 10,
  totalPages: 2,
);

/// Single-page result for simple success scenarios.
final _tSinglePage = PaginatedPackages(
  packages: [_tPackage],
  total: 1,
  page: 1,
  limit: 10,
  totalPages: 1,
);

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late _MockGetWellnessPackagesUseCase mockUseCase;

  setUpAll(() {
    registerFallbackValue(const GetPackagesParams());
  });

  setUp(() {
    mockUseCase = _MockGetWellnessPackagesUseCase();
  });

  WellnessPackagesBloc buildBloc() => WellnessPackagesBloc(mockUseCase);

  // ── WellnessPackagesLoadRequested ─────────────────────────────────────────

  group('WellnessPackagesLoadRequested', () {
    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'emits [Loading, Loaded] on successful load',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any()))
          .thenAnswer((_) async => Right(_tSinglePage)),
      act: (bloc) => bloc.add(const WellnessPackagesLoadRequested()),
      expect: () => [
        const WellnessPackagesLoading(),
        WellnessPackagesLoaded(
          packages: _tSinglePage.packages,
          paginatedData: _tSinglePage,
        ),
      ],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'emits [Loading, Error] when use case returns NetworkFailure',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Left(NetworkFailure())),
      act: (bloc) => bloc.add(const WellnessPackagesLoadRequested()),
      expect: () => [
        const WellnessPackagesLoading(),
        const WellnessPackagesError(message: 'Network error occurred.'),
      ],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'emits [Loading, Error] when use case returns ServerFailure',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any())).thenAnswer(
        (_) async => const Left(ServerFailure('Service unavailable')),
      ),
      act: (bloc) => bloc.add(const WellnessPackagesLoadRequested()),
      expect: () => [
        const WellnessPackagesLoading(),
        const WellnessPackagesError(message: 'Service unavailable'),
      ],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'emits [Loading, Error] when use case returns UnauthorizedFailure',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any()))
          .thenAnswer((_) async => const Left(UnauthorizedFailure())),
      act: (bloc) => bloc.add(const WellnessPackagesLoadRequested()),
      expect: () => [
        const WellnessPackagesLoading(),
        const WellnessPackagesError(
          message: 'Unauthorized. Please login again.',
        ),
      ],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'passes search param to use case',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any()))
          .thenAnswer((_) async => Right(_tSinglePage)),
      act: (bloc) =>
          bloc.add(const WellnessPackagesLoadRequested(search: 'massage')),
      verify: (_) => verify(
        () => mockUseCase(
          const GetPackagesParams(search: 'massage'),
        ),
      ).called(1),
    );
  });

  // ── WellnessPackagesLoadMoreRequested ─────────────────────────────────────

  group('WellnessPackagesLoadMoreRequested', () {
    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'appends packages from next page to the existing list',
      build: buildBloc,
      setUp: () {
        // First call returns page 1 (hasNextPage = true).
        // Second call returns page 2.
        var callCount = 0;
        when(() => mockUseCase(any())).thenAnswer((_) async {
          callCount++;
          return callCount == 1 ? Right(_tPage1) : Right(_tPage2);
        });
      },
      act: (bloc) async {
        bloc.add(const WellnessPackagesLoadRequested());
        // Wait for the first load to complete before requesting more.
        await Future<void>.delayed(Duration.zero);
        bloc.add(const WellnessPackagesLoadMoreRequested());
      },
      expect: () => [
        // Initial load
        const WellnessPackagesLoading(),
        WellnessPackagesLoaded(
          packages: _tPage1.packages,
          paginatedData: _tPage1,
        ),
        // Load more in progress
        WellnessPackagesLoaded(
          packages: _tPage1.packages,
          paginatedData: _tPage1,
          isLoadingMore: true,
        ),
        // Load more complete — packages accumulated
        WellnessPackagesLoaded(
          packages: [..._tPage1.packages, ..._tPage2.packages],
          paginatedData: _tPage2,
        ),
      ],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'does nothing when current state is not Loaded',
      build: buildBloc,
      act: (bloc) => bloc.add(const WellnessPackagesLoadMoreRequested()),
      expect: () => <WellnessPackagesState>[],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'does nothing when there are no more pages (hasNextPage = false)',
      build: buildBloc,
      setUp: () => when(() => mockUseCase(any()))
          .thenAnswer((_) async => Right(_tSinglePage)),
      seed: () => WellnessPackagesLoaded(
        packages: _tSinglePage.packages,
        paginatedData: _tSinglePage, // page 1 of 1 → hasNextPage = false
      ),
      act: (bloc) => bloc.add(const WellnessPackagesLoadMoreRequested()),
      expect: () => <WellnessPackagesState>[],
    );

    blocTest<WellnessPackagesBloc, WellnessPackagesState>(
      'emits Error when load-more use case call fails',
      build: buildBloc,
      setUp: () {
        var callCount = 0;
        when(() => mockUseCase(any())).thenAnswer((_) async {
          callCount++;
          return callCount == 1
              ? Right(_tPage1)
              : const Left(NetworkFailure());
        });
      },
      act: (bloc) async {
        bloc.add(const WellnessPackagesLoadRequested());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const WellnessPackagesLoadMoreRequested());
      },
      expect: () => [
        const WellnessPackagesLoading(),
        WellnessPackagesLoaded(
          packages: _tPage1.packages,
          paginatedData: _tPage1,
        ),
        WellnessPackagesLoaded(
          packages: _tPage1.packages,
          paginatedData: _tPage1,
          isLoadingMore: true,
        ),
        const WellnessPackagesError(message: 'Network error occurred.'),
      ],
    );
  });
}
