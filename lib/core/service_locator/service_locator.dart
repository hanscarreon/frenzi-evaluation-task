import 'package:flutter/foundation.dart';
import 'package:frenzi_app/features/journey/data/journey_repository_impl.dart';
import 'package:frenzi_app/features/home/presentation/blocs/bloc/home_bloc.dart';
import 'package:frenzi_app/features/journey/domain/models/journey_model.dart';
import 'package:frenzi_app/features/journey/presentation/blocs/bloc/journey_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance..allowReassignment = true;

abstract class ServiceLocator {
  static Future<void> register() async {
    registerBlocs();

    await getIt.allReady();
  }

  static void registerCompletedJourneys({
    required JourneyModel journeys,
  }) async {
    getIt.registerSingleton<JourneyModel>(journeys);
  }

  static void registerBlocs() {
    try {
      _registerHomeBloc();
      _registerJourneyBloc();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static void _registerHomeBloc() {
    getIt.registerFactory<HomeBloc>(
      () => HomeBloc(
        journeyRepository: JourneyRepositoryImpl(),
      ),
    );
  }

  static void _registerJourneyBloc() {
    getIt.registerFactory<JourneyBloc>(
      () => JourneyBloc(
        journeyRepository: JourneyRepositoryImpl(),
      ),
    );
  }
}
