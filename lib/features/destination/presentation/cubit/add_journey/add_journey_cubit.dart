import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:travel_trackr/core/utils/date_format_utils.dart';

import '../../../../../core/data/api/firebase/firestore_api.dart';
import '../../../../../core/data/entities/journey_entity/journey_entity.dart';

part 'add_journey_state.dart';

part 'add_journey_cubit.freezed.dart';

@Injectable()
class AddJourneyCubit extends Cubit<AddJourneyState> {
  final FirestoreApi _api;
  final TextEditingController commentController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  AddJourneyCubit(this._api) : super(const AddJourneyState());

  void init(
    String destinationDocId,
    QueryDocumentSnapshot<JourneyEntity>? journey,
  ) {
    emit(state.copyWith(
      destinationDocId: destinationDocId,
    ));
    if (journey == null) {
      return;
    }
    emit(state.copyWith(
      journeyDocId: journey.id,
      journeyType: journey.data().type,
      comment: journey.data().comment ?? "",
      startDate: journey.data().startDate,
      endDate: journey.data().endDate,
      from: journey.data().from,
      to: journey.data().to,
    ));
    commentController.text = state.comment;
    startDateController.text = state.startDate != null
        ? DateFormatUtils.standardWithTime.format(state.startDate!)
        : "";
    endDateController.text = state.endDate != null
        ? DateFormatUtils.standardWithTime.format(state.endDate!)
        : "";
    fromController.text = state.from;
    toController.text = state.to;
  }

  void setJourneyType(JourneyType journeyType) {
    if (journeyType.destinationType != state.journeyType?.destinationType) {
      emit(state.copyWith(
        from: '',
        to: '',
      ));
    }
    emit(state.copyWith(
      journeyType: journeyType,
    ));
    resetJourneyTypeError();
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

  void setFrom(String from) {
    emit(state.copyWith(from: from));
    resetFromError();
  }

  void setTo(String to) {
    emit(state.copyWith(to: to));
    resetToError();
  }

  void resetJourneyTypeError() {
    emit(state.copyWith(journeyTypeError: false));
  }

  void resetFromError() {
    emit(state.copyWith(fromError: false));
  }

  void resetToError() {
    emit(state.copyWith(toError: false));
  }

  Future<void> validateAndSave() async {
    emit(state.copyWith(
      journeyTypeError: state.journeyType == null,
      fromError: state.from.isEmpty && state.journeyType != null,
      toError: state.to.isEmpty && state.journeyType != null,
    ));
    if (state.isValid) {
      save();
    }
  }

  Future<void> save() async {
    var journey = JourneyEntity(
      type: JourneyType.bus,
      from: state.from,
      to: state.to,
      startDate: state.startDate,
      endDate: state.endDate,
      comment: state.comment,
    );
    try {
      emit(state.copyWith(
        saving: true,
        savingError: false,
      ));
      if (state.journeyDocId == null) {
        await _api.addJourney(state.destinationDocId!, journey);
      } else {
        await _api.updateJourney(
          state.destinationDocId!,
          state.journeyDocId!,
          journey,
        );
      }
      emit(state.copyWith(
        savingError: false,
        journey: journey,
      ));
    } catch (e) {
      emit(state.copyWith(
        saving: false,
        savingError: true,
      ));
    }
  }
}
