part of 'add_destination_cubit.dart';

@immutable
@freezed
class AddDestinationState with _$AddDestinationState {
  const factory AddDestinationState({
    String? destinationDocId,
    @Default('') String country,
    @Default('') String countryCode,
    DateTime? startDate,
    DateTime? endDate,
    @Default('') String city,
    double? latitude,
    double? longitude,
    @Default(false) bool countryError,
    @Default(false) bool cityError,
    @Default(false) bool startDateError,
    DestinationEntity? destination,
    @Default(false) bool saving,
    @Default(false) bool savingError,
  }) = _AddDestinationState;
}

extension AddDestinationStateExtension on AddDestinationState {
  bool get isValid => !countryError && !cityError && !startDateError;
}
