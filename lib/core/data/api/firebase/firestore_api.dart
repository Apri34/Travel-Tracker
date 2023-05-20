import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:travel_trackr/core/data/entities/destination_entity/destination_entity.dart';
import 'package:travel_trackr/core/data/provider/device_id_provider.dart';
import 'package:travel_trackr/core/di/injection.dart';

@Injectable()
class FirestoreApi {
  final FirestoreReferences _references;

  FirestoreApi(this._references);

  Future<void> addDestination(DestinationEntity destinationEntity) async {
    await _references.destinations.add(destinationEntity.toJson());
  }
}

abstract class FirestoreQueries {
  static Query<DestinationEntity> get destinationsQuery => getIt<FirestoreReferences>().destinations
      .orderBy('startDate', descending: true)
      .withConverter<DestinationEntity>(
        fromFirestore: (snapshot, _) =>
            DestinationEntity.fromJson(snapshot.data()!),
        toFirestore: (destination, _) => destination.toJson(),
      );
}

@Injectable()
class FirestoreReferences {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DeviceIdProvider _deviceIdProvider;

  FirestoreReferences(this._deviceIdProvider);

  static const _users = 'users';
  static const _destinations = 'destinations';

  CollectionReference get users => firestore.collection(_users);

  DocumentReference get user => users.doc(_deviceIdProvider.deviceIdSync);

  CollectionReference get destinations => user.collection(_destinations);

  DocumentReference getDestination(String destinationId) =>
      destinations.doc(destinationId);
}
