part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {}

class LoadedJourneyState extends HomeState {
  final JourneyModel completedTrips;

  LoadedJourneyState({
    required this.completedTrips,
  });
}

final class ResetCacheSuccess extends HomeState {}
