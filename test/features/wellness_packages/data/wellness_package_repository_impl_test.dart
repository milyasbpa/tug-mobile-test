import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/models/paginated_packages_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/repositories/wellness_package_repository_impl.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/wellness_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/mocks/mock_wellness_package_remote_data_source.dart';

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

final _tModel = PaginatedPackagesModel(
  packages: [_tPackage],
  total: 1,
  page: 1,
  limit: 10,
  totalPages: 1,
);

const _tParams = GetPackagesParams();

// ── Tests ─────────────────────────────────────────────────────────────────────

void main() {
  late MockWellnessPackageRemoteDataSource mockDataSource;
  late WellnessPackageRepositoryImpl sut;

  setUpAll(() {
    registerFallbackValue(const GetPackagesParams());
  });

  setUp(() {
    mockDataSource = MockWellnessPackageRemoteDataSource();
    sut = WellnessPackageRepositoryImpl(mockDataSource);
  });

  group('WellnessPackageRepositoryImpl.getPackages', () {
    test(
      'returns Right(PaginatedPackages) when datasource succeeds',
      () async {
        when(() => mockDataSource.getPackages(any()))
            .thenAnswer((_) async => _tModel);

        final result = await sut.getPackages(_tParams);

        expect(result, Right<Failure, PaginatedPackages>(_tModel));
        verify(() => mockDataSource.getPackages(_tParams)).called(1);
        verifyNoMoreInteractions(mockDataSource);
      },
    );

    test(
      'returns Left(ServerFailure) when datasource throws ServerException',
      () async {
        const exception = ServerException(message: 'Internal server error');
        when(() => mockDataSource.getPackages(any())).thenThrow(exception);

        final result = await sut.getPackages(_tParams);

        expect(
          result,
          const Left<Failure, PaginatedPackages>(
            ServerFailure('Internal server error'),
          ),
        );
      },
    );

    test(
      'returns Left(NetworkFailure) when datasource throws NetworkException',
      () async {
        const exception = NetworkException();
        when(() => mockDataSource.getPackages(any())).thenThrow(exception);

        final result = await sut.getPackages(_tParams);

        expect(
          result,
          const Left<Failure, PaginatedPackages>(
            NetworkFailure('No internet connection.'),
          ),
        );
      },
    );

    test(
      'returns Left(UnauthorizedFailure) when datasource throws '
      'UnauthorizedException',
      () async {
        const exception = UnauthorizedException('Token expired.');
        when(() => mockDataSource.getPackages(any())).thenThrow(exception);

        final result = await sut.getPackages(_tParams);

        expect(
          result,
          const Left<Failure, PaginatedPackages>(
            UnauthorizedFailure('Token expired.'),
          ),
        );
      },
    );

    test(
      'returns Left(UnauthorizedFailure) when DioException has status 401',
      () async {
        final requestOptions = RequestOptions(path: '/api/mobile/packages');
        final dioException = DioException(
          requestOptions: requestOptions,
          response: Response<void>(
            statusCode: 401,
            requestOptions: requestOptions,
          ),
        );
        when(() => mockDataSource.getPackages(any())).thenThrow(dioException);

        final result = await sut.getPackages(_tParams);

        expect(
          result,
          const Left<Failure, PaginatedPackages>(UnauthorizedFailure()),
        );
      },
    );

    test(
      'returns Left(ServerFailure) when DioException has non-401 status code',
      () async {
        final requestOptions = RequestOptions(path: '/api/mobile/packages');
        final dioException = DioException(
          requestOptions: requestOptions,
          response: Response<void>(
            statusCode: 500,
            requestOptions: requestOptions,
          ),
        );
        when(() => mockDataSource.getPackages(any())).thenThrow(dioException);

        final result = await sut.getPackages(_tParams);

        expect(
          result,
          const Left<Failure, PaginatedPackages>(
            ServerFailure.withCode(500),
          ),
        );
      },
    );
  });
}
