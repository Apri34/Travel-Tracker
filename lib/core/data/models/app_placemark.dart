import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:travel_trackr/core/utils/string_extension.dart';

/*
  administrativeArea: The name of the administrative area (e.g. state or province).
  subAdministrativeArea: The name of the sub-administrative area (e.g. county).
  locality: The name of the city or town.
  subLocality: The name of the sub-locality (e.g. neighborhood).
  thoroughfare: The name of the street.
  subThoroughfare: The number of the building on the street.
  name: The name of the place.
  isoCountryCode: The ISO country code for the country associated with the location.
* */

class AppPlacemark {
  late Placemark placemark;

  AppPlacemark(List<Placemark> placeMarks) {
    String? name;
    String? street;
    String? subLocality;
    String? locality;
    String? administrativeArea;
    String? postalCode;
    String? country;
    String? thoroughfare;
    String? isoCountryCode;
    String? subAdministrativeArea;
    String? subThoroughfare;

    for (final p in placeMarks) {
      name ??= p.name;
      street ??= p.street;
      subLocality ??= p.subLocality;
      locality ??= p.locality;
      administrativeArea ??= p.administrativeArea;
      postalCode ??= p.postalCode;
      country ??= p.country;
      thoroughfare ??= p.thoroughfare;
      subThoroughfare ??= p.subThoroughfare;
      isoCountryCode ??= p.isoCountryCode;
      subAdministrativeArea ??= p.subAdministrativeArea;
    }

    placemark = Placemark(
        name: name,
        street: street,
        subLocality: subLocality,
        locality: locality,
        administrativeArea: administrativeArea,
        postalCode: postalCode,
        country: country,
        isoCountryCode: isoCountryCode,
        subAdministrativeArea: subAdministrativeArea,
        subThoroughfare: subThoroughfare,
        thoroughfare: thoroughfare);
  }

  factory AppPlacemark.fromPlacemark(Placemark placemark) =>
      AppPlacemark([placemark]);

  factory AppPlacemark.fromMapboxPlacemark(MapBoxPlace mapBoxPlace) =>
      AppPlacemark([
        Placemark(
          name: mapBoxPlace.placeName,
          street: mapBoxPlace.properties?.address,
          locality: mapBoxPlace.placeName,
          //subLocality: mapBoxPlace..subLocality,
          //locality: mapBoxPlace.locality,
          //administrativeArea: mapBoxPlace.administrativeArea,
          //postalCode: mapBoxPlace.postalCode,
          //country: mapBoxPlace.,
          //isoCountryCode: mapBoxPlace.isoCountryCode,
          //subAdministrativeArea: mapBoxPlace.subAdministrativeArea,
          //subThoroughfare: mapBoxPlace.subThoroughfare,
          //thoroughfare: mapBoxPlace.thoroughfare,
        )
      ]);

  String get shortInfo {
    String r = '';
    if (placemark.locality.isNotEmptyNull) r += placemark.locality!;
    if (r.isEmpty && placemark.subLocality.isNotEmptyNull) {
      r += placemark.subLocality!;
    }
    return r.isEmpty ? 'UnknownShort' : r;
  }

  String get longInfo {
    String r = '';
    if (placemark.street.isNotEmptyNull && !r.contains(placemark.street!)) r += placemark.street!;
    r = r.addIfNotEmpty(' ');
    if (placemark.subLocality.isNotEmptyNull && !r.contains(placemark.subLocality!)) r += placemark.subLocality!;
    r = r.addIfNotEmpty(' ');
    if (placemark.locality.isNotEmptyNull && !r.contains(placemark.locality!)) r += placemark.locality!;
    return r.isEmpty ? 'UnknownLong' : r;
  }

  bool get isCity {
    return placemark.locality != null && placemark.subLocality == null;
  }

  String get featureName {
    final res = (placemark.subThoroughfare ?? '')
        .addIfNotEmpty(' ')
        .addIfEmpty(placemark.name)
        .addIfNotEmpty(' ')
        .addIfEmpty(placemark.thoroughfare)
        .addIfNotEmpty(', ')
        .addIfEmpty(placemark.subLocality)
        .addIfNotEmpty(', ')
        .addIfEmpty(placemark.locality)
        .addIfNotEmpty(', ')
        .addIfEmpty(placemark.administrativeArea)
        .addIfNotEmpty(', ')
        .addIfEmpty(placemark.country);
    print('Seas"');
    print(placemark.toJson());
    return res.isEmpty ? 'Unknown3' : res;
  }
}

///Various types of geographic features are available in the Mapbox geocoder. Any type might appear as a top-level response, as context in a top-level response, or as a filtering option using the types parameter. Not all features are available or relevant in all parts of the world. New types are occasionally added as necessary to correctly capture global administrative hierarchies.
///The data types available in the geocoder, listed from the largest to the most granular, are:
enum PlaceType {
  ///Generally recognized countries or, in some cases like Hong Kong, an area of quasi-national administrative status that has been given a designated country code under ISO 3166-1.
  country,

  ///Top-level sub-national administrative features, such as states in the United States or provinces in Canada or China.
  region,

  ///Postal codes used in country-specific national addressing systems.
  postcode,

  ///Features that are smaller than top-level administrative features but typically larger than cities, in countries that use such an additional layer in postal addressing (for example, prefectures in China).
  district,

  ///Typically these are cities, villages, municipalities, etc. They’re usually features used in postal addressing, and are suitable for display in ambient end-user applications where current-location context is needed (for example, in weather displays).
  place,

  ///Official sub-city features present in countries where such an additional administrative layer is used in postal addressing, or where such features are commonly referred to in local parlance. Examples include city districts in Brazil and Chile and arrondissements in France.
  locality,

  ///Colloquial sub-city features often referred to in local parlance. Unlike locality features, these typically lack official status and may lack universally agreed-upon boundaries.
  neighborhood,

  ///Individual residential or business addresses.
  address,

  ///Points of interest. These include restaurants, stores, concert venues, parks, museums, etc.
  poi,
}

extension PlaceTypeX on PlaceType {
  String get value => toString().split('.').last;
}

class MapBoxPlace {
  String? id;
  FeatureType? type;
  List<PlaceType>? placeType;

  // dynamic relevance;
  String? addressNumber;
  Properties? properties;
  String? text;
  String? placeName;
  List<double>? bbox;
  List<double>? center;
  Geometry? geometry;
  List<Context>? context;
  String? matchingText;
  String? matchingPlaceName;
  num? relevance;

  MapBoxPlace({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.addressNumber,
    this.properties,
    this.text,
    this.placeName,
    this.bbox,
    this.center,
    this.geometry,
    this.context,
    this.matchingText,
    this.matchingPlaceName,
  });

  factory MapBoxPlace.fromRawJson(String str) =>
      MapBoxPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapBoxPlace.fromJson(Map<String, dynamic> json) => MapBoxPlace(
    id: json["id"],
    type: json["type"] == null ? null : featureTypeValues.map[json["type"]],
    placeType: json["place_type"] == null
        ? null
        : List<PlaceType>.from(
        json["place_type"].map((x) => placeTypeValues.map[x])),
    relevance: json["relevance"],
    addressNumber: json["address"],
    properties: json["properties"] == null
        ? null
        : Properties.fromJson(json["properties"]),
    text: json["text"],
    placeName: json["place_name"],
    bbox: json["bbox"] == null
        ? null
        : List<double>.from(json["bbox"].map((x) => x.toDouble())),
    center: json["center"] == null
        ? null
        : List<double>.from(json["center"].map((x) => x.toDouble())),
    geometry: json["geometry"] == null
        ? null
        : Geometry.fromJson(json["geometry"]),
    context: json["context"] == null
        ? null
        : List<Context>.from(
        json["context"].map((x) => Context.fromJson(x))),
    matchingText: json["matching_text"],
    matchingPlaceName: json["matching_place_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": featureTypeValues.reverse![type!],
    "place_type": List<dynamic>.from(
        placeType!.map((x) => placeTypeValues.reverse![x])),
    // "relevance": relevance,
    "address": addressNumber,
    "properties": properties!.toJson(),
    "text": text,
    "place_name": placeName,
    "bbox": List<dynamic>.from(bbox!.map((x) => x)),
    "center": List<dynamic>.from(center!.map((x) => x)),
    "geometry": geometry!.toJson(),
    "context": context == null
        ? null
        : List<dynamic>.from(context!.map((x) => x.toJson())),
    "matching_text": matchingText == null ? null : matchingText,
    "matching_place_name":
    matchingPlaceName == null ? null : matchingPlaceName,
  };

  @override
  String toString() => text ?? placeName!;

  String get subheading {
    final s = (placeName ?? '').replaceFirst('${text ?? ""},', '').trim();
    return s.isEmpty ? 'Unknown' : s;
  }
}

class Context {
  String? id;
  String? shortCode;
  String? wikidata;
  String? text;

  Context({
    this.id,
    this.shortCode,
    this.wikidata,
    this.text,
  });

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
    id: json["id"],
    shortCode: json["short_code"],
    wikidata: json["wikidata"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "short_code": shortCode,
    "wikidata": wikidata,
    "text": text,
  };
}

class Geometry {
  GeometryType? type;
  List<double>? coordinates;

  Geometry({
    this.type,
    this.coordinates,
  });

  factory Geometry.fromRawJson(String str) =>
      Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: geometryTypeValues.map[json["type"]],
    coordinates:
    List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": geometryTypeValues.reverse![type!],
    "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

enum GeometryType { POINT }

final geometryTypeValues = EnumValues({"Point": GeometryType.POINT});

final placeTypeValues = EnumValues({
  "country": PlaceType.country,
  "place": PlaceType.place,
  "region": PlaceType.region,
  "postcode": PlaceType.postcode,
  "district": PlaceType.district,
  "locality": PlaceType.locality,
  "neighborhood": PlaceType.neighborhood,
  "address": PlaceType.address,
  "poi": PlaceType.poi,
});

class Properties {
  String? shortCode;
  String? wikidata;
  String? address;

  Properties({
    this.shortCode,
    this.wikidata,
    this.address,
  });

  factory Properties.fromRawJson(String str) =>
      Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    shortCode: json["short_code"] == null ? null : json["short_code"],
    wikidata: json["wikidata"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "short_code": shortCode == null ? null : shortCode,
    "wikidata": wikidata,
    "address": address,
  };
}

enum FeatureType { FEATURE }

final featureTypeValues = EnumValues({"Feature": FeatureType.FEATURE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
