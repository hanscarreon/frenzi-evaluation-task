import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';

abstract class JourneyRepository {
  Future<JourneyModel> loadCompletedJourneys();
  Future<JourneyDetailModel> createNewJourney({
    required bool simulateErrorScenario,
    required JourneyDetailModel journey,
  });
}
