import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.g.dart';

part 'city.freezed.dart';

@freezed
class City with _$City {
  const factory City({
    required String name,
    required double latitude,
    required double longitude,
  }) = _City;

  factory City.fromJson(Map<String, Object?> json) => _$CityFromJson(json);
}
