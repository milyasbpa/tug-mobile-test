import 'package:equatable/equatable.dart';

/// Input parameters for [GetWellnessPackagesUseCase].
final class GetPackagesParams extends Equatable {
  const GetPackagesParams({
    this.page = 1,
    this.limit = 10,
    this.search,
    this.sortBy = 'createdAt',
    this.sortOrder = 'desc',
  });

  final int page;

  final int limit;

  final String? search;

  final String sortBy;

  final String sortOrder;

  @override
  List<Object?> get props => [page, limit, search, sortBy, sortOrder];
}
