import 'package:freezed_annotation/freezed_annotation.dart';

part 'stay_entity.g.dart';

part 'stay_entity.freezed.dart';

@freezed
class StayEntity with _$StayEntity {
  const factory StayEntity({
    DateTime? startDate,
    DateTime? endDate,
    required String address,
    double? latitude,
    double? longitude,
    String? comment,
  }) = _StayEntity;

  factory StayEntity.fromJson(Map<String, Object?> json) =>
      _$StayEntityFromJson(json);
}
