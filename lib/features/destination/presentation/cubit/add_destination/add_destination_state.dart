part of 'add_destination_cubit.dart';

@immutable
@freezed
class AddDestinationState with _$AddDestinationState {
  const factory AddDestinationState({
    Country? country,
    DateTime? startDate,
    DateTime? endDate,
    City? city,
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
