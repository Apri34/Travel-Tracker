import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Storages {
  Storages._();

  static final GetStorage _authStorage = GetStorage(_auth);

  static GetStorage get authStorage => _authStorage;

  static const _auth = 'auth';

  static Future<void> init() async {
    await GetStorage.init();
    await GetStorage.init(_auth);
  }

  static Future<void> clearAll() async {
    await GetStorage().erase();
    await GetStorage(_auth).erase();
  }
}

class StorageKeys {
  StorageKeys._();

  static const username = 'username';
}
