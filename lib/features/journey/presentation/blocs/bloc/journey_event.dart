part of 'journey_bloc.dart';

@immutable
sealed class JourneyEvent {}

class CreateNewJourneyEvent extends JourneyEvent {
  final bool simulateErrorScenario;
  CreateNewJourneyEvent({required this.simulateErrorScenario,});
}
