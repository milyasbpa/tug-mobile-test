import 'package:flutter_starter_kit/core/network/dio_client.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/datasources/wellness_package_remote_data_source.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/models/paginated_packages_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:injectable/injectable.dart';

/// Real HTTP implementation of [WellnessPackageRemoteDataSource].
///
/// Used in `staging` and `production` environments.
/// Calls `GET /api/mobile/packages` via the configured [DioClient].
@LazySingleton(as: WellnessPackageRemoteDataSource, env: ['staging', 'production'])
class WellnessPackageRemoteDataSourceHttp
    implements WellnessPackageRemoteDataSource {
  const WellnessPackageRemoteDataSourceHttp(this._dioClient);

  final DioClient _dioClient;

  @override
  Future<PaginatedPackagesModel> getPackages(GetPackagesParams params) async {
    final response = await _dioClient.dio.get<Map<String, dynamic>>(
      '/api/v1/mobile/packages',
      queryParameters: {
        'page': params.page,
        'limit': params.limit,
        if (params.search != null) 'search': params.search,
        'sortBy': params.sortBy,
        'sortOrder': params.sortOrder,
      },
    );
    return PaginatedPackagesModel.fromJson(response.data!);
  }
}
