import 'dart:convert';

import 'package:frenzi_app/core/constants/app_constants.dart';
import 'package:frenzi_app/core/fixtures/fixture_reader.dart';
import 'package:frenzi_app/features/journey/data/journey_repository.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JourneyRepositoryImpl extends JourneyRepository {
  @override
  Future<JourneyModel> loadCompletedJourneys() async {
    try {
      final jsonResponse = await FixtureReader.loadJsonFromAssets(
          name: 'completed_trip_list.json');

      return JourneyModel.fromJson(jsonResponse);
    } catch (e) {
      return JourneyModel.empty();
    }
  }

  @override
  Future<JourneyDetailModel> createNewJourney({
    required bool simulateErrorScenario,
    required JourneyDetailModel journey,
  }) async {
    try {
      if (simulateErrorScenario) {
        return JourneyDetailModel.empty();
      }
      // final jsonResponse =
      //     await FixtureReader.loadJsonFromAssets(name: 'journey_to_add.json');
      // JourneyDetailModel response = JourneyDetailModel.empty();

      final prefs = SharedPreferencesAsync();
      final storedJourneys =
          await prefs.getString(AppConstants.journeysKey) ?? '';
      JourneyModel existingJourneys = JourneyModel.fromJson(
        jsonDecode(storedJourneys),
      );
      existingJourneys.trips.add(journey);

      // final journeys = JourneyModel.fromJson(jsonResponse);

      // for (var i = 0; i < journeys.trips.length; i++) {
      //   final currentJourney = journeys.trips[i];
      //   final checkIfExists = existingJourneys.trips
      //       .where((element) => element.id == currentJourney.id)
      //       .toList();
      //   if (checkIfExists.isEmpty) {
      //     existingJourneys.trips.add(currentJourney);
      //     response = currentJourney;
      //     break;
      //   }
      // }

      await prefs.setString(
        AppConstants.journeysKey,
        jsonEncode(
          existingJourneys.toJson(),
        ),
      );

      return journey;
    } catch (e) {
      return JourneyDetailModel.empty();
    }
  }
}
