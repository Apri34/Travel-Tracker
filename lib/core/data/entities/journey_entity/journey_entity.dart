import 'package:freezed_annotation/freezed_annotation.dart';

part 'journey_entity.freezed.dart';

part 'journey_entity.g.dart';

@freezed
class JourneyEntity with _$JourneyEntity {
  const factory JourneyEntity({
    required JourneyType type,
    DateTime? startDate,
    DateTime? endDate,
    String? description,
  }) = _JourneyEntity;

  factory JourneyEntity.fromJson(Map<String, Object?> json) =>
      _$JourneyEntityFromJson(json);
}

@JsonEnum()
enum JourneyType {
  bus,
  flight,
  train,
}
