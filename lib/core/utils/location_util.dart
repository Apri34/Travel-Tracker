import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../data/models/app_placemark.dart';

abstract class LocationUtil {
  static Future<AppPlacemark> getAppPlacemarkFrom(
      double lat, double lng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng)
        .catchError((e) => debugPrint(e));
    return AppPlacemark(placeMarks);
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) =>
      getAppPlacemarkFrom(lat, lng).then<String>((value) => value.longInfo);

  static Future<String> getShortAddressFromLatLng(double lat, double lng) =>
      getAppPlacemarkFrom(lat, lng).then<String>((value) => value.shortInfo);

  static Future<String?> getCountryFromLatLng(double lat, double lng) =>
      getAppPlacemarkFrom(lat, lng)
          .then<String?>((value) => value.placemark.country);

  static Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> placemarks = await locationFromAddress(address);
      if (placemarks.isNotEmpty) {
        return LatLng(
          latitude: placemarks.first.latitude,
          longitude: placemarks.first.longitude,
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

class LatLng {
  final double latitude;
  final double longitude;

  const LatLng({
    required this.latitude,
    required this.longitude,
  });
}
