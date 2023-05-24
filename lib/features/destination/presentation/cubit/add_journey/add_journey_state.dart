part of 'add_journey_cubit.dart';

@immutable
@freezed
class AddJourneyState with _$AddJourneyState {
  const factory AddJourneyState({
    String? destinationDocId,
    JourneyType? journeyType,
    @Default('') String comment,
    DateTime? startDate,
    DateTime? endDate,
    @Default('') String from,
    @Default('') String to,
    JourneyEntity? journey,
    @Default(false) bool journeyTypeError,
    @Default(false) bool fromError,
    @Default(false) bool toError,
    @Default(false) bool saving,
    @Default(false) bool savingError,
  }) = _AddJourneyState;
}

extension AddJourneyStateExtension on AddJourneyState {
  bool get isValid => !journeyTypeError && !fromError && !toError;
}
