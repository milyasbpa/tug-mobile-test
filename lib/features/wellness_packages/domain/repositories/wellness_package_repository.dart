import 'package:flutter_starter_kit/core/network/api_result.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';

/// Contract for wellness package data operations.
///
/// All concrete implementations live in the data layer
/// ([WellnessPackageRepositoryImpl]) and should never leak into domain
/// or presentation.
// WellnessPackageRepository intentionally has one method — Repository pattern.
// ignore: one_member_abstracts
abstract interface class WellnessPackageRepository {
  /// Fetches a paginated list of wellness packages.
  ///
  /// Returns a [PaginatedPackages] on success, or a [Failure] on error.
  ApiResult<PaginatedPackages> getPackages(GetPackagesParams params);
}
