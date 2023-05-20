import 'package:freezed_annotation/freezed_annotation.dart';

import '../journey_entity/journey_entity.dart';
import '../stay_entity/stay_entity.dart';

part 'destination_entity.freezed.dart';

part 'destination_entity.g.dart';

@freezed
class DestinationEntity with _$DestinationEntity {
  const factory DestinationEntity({
    required String country,
    required String city,
    required double latitude,
    required double longitude,
    required DateTime startDate,
    DateTime? endDate,
    @Default([]) List<JourneyEntity> journeys,
    @Default([]) List<StayEntity> stays,
  }) = _DestinationEntity;

  factory DestinationEntity.fromJson(Map<String, Object?> json) =>
      _$DestinationEntityFromJson(json);
}
