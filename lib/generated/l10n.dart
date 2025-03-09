// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login Screen`
  String get loginScreen {
    return Intl.message(
      'Login Screen',
      name: 'loginScreen',
      desc: '',
      args: [],
    );
  }

  /// `Frenzi App`
  String get frenziApp {
    return Intl.message('Frenzi App', name: 'frenziApp', desc: '', args: []);
  }

  /// `Login to continue`
  String get loginToContinue {
    return Intl.message(
      'Login to continue',
      name: 'loginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong. Please try again later.`
  String get oopsSomethingWentWrongPleaseTryAgainLater {
    return Intl.message(
      'Oops! Something went wrong. Please try again later.',
      name: 'oopsSomethingWentWrongPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueWord {
    return Intl.message('Continue', name: 'continueWord', desc: '', args: []);
  }

  /// `Oops!`
  String get oops {
    return Intl.message('Oops!', name: 'oops', desc: '', args: []);
  }

  /// `Trip Details`
  String get tripDetails {
    return Intl.message(
      'Trip Details',
      name: 'tripDetails',
      desc: '',
      args: [],
    );
  }

  /// `Completed Trips`
  String get completedTrips {
    return Intl.message(
      'Completed Trips',
      name: 'completedTrips',
      desc: '',
      args: [],
    );
  }

  /// `Booking Journey . . .`
  String get bookingJourney {
    return Intl.message(
      'Booking Journey . . .',
      name: 'bookingJourney',
      desc: '',
      args: [],
    );
  }

  /// `Loading recent Journeys . . .`
  String get loadingRecentJourneys {
    return Intl.message(
      'Loading recent Journeys . . .',
      name: 'loadingRecentJourneys',
      desc: '',
      args: [],
    );
  }

  /// `Journey Added`
  String get journeyAdded {
    return Intl.message(
      'Journey Added',
      name: 'journeyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Proceed`
  String get proceed {
    return Intl.message('Proceed', name: 'proceed', desc: '', args: []);
  }

  /// `Add New Journey`
  String get addNewJourney {
    return Intl.message(
      'Add New Journey',
      name: 'addNewJourney',
      desc: '',
      args: [],
    );
  }

  /// `Book this Journey`
  String get bookThisJourney {
    return Intl.message(
      'Book this Journey',
      name: 'bookThisJourney',
      desc: '',
      args: [],
    );
  }

  /// `Reset cache`
  String get resetCache {
    return Intl.message('Reset cache', name: 'resetCache', desc: '', args: []);
  }

  /// `Simulate Error`
  String get simulateError {
    return Intl.message(
      'Simulate Error',
      name: 'simulateError',
      desc: '',
      args: [],
    );
  }

  /// `Where to?`
  String get whereTo {
    return Intl.message('Where to?', name: 'whereTo', desc: '', args: []);
  }

  /// `Pick up at?`
  String get pickUpAt {
    return Intl.message('Pick up at?', name: 'pickUpAt', desc: '', args: []);
  }

  /// `Please note that the API key that we used for Google Maps does not support Google Places :(`
  String get pleaseNoteThatTheApiKeyThatWeUsedFor {
    return Intl.message(
      'Please note that the API key that we used for Google Maps does not support Google Places :(',
      name: 'pleaseNoteThatTheApiKeyThatWeUsedFor',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
