import 'package:equatable/equatable.dart';

/// Input parameters for [GetWellnessPackagesUseCase].
///
/// Maps directly to the query parameters accepted by `GET /api/mobile/packages`.
final class GetPackagesParams extends Equatable {
  const GetPackagesParams({
    this.page = 1,
    this.limit = 10,
    this.search,
    this.sortBy = 'createdAt',
    this.sortOrder = 'desc',
  });

  /// Page number to fetch (1-based). Defaults to `1`.
  final int page;

  /// Number of items per page. Max `100`. Defaults to `10`.
  final int limit;

  /// Optional search query to filter packages by name or description.
  final String? search;

  /// Field to sort by. One of: `name`, `price`, `durationMinutes`, `createdAt`.
  final String sortBy;

  /// Sort direction. Either `asc` or `desc`. Defaults to `desc`.
  final String sortOrder;

  @override
  List<Object?> get props => [page, limit, search, sortBy, sortOrder];
}
