import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:travel_trackr/core/data/api/firebase/firestore_api.dart';

import '../../../../../core/data/entities/destination_entity/destination_entity.dart';
import '../../../../../core/data/models/city/city.dart';
import '../../../../../core/data/models/country/country.dart';

part 'add_destination_state.dart';

part 'add_destination_cubit.freezed.dart';

@Injectable()
class AddDestinationCubit extends Cubit<AddDestinationState> {
  final FirestoreApi _api;
  final TextEditingController cityController = TextEditingController();

  AddDestinationCubit(this._api) : super(const AddDestinationState());

  void setCountry(Country country) {
    if (state.country?.name != country.name) {
      emit(state.copyWith(city: null));
      cityController.clear();
    }
    emit(state.copyWith(country: country));
    resetCountryError();
  }

  void setCity(City city) {
    emit(state.copyWith(city: city));
    resetCityError();
  }

  void setStartDate(DateTime startDate) {
    emit(state.copyWith(startDate: startDate));
    resetStartDateError();
  }

  void setEndDate(DateTime endDate) {
    emit(state.copyWith(endDate: endDate));
  }

  void resetCountryError() {
    emit(state.copyWith(countryError: false));
  }

  void resetCityError() {
    emit(state.copyWith(cityError: false));
  }

  void resetStartDateError() {
    emit(state.copyWith(startDateError: false));
  }

  void validateAndSave() {
    emit(state.copyWith(
      countryError: state.country == null,
      cityError: state.city == null && state.country != null,
      startDateError: state.startDate == null,
    ));
    if (state.isValid) {
      save();
    }
  }

  Future<void> save() async {
    var destination = DestinationEntity(
      country: state.country!.name,
      city: state.city!.name,
      latitude: state.city!.latitude,
      longitude: state.city!.longitude,
      startDate: state.startDate!,
      endDate: state.endDate,
    );
    try {
      emit(state.copyWith(
        saving: true,
        savingError: false,
      ));
      await _api.addDestination(destination);
      emit(state.copyWith(
        savingError: false,
        destination: destination,
      ));
    } catch (e) {
      emit(state.copyWith(
        saving: false,
        savingError: true,
      ));
    }
  }
}
