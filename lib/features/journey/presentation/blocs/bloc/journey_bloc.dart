import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzi_app/features/journey/data/journey_repository.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';

part 'journey_event.dart';
part 'journey_state.dart';

class JourneyBloc extends Bloc<JourneyEvent, JourneyState> {
  JourneyBloc({
    required this.journeyRepository,
  }) : super(JourneyInitial()) {
    on<CreateNewJourneyEvent>(_onCreateNewJourneyEvent);
  }

  final JourneyRepository journeyRepository;

  FutureOr<void> _onCreateNewJourneyEvent(
    CreateNewJourneyEvent event,
    Emitter<JourneyState> emit,
  ) async {
    try {
      emit(JourneyLoading());

      await Future.delayed(
        const Duration(seconds: 1),
      );

      final response = await journeyRepository.createNewJourney(
        simulateErrorScenario: event.simulateErrorScenario,
        journey: event.journey,
      );

      response.id > 0 ? emit(JourneyAdded()) : emit(JourneyError());
    } catch (e) {
      emit(JourneyError());
    }
  }
}
