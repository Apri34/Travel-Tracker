import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';
import 'package:travel_trackr/core/data/entities/journey_entity/journey_entity.dart';
import 'package:travel_trackr/core/data/entities/stay_entity/stay_entity.dart';
import 'package:travel_trackr/core/data/provider/device_id_provider.dart';
import 'package:travel_trackr/core/di/injection.dart';

@Injectable()
class FirestoreApi {
  final FirestoreReferences _references;

  FirestoreApi(this._references);

  Future<void> addDestination(DestinationEntity destinationEntity) async {
    await _references.destinations.add(destinationEntity.toJson());
  }

  Future<void> updateDestination(
      String destinationDocId, DestinationEntity destinationEntity) async {
    await _references
        .getDestination(destinationDocId)
        .set(destinationEntity.toJson());
  }

  Future<void> deleteDestination(String destinationDocId) async {
    await _references.getDestination(destinationDocId).delete();
  }

  Future<void> addStay(String destinationDocId, StayEntity stayEntity) async {
    await _references.getStays(destinationDocId).add(stayEntity.toJson());
  }

  Future<void> updateStay(
      String destinationDocId, String stayDocId, StayEntity stayEntity) async {
    await _references
        .getStay(destinationDocId, stayDocId)
        .set(stayEntity.toJson());
  }

  Future<void> deleteStay(String destinationDocId, String stayDocId) async {
    await _references.getStay(destinationDocId, stayDocId).delete();
  }

  Future<void> addJourney(
      String destinationDocId, JourneyEntity journeyEntity) async {
    await _references.getJourneys(destinationDocId).add(journeyEntity.toJson());
  }

  Future<void> updateJourney(String destinationDocId, String journeyDocId,
      JourneyEntity journeyEntity) async {
    await _references
        .getJourney(destinationDocId, journeyDocId)
        .set(journeyEntity.toJson());
  }

  Future<void> deleteJourney(
      String destinationDocId, String journeyDocId) async {
    await _references.getJourney(destinationDocId, journeyDocId).delete();
  }

  Stream<List<QueryDocumentSnapshot<DestinationEntity>>> getDestinations() {
    return FirestoreQueries.destinationsQuery
        .snapshots()
        .map((event) => event.docs);
  }
}

abstract class FirestoreQueries {
  static Query<DestinationEntity> get destinationsQuery =>
      getIt<FirestoreReferences>()
          .destinations
          .orderBy('startDate', descending: true)
          .withConverter<DestinationEntity>(
            fromFirestore: (snapshot, _) =>
                DestinationEntity.fromJson(snapshot.data()!),
            toFirestore: (e, _) => e.toJson(),
          );

  static Query<StayEntity> getStaysQuery(String destinationDocId) =>
      getIt<FirestoreReferences>()
          .getStays(destinationDocId)
          .orderBy('startDate')
          .withConverter<StayEntity>(
            fromFirestore: (snapshot, _) =>
                StayEntity.fromJson(snapshot.data()!),
            toFirestore: (e, _) => e.toJson(),
          );

  static Query<JourneyEntity> getJourneysQuery(String destinationDocId) =>
      getIt<FirestoreReferences>()
          .getJourneys(destinationDocId)
          .orderBy('startDate')
          .withConverter<JourneyEntity>(
            fromFirestore: (snapshot, _) =>
                JourneyEntity.fromJson(snapshot.data()!),
            toFirestore: (e, _) => e.toJson(),
          );
}

@Injectable()
class FirestoreReferences {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DeviceIdProvider _deviceIdProvider;

  FirestoreReferences(this._deviceIdProvider);

  static const _users = 'users';
  static const _destinations = 'destinations';
  static const _stays = 'stays';
  static const _journeys = 'journeys';

  CollectionReference get users => firestore.collection(_users);

  DocumentReference get user => users.doc(_deviceIdProvider.deviceIdSync);

  CollectionReference get destinations => user.collection(_destinations);

  DocumentReference getDestination(String destinationId) =>
      destinations.doc(destinationId);

  CollectionReference getStays(String destinationId) =>
      destinations.doc(destinationId).collection(_stays);

  DocumentReference getStay(String destinationId, String stayId) =>
      getStays(destinationId).doc(stayId);

  CollectionReference getJourneys(String destinationId) =>
      destinations.doc(destinationId).collection(_journeys);

  DocumentReference getJourney(String destinationId, String journeyId) =>
      getJourneys(destinationId).doc(journeyId);
}
