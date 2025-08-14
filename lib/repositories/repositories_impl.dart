import 'dart:convert';

import '../data/remote_data_sources.dart';
import '../entities/coordinate.dart';
import '../entities/current_weather.dart';
import '../entities/forecast_weather.dart';
import 'repositories.dart';

class RepositoriesImpl extends Repositories {
  RepositoriesImpl({required this.remoteDataSources});

  final RemoteDataSources<String> remoteDataSources;

  @override
  Future<CurrentWeather> fetchCurrentWeather(
      {required Coordinate coordinate}) async {
    late CurrentWeather weather;

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response =
          await remoteDataSources.fetchCurrentWeather(coordinate: coordinate);
      final data = jsonDecode(response);

      weather = CurrentWeather.fromJson(data);
    } catch (e, s) {
      throw Exception('Failed to fetch current weather: $e $s');
    }

    return weather;
  }

  @override
  Future<List> fetchDailyWeather({required Coordinate coordinate}) async {
    final forecastWeathers = <ForecastWeather>[];

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response =
          await remoteDataSources.fetchDailyWeather(coordinate: coordinate);
      final json = jsonDecode(response);
      final forecastday =
          List<Map<String, dynamic>>.from(json['forecast']['forecastday']);

      forecastWeathers.addAll(forecastday.map(ForecastWeather.fromDailyJson));
    } catch (e) {
      throw Exception('Failed to fetch daily weather: $e');
    }

    return forecastWeathers;
  }

  @override
  Future<List> fetchHourlyWeather({required Coordinate coordinate}) async {
    final forecastWeathers = <ForecastWeather>[];

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response =
          await remoteDataSources.fetchHourlyWeather(coordinate: coordinate);
      final json = jsonDecode(response);
      final forecastday =
          List<Map<String, dynamic>>.from(json['forecast']['forecastday'])
              .first;
      final hours = List<Map<String, dynamic>>.from(forecastday['hour']);

      forecastWeathers.addAll(hours.map(ForecastWeather.fromHourlyJson));
    } catch (e) {
      throw Exception('Failed to fetch hourly weather: $e');
    }

    return forecastWeathers;
  }
}
