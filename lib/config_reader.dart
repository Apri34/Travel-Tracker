import 'dart:convert';

import 'package:flutter/services.dart';

import 'core/data/models/country/country.dart';

abstract class Config {
  static List<Country>? _countries;

  static Future<void> initialize() async {
    final countryString =
        await rootBundle.loadString("assets/data/countries.json");
    _countries = (json.decode(countryString) as List<dynamic>)
        .map((e) => Country.fromJson(e))
        .toList()..sort((e1, e2) => e1.name.compareTo(e2.name));
  }

  static List<Country> get countries =>
      _countries != null ? _countries! : throw ConfigNotInitializedException();
}

class ConfigNotInitializedException implements Exception {}
