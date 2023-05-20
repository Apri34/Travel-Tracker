import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travel_trackr/config_reader.dart';
import 'package:travel_trackr/core/data/provider/device_id_provider.dart';
import 'package:travel_trackr/travel_trackr.dart';

import 'core/data/storage.dart';
import 'core/di/injection.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  await Config.initialize();
  await getIt<DeviceIdProvider>().init();
  Storages.init();
  runApp(TravelTrackr());
}
