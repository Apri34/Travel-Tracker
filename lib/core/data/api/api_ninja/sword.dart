import 'package:fresh_dio/fresh_dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final Dio sword = Dio()
  ..options.baseUrl = 'https://api.api-ninjas.com/v1'
  ..options.connectTimeout = 20000
  ..options.receiveTimeout = 20000
  ..options.sendTimeout = 20000
  ..options.followRedirects = false
  ..options.headers.putIfAbsent(
      "X-Api-Key", () => "1732NK/uYlpsGPV8s4kJDw==N49DcysjW0aYTP9p")
  ..interceptors.add(PrettyDioLogger(
    request: false,
    requestHeader: false,
    requestBody: false,
    responseHeader: false,
    responseBody: false,
    compact: true,
  ));
