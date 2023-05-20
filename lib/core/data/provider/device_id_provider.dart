import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/physics.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeviceIdProvider {
  String? _deviceId;

  Future<void> init() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      _deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      _deviceId = androidDeviceInfo.androidId;
    }
  }

  Future<String> get deviceId async {
    if (_deviceId == null) {
      await init();
    }
    return _deviceId!;
  }

  String get deviceIdSync =>
      _deviceId == null ? throw DeviceIdNotInitializedException() : _deviceId!;
}

class DeviceIdNotInitializedException implements Exception {}
