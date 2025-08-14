import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../entities/coordinate.dart';
import 'remote_data_sources.dart';

class RemoteDataSourcesImpl extends RemoteDataSources<Response> {
  RemoteDataSourcesImpl({required this.httpClient});

  final Client httpClient;

  @override
  Future<Response> fetchCurrentWeather({required Coordinate coordinate}) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${coordinate.latitude}&lon=${coordinate.longitude}&appid=$apiKeyOWM&units=metric");
    return await httpClient.get(url);
  }

  @override
  Future<Response> fetchDailyWeather({required Coordinate coordinate}) async {
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/forecast.json?key=$apiKeyFWA&q=${coordinate.latitude},${coordinate.longitude}&days=6');
    return await httpClient.get(url);
  }

  @override
  Future<Response> fetchHourlyWeather({required Coordinate coordinate}) async {
    final now = DateTime.now();
    final formatted = DateFormat('yyyy-MM-dd').format(now);
    final url = Uri.parse(
        'https://api.weatherapi.com/v1/history.json?key=$apiKeyFWA&q=${coordinate.latitude},${coordinate.longitude}&dt=$formatted');
    return await httpClient.get(url);
  }
}
