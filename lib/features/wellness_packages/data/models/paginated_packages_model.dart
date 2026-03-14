import 'package:flutter_starter_kit/features/wellness_packages/data/models/wellness_package_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/paginated_packages.dart';

/// DTO that maps the full paginated JSON response from
/// `GET /api/mobile/packages` to a Dart object.
///
/// Response envelope structure:
/// ```json
/// {
///   "success": true,
///   "timestamp": "...",
///   "data": {
///     "data": [ ...items ],
///     "meta": { "total": 100, "page": 1, "limit": 10, "totalPages": 10 }
///   }
/// }
/// ```
class PaginatedPackagesModel extends PaginatedPackages {
  const PaginatedPackagesModel({
    required super.packages,
    required super.total,
    required super.page,
    required super.limit,
    required super.totalPages,
  });

  factory PaginatedPackagesModel.fromJson(Map<String, dynamic> json) {
    final payload = json['data'] as Map<String, dynamic>;
    final meta = payload['meta'] as Map<String, dynamic>;
    final items = (payload['data'] as List<dynamic>)
        .map((e) => WellnessPackageModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return PaginatedPackagesModel(
      packages: items,
      total: (meta['total'] as num).toInt(),
      page: (meta['page'] as num).toInt(),
      limit: (meta['limit'] as num).toInt(),
      totalPages: (meta['totalPages'] as num).toInt(),
    );
  }
}
