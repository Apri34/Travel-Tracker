import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_trackr/core/data/entities/stay_entity/stay_entity.dart';
import 'package:travel_trackr/core/utils/date_format_utils.dart';
import 'package:travel_trackr/core/utils/location_util.dart';

import '../../../../../core/data/api/firebase/firestore_api.dart';

part 'add_stay_state.dart';

part 'add_stay_cubit.freezed.dart';

@Injectable()
class AddStayCubit extends Cubit<AddStayState> {
  final FirestoreApi _api;
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  AddStayCubit(this._api) : super(const AddStayState());

  void init(
    String destinationDocId,
    String country,
    QueryDocumentSnapshot<StayEntity>? stay,
  ) {
    emit(state.copyWith(
      destinationDocId: destinationDocId,
      country: country,
    ));

    if (stay == null) {
      return;
    }
    emit(
      state.copyWith(
        address: stay.data().address,
        zip: stay.data().zip,
        city: stay.data().city,
        country: stay.data().country,
        startDate: stay.data().startDate,
        endDate: stay.data().endDate,
        latitude: stay.data().latitude,
        longitude: stay.data().longitude,
        comment: stay.data().comment ?? "",
      ),
    );
    addressController.text = state.address;
    zipController.text = state.zip;
    cityController.text = state.city;
    countryController.text = state.country;
    startDateController.text = state.startDate != null
        ? DateFormatUtils.standard.format(state.startDate!)
        : "";
    endDateController.text = state.endDate != null
        ? DateFormatUtils.standard.format(state.endDate!)
        : "";
    commentController.text = state.comment;
  }

  void setAddress(String address) {
    emit(state.copyWith(address: address));
    resetAddressError();
  }

  void setZip(String zip) {
    emit(state.copyWith(zip: zip));
    resetZipError();
  }

  void setCity(String city) {
    emit(state.copyWith(city: city));
    resetCityError();
  }

  void setStartDate(DateTime startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void setEndDate(DateTime endDate) {
    emit(state.copyWith(endDate: endDate));
  }

  void setComment(String comment) {
    emit(state.copyWith(comment: comment));
  }

  void resetAddressError() {
    emit(state.copyWith(addressError: false));
  }

  void resetZipError() {
    emit(state.copyWith(zipError: false));
  }

  void resetCityError() {
    emit(state.copyWith(cityError: false));
  }

  Future<void> validateAndSave() async {
    emit(state.copyWith(
      addressError: state.address.isEmpty,
      zipError: state.zip.isEmpty,
      cityError: state.city.isEmpty,
    ));
    if (state.isValid) {
      var coordinates = await LocationUtil.getCoordinatesFromAddress(
          state.getFullAddress(true));
      if (coordinates != null) {
        emit(state.copyWith(
          latitude: coordinates.latitude,
          longitude: coordinates.longitude,
        ));
      } else {
        emit(state.copyWith(
          addressError: true,
          zipError: true,
          cityError: true,
        ));
      }
    }
    if (state.isValid && state.latitude != null && state.longitude != null) {
      save();
    }
  }

  Future<void> save() async {
    var stay = StayEntity(
      address: state.address,
      startDate: state.startDate,
      endDate: state.endDate,
      latitude: state.latitude,
      longitude: state.longitude,
      comment: state.comment,
      city: state.city,
      zip: state.zip,
      country: state.country,
    );
    try {
      emit(state.copyWith(
        saving: true,
        savingError: false,
      ));
      if (state.stayDocId == null) {
        await _api.addStay(state.destinationDocId!, stay);
      } else {
        await _api.updateStay(state.destinationDocId!, state.stayDocId!, stay);
      }
      emit(state.copyWith(
        savingError: false,
        stay: stay,
      ));
    } catch (e) {
      emit(state.copyWith(
        saving: false,
        savingError: true,
      ));
    }
  }
}
