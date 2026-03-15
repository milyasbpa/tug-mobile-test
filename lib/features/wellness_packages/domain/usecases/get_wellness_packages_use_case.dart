import 'package:flutter_starter_kit/core/errors/failures.dart';
import 'package:flutter_starter_kit/core/usecases/usecase.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/repositories/wellness_package_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

/// Fetches a paginated list of wellness packages from the remote source.
@injectable
class GetWellnessPackagesUseCase
    implements UseCase<PaginatedPackages, GetPackagesParams> {
  const GetWellnessPackagesUseCase(this._repository);

  final WellnessPackageRepository _repository;

  @override
  Future<Either<Failure, PaginatedPackages>> call(
    GetPackagesParams params,
  ) =>
      _repository.getPackages(params);
}
