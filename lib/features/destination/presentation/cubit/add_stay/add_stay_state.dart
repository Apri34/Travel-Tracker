part of 'add_stay_cubit.dart';

@immutable
@freezed
class AddStayState with _$AddStayState {
  const factory AddStayState({
    String? destinationDocId,
    @Default('') String address,
    @Default('') String zip,
    @Default('') String city,
    @Default('') String country,
    DateTime? startDate,
    DateTime? endDate,
    double? latitude,
    double? longitude,
    String? comment,
    StayEntity? stay,
    @Default(false) bool addressError,
    @Default(false) bool zipError,
    @Default(false) bool cityError,
    @Default(false) bool saving,
    @Default(false) bool savingError,
  }) = _AddStayState;
}

extension AddStayStateExtension on AddStayState {
  String getFullAddress(bool withCountry) {
    var parts = [zip, city, address, if (withCountry) country]
        .where((element) => element.isNotEmpty)
        .toList();
    return parts.join(",");
  }

  bool get isValid => !addressError && !cityError && !addressError;
}
