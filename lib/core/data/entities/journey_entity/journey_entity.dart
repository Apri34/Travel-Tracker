import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../l10n/generated/l10n.dart';

part 'journey_entity.freezed.dart';

part 'journey_entity.g.dart';

@freezed
class JourneyEntity with _$JourneyEntity {
  const factory JourneyEntity({
    required JourneyType type,
    DateTime? startDate,
    DateTime? endDate,
    String? comment,
    @Default('') String from,
    @Default('') String to,
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

extension JourneyTypeExtension on JourneyType {
  String asString(BuildContext context) {
    S s = S.of(context);
    switch (this) {
      case JourneyType.bus:
        return s.bus;
      case JourneyType.flight:
        return s.flight;
      case JourneyType.train:
        return s.train;
    }
  }

  DestinationType get destinationType {
    switch (this) {
      case JourneyType.bus:
        return DestinationType.city;
      case JourneyType.flight:
        return DestinationType.airport;
      case JourneyType.train:
        return DestinationType.city;
    }
  }
}

enum DestinationType {
  city,
  airport,
}
