import 'package:flutter_starter_kit/features/wellness_packages/data/models/paginated_packages_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';

/// Abstract contract for the wellness packages remote data source.
// ignore: one_member_abstracts
abstract class WellnessPackageRemoteDataSource {
  Future<PaginatedPackagesModel> getPackages(GetPackagesParams params);
}
