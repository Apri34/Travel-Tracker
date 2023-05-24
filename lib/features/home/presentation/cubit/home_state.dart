part of 'home_cubit.dart';

@immutable
@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool editing,
    @Default(false) bool loaded,
    @Default([]) List<QueryDocumentSnapshot<DestinationEntity>> destinations,
  }) = _HomeState;
}
