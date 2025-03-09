import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenzi_app/core/constants/app_constants.dart';
import 'package:frenzi_app/core/service_locator/service_locator.dart';
import 'package:frenzi_app/features/journey/data/journey_repository.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.journeyRepository,
  }) : super(HomeInitial()) {
    on<LoadCompletedJourneysEvent>(_onLoadCompletedJourneys);
    on<ResetCacheEvent>(_onResetCacheEvent);
  }

  final JourneyRepository journeyRepository;

  FutureOr<void> _onLoadCompletedJourneys(
    LoadCompletedJourneysEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      JourneyModel journeys = JourneyModel.empty();
      final prefs = SharedPreferencesAsync();

      final getStoredJourneys =
          await prefs.getString(AppConstants.journeysKey) ?? '';
      if (getStoredJourneys.isNotEmpty) {
        journeys = JourneyModel.fromJson(jsonDecode(getStoredJourneys));
      } else {
        await Future.delayed(
          const Duration(seconds: 1),
        );

        if (!getIt.isRegistered<JourneyModel>()) {
          final response = await journeyRepository.loadCompletedJourneys();
          ServiceLocator.registerCompletedJourneys(
            journeys: response,
          );

          await prefs.setString(
            AppConstants.journeysKey,
            jsonEncode(
              response.toJson(),
            ),
          );

          journeys = response;
        } else {
          journeys = getIt<JourneyModel>();
        }
      }

      emit(
        LoadedJourneyState(
          completedTrips: journeys,
        ),
      );
    } catch (e) {
      emit(HomeError());
    }
  }

  FutureOr<void> _onResetCacheEvent(
    ResetCacheEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoading());
      final prefs = SharedPreferencesAsync();
      await prefs.clear();
      emit(ResetCacheSuccess());
    } catch (e) {
      emit(HomeError());
    }
  }
}
