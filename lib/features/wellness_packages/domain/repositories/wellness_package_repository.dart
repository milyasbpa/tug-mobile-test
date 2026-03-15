import 'package:flutter_starter_kit/core/network/api_result.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';

/// Contract for wellness package data operations.
// WellnessPackageRepository intentionally has one method — Repository pattern.
// ignore: one_member_abstracts
abstract interface class WellnessPackageRepository {
  ApiResult<PaginatedPackages> getPackages(GetPackagesParams params);
}
