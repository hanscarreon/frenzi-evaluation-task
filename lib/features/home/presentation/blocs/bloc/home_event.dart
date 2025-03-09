part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class LoadCompletedJourneysEvent extends HomeEvent {}

class ResetCacheEvent extends HomeEvent {}
