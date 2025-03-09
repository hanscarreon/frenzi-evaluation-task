part of 'journey_bloc.dart';

@immutable
sealed class JourneyEvent {}

class CreateNewJourneyEvent extends JourneyEvent {
  final bool simulateErrorScenario;
  final JourneyDetailModel journey;
  CreateNewJourneyEvent({
    required this.simulateErrorScenario,
    required this.journey,
  });
}
