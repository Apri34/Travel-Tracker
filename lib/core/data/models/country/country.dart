import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.g.dart';

part 'country.freezed.dart';

@freezed
class Country with _$Country {
  const factory Country({
    required String cca2,
    required String name,
    required String flag,
  }) = _Country;

  factory Country.fromJson(Map<String, Object?> json) =>
      _$CountryFromJson(json);
}
