import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:travel_trackr/core/data/api/api_ninja/sword.dart';
import 'package:travel_trackr/core/data/models/city/city.dart';

import '../../models/airport/airport.dart';

part 'samurai.g.dart';

@RestApi()
@Injectable()
abstract class Samurai {
  @factoryMethod
  factory Samurai() => _Samurai(sword);

  @GET('/city')
  Future<List<City>> getCities({
    @Query('name') String? name,
    @Query('country') String? country,
    @Query('limit') int limit = 20,
  });

  @GET('/airports')
  Future<List<Airport>> getAirports({
    @Query('name') String? name,
  });
}
