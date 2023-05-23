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

  Future<void> addStay(String destinationDocId, StayEntity stayEntity) async {
    await _references.getStays(destinationDocId).add(stayEntity.toJson());
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

  CollectionReference getJourneys(String destinationId) =>
      destinations.doc(destinationId).collection(_journeys);
}
