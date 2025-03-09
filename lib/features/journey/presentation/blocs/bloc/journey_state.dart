part of 'journey_bloc.dart';

@immutable
sealed class JourneyState {}

final class JourneyInitial extends JourneyState {}

final class JourneyLoading extends JourneyState {}

final class JourneyError extends JourneyState {}

final class JourneyAdded extends JourneyState {}
