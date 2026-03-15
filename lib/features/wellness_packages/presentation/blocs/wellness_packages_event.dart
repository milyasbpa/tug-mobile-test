import 'package:equatable/equatable.dart';

/// Base class for all events dispatched to [WellnessPackagesBloc].
sealed class WellnessPackagesEvent extends Equatable {
  const WellnessPackagesEvent();

  @override
  List<Object?> get props => [];
}

/// Load the first page of packages, optionally filtered by [search].
///
/// Also used to refresh the list from scratch.
final class WellnessPackagesLoadRequested extends WellnessPackagesEvent {
  const WellnessPackagesLoadRequested({this.search});

  final String? search;

  @override
  List<Object?> get props => [search];
}

/// Load the next page of packages and append to the existing list.
///
/// Ignored if the current state is not [WellnessPackagesLoaded] or
/// there are no more pages to fetch.
final class WellnessPackagesLoadMoreRequested extends WellnessPackagesEvent {
  const WellnessPackagesLoadMoreRequested();
}
