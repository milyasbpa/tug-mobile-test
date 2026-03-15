import 'package:flutter_starter_kit/features/wellness_packages/data/datasources/wellness_package_remote_data_source.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/models/paginated_packages_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/data/models/wellness_package_model.dart';
import 'package:flutter_starter_kit/features/wellness_packages/domain/entities/get_packages_params.dart';
import 'package:injectable/injectable.dart';

/// Mock implementation of [WellnessPackageRemoteDataSource] for the **dev**
/// environment.
@LazySingleton(as: WellnessPackageRemoteDataSource, env: ['dev'])
class WellnessPackageRemoteDataSourceMock
    implements WellnessPackageRemoteDataSource {
  const WellnessPackageRemoteDataSourceMock();

  static const _fakeDelay = Duration(milliseconds: 800);

  static final _fixtures = [
    WellnessPackageModel(
      id: 'mock-uuid-0001',
      name: 'Deep Tissue Massage',
      description:
          'A therapeutic massage targeting deep muscle layers to relieve chronic tension and pain.',
      price: 150000,
      durationMinutes: 60,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
    WellnessPackageModel(
      id: 'mock-uuid-0002',
      name: 'Aromatherapy Session',
      description:
          'A relaxing full-body massage using essential oils to soothe the mind and body.',
      price: 120000,
      durationMinutes: 45,
      createdAt: DateTime(2026, 2),
      updatedAt: DateTime(2026, 2),
    ),
    WellnessPackageModel(
      id: 'mock-uuid-0003',
      name: 'Hot Stone Therapy',
      description:
          'Smooth heated stones are placed on key body points to ease muscle stiffness.',
      price: 200000,
      durationMinutes: 90,
      createdAt: DateTime(2026, 3),
      updatedAt: DateTime(2026, 3),
    ),
    WellnessPackageModel(
      id: 'mock-uuid-0004',
      name: 'Reflexology',
      description:
          'Pressure applied to specific points on the feet to promote overall wellness.',
      price: 90000,
      durationMinutes: 30,
      createdAt: DateTime(2026, 4),
      updatedAt: DateTime(2026, 4),
    ),
    WellnessPackageModel(
      id: 'mock-uuid-0005',
      name: 'Swedish Massage',
      description:
          'A gentle full-body massage designed to relax the entire body using long strokes.',
      price: 130000,
      durationMinutes: 60,
      createdAt: DateTime(2026, 5),
      updatedAt: DateTime(2026, 5),
    ),
  ];

  @override
  Future<PaginatedPackagesModel> getPackages(GetPackagesParams params) async {
    await Future<void>.delayed(_fakeDelay);

    // Simple client-side pagination on the fixture list.
    final start = (params.page - 1) * params.limit;
    final end = (start + params.limit).clamp(0, _fixtures.length);
    final items =
        start >= _fixtures.length ? <WellnessPackageModel>[] : _fixtures.sublist(start, end);
    final totalPages = (_fixtures.length / params.limit).ceil();

    return PaginatedPackagesModel(
      packages: items,
      total: _fixtures.length,
      page: params.page,
      limit: params.limit,
      totalPages: totalPages,
    );
  }
}
