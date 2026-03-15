import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/errors/exceptions.dart';
import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/network/api_result.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/datasources/wellness_package_remote_data_source.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/repositories/wellness_package_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WellnessPackageRepository)
class WellnessPackageRepositoryImpl implements WellnessPackageRepository {
  const WellnessPackageRepositoryImpl(this._remoteDataSource);

  final WellnessPackageRemoteDataSource _remoteDataSource;

  @override
  ApiResult<PaginatedPackages> getPackages(GetPackagesParams params) async {
    try {
      final model = await _remoteDataSource.getPackages(params);
      return Right(model);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      if (statusCode == 401) {
        return const Left(UnauthorizedFailure());
      }
      return Left(ServerFailure.withCode(statusCode ?? 0));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
