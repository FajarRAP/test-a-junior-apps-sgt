import 'dart:convert';

import 'package:http/http.dart';

import '../data/remote_data_sources.dart';
import '../entities/coordinate.dart';
import '../entities/current_weather.dart';
import '../entities/forecast_weather.dart';
import 'repositories.dart';

class RepositoriesImpl extends Repositories {
  RepositoriesImpl({required this.remoteDataSources});

  final RemoteDataSources<Response> remoteDataSources;

  @override
  Future<CurrentWeather> fetchCurrentWeather(
      {required Coordinate coordinate}) async {
    late CurrentWeather weather;

    try {
      final response =
          await remoteDataSources.fetchCurrentWeather(coordinate: coordinate);
      final data = jsonDecode(response.body);

      weather = CurrentWeather.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch current weather');
    }

    return weather;
  }

  @override
  Future<List> fetchDailyWeather({required Coordinate coordinate}) async {
    final forecastWeathers = <ForecastWeather>[];

    try {
      final response =
          await remoteDataSources.fetchDailyWeather(coordinate: coordinate);
      final json = jsonDecode(response.body);
      final forecastday =
          List<Map<String, dynamic>>.from(json['forecast']['forecastday']);

      forecastWeathers.addAll(forecastday.map(ForecastWeather.fromDailyJson));
    } catch (e) {
      throw Exception('Failed to fetch daily weather');
    }

    return forecastWeathers;
  }

  @override
  Future<List> fetchHourlyWeather({required Coordinate coordinate}) async {
    final forecastWeathers = <ForecastWeather>[];

    try {
      final response =
          await remoteDataSources.fetchHourlyWeather(coordinate: coordinate);
      final json = jsonDecode(response.body);
      final forecastday =
          List<Map<String, dynamic>>.from(json['forecast']['forecastday'])
              .first;
      final hours = List<Map<String, dynamic>>.from(forecastday['hour']);

      forecastWeathers.addAll(hours.map(ForecastWeather.fromHourlyJson));
    } catch (e) {
      throw Exception('Failed to fetch hourly weather');
    }

    return forecastWeathers;
  }
}
