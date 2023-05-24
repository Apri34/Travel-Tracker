import 'package:freezed_annotation/freezed_annotation.dart';

part 'airport.g.dart';

part 'airport.freezed.dart';

@freezed
class Airport with _$Airport {
  const factory Airport({
    required String name,
    required String iata,
    required String city,
  }) = _Airport;

  factory Airport.fromJson(Map<String, Object?> json) => _$AirportFromJson(json);
}
