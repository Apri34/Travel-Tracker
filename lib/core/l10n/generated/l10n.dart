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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Start Date`
  String get startDate {
    return Intl.message(
      'Start Date',
      name: 'startDate',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDate {
    return Intl.message(
      'End Date',
      name: 'endDate',
      desc: '',
      args: [],
    );
  }

  /// `Add Destination`
  String get addDestination {
    return Intl.message(
      'Add Destination',
      name: 'addDestination',
      desc: '',
      args: [],
    );
  }

  /// `Add Stay`
  String get addStay {
    return Intl.message(
      'Add Stay',
      name: 'addStay',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `ZIP`
  String get zip {
    return Intl.message(
      'ZIP',
      name: 'zip',
      desc: '',
      args: [],
    );
  }

  /// `Bus`
  String get bus {
    return Intl.message(
      'Bus',
      name: 'bus',
      desc: '',
      args: [],
    );
  }

  /// `Train`
  String get train {
    return Intl.message(
      'Train',
      name: 'train',
      desc: '',
      args: [],
    );
  }

  /// `Flight`
  String get flight {
    return Intl.message(
      'Flight',
      name: 'flight',
      desc: '',
      args: [],
    );
  }

  /// `Add Journey`
  String get addJourney {
    return Intl.message(
      'Add Journey',
      name: 'addJourney',
      desc: '',
      args: [],
    );
  }

  /// `Travel type`
  String get journeyType {
    return Intl.message(
      'Travel type',
      name: 'journeyType',
      desc: '',
      args: [],
    );
  }

  /// `From`
  String get from {
    return Intl.message(
      'From',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `To`
  String get to {
    return Intl.message(
      'To',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Delete Journey`
  String get deleteJourneyTitle {
    return Intl.message(
      'Delete Journey',
      name: 'deleteJourneyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this journey?`
  String get deleteJourneyDescription {
    return Intl.message(
      'Do you really want to delete this journey?',
      name: 'deleteJourneyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Destination`
  String get deleteDestinationTitle {
    return Intl.message(
      'Delete Destination',
      name: 'deleteDestinationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this destination?`
  String get deleteDestinationDescription {
    return Intl.message(
      'Do you really want to delete this destination?',
      name: 'deleteDestinationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Delete Stay`
  String get deleteStayTitle {
    return Intl.message(
      'Delete Stay',
      name: 'deleteStayTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete this stay?`
  String get deleteStayDescription {
    return Intl.message(
      'Do you really want to delete this stay?',
      name: 'deleteStayDescription',
      desc: '',
      args: [],
    );
  }

  /// `Create your first destination now!`
  String get emptyDestinationsPlaceholder {
    return Intl.message(
      'Create your first destination now!',
      name: 'emptyDestinationsPlaceholder',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
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
