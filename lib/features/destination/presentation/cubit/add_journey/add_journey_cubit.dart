import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../../../../core/data/api/firebase/firestore_api.dart';
import '../../../../../core/data/entities/journey_entity/journey_entity.dart';

part 'add_journey_state.dart';

part 'add_journey_cubit.freezed.dart';

@Injectable()
class AddJourneyCubit extends Cubit<AddJourneyState> {
  final FirestoreApi _api;

  AddJourneyCubit(this._api) : super(const AddJourneyState());

  void init(String destinationDocId) {
    emit(state.copyWith(
      destinationDocId: destinationDocId,
    ));
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
      await _api.addJourney(state.destinationDocId!, journey);
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
