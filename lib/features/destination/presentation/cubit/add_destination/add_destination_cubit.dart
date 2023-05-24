import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:travel_trackr/core/data/api/firebase/firestore_api.dart';
import 'package:travel_trackr/core/utils/date_format_utils.dart';

import '../../../../../core/data/entities/destination_entity/destination_entity.dart';
import '../../../../../core/data/models/city/city.dart';
import '../../../../../core/data/models/country/country.dart';

part 'add_destination_state.dart';

part 'add_destination_cubit.freezed.dart';

@Injectable()
class AddDestinationCubit extends Cubit<AddDestinationState> {
  final FirestoreApi _api;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  AddDestinationCubit(this._api) : super(const AddDestinationState());

  void init(QueryDocumentSnapshot<DestinationEntity>? destination) {
    if (destination == null) {
      return;
    }
    emit(state.copyWith(
      destinationDocId: destination.id,
      country: destination.data().country,
      city: destination.data().city,
      startDate: destination.data().startDate,
      endDate: destination.data().endDate,
      latitude: destination.data().latitude,
      longitude: destination.data().longitude,
    ));
    cityController.text = state.city;
    countryController.text = state.country;
    startDateController.text =
        DateFormatUtils.standard.format(state.startDate!);
    endDateController.text = state.endDate != null
        ? DateFormatUtils.standard.format(state.endDate!)
        : "";
  }

  void setCountry(Country country) {
    if (state.country != country.name) {
      emit(state.copyWith(
        city: '',
        latitude: null,
        longitude: null,
      ));
      cityController.clear();
    }
    emit(state.copyWith(
      country: country.name,
      countryCode: country.cca2,
    ));
    resetCountryError();
  }

  void setCity(City city) {
    emit(state.copyWith(
      city: city.name,
      latitude: city.latitude,
      longitude: city.longitude,
    ));
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
      countryError: state.country.isEmpty,
      cityError: state.city.isEmpty && state.country.isNotEmpty,
      startDateError: state.startDate == null,
    ));
    if (state.isValid) {
      save();
    }
  }

  Future<void> save() async {
    var destination = DestinationEntity(
      country: state.country,
      city: state.city,
      latitude: state.latitude!,
      longitude: state.longitude!,
      startDate: state.startDate!,
      endDate: state.endDate,
    );
    try {
      emit(state.copyWith(
        saving: true,
        savingError: false,
      ));
      if (state.destinationDocId == null) {
        await _api.addDestination(destination);
      } else {
        await _api.updateDestination(state.destinationDocId!, destination);
      }
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
