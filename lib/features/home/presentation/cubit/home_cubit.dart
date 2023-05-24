import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';

import '../../../../core/data/api/firebase/firestore_api.dart';

part 'home_state.dart';

part 'home_cubit.freezed.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final FirestoreApi _api;

  HomeCubit(this._api) : super(const HomeState()) {
    fetchDestinations();
  }

  void toggleEditing(bool active) {
    emit(state.copyWith(
      editing: active,
    ));
  }

  Future<void> fetchDestinations() async {
    _api.getDestinations().listen((destinations) {
      emit(state.copyWith(
        destinations: destinations,
        loaded: true,
      ));
    });
  }

  Future<void> deleteDestination(String destinationDocId) async {
    await _api.deleteDestination(destinationDocId);
  }

  Future<void> deleteStay(String destinationDocId, String stayDocId) async {
    await _api.deleteStay(destinationDocId, stayDocId);
  }

  Future<void> deleteJourney(
      String destinationDocId, String journeyDocId) async {
    await _api.deleteJourney(destinationDocId, journeyDocId);
  }
}
