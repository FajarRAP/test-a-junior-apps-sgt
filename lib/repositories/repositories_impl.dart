import 'dart:convert';

import '../data/remote_data_sources.dart';
import '../entities/coordinate.dart';
import '../entities/current_weather.dart';
import '../entities/mini_weather.dart';
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
    } catch (e) {
      throw Exception('Failed to fetch current weather: $e');
    }

    return weather;
  }

  @override
  Future<List> fetchDailyWeather({required Coordinate coordinate}) async {
    final miniWeathers = <MiniWeather>[];

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response =
          await remoteDataSources.fetchDailyWeather(coordinate: coordinate);
      final data = jsonDecode(response);
      final datas = List<Map<String, dynamic>>.from(data['list']);

      miniWeathers.addAll(datas.map(MiniWeather.fromDailyJson));
    } catch (e) {
      throw Exception('Failed to fetch daily weather: $e');
    }

    return miniWeathers;
  }

  @override
  Future<List> fetchHourlyWeather({required Coordinate coordinate}) async {
    final miniWeathers = <MiniWeather>[];

    try {
      await Future.delayed(const Duration(seconds: 1));

      final response =
          await remoteDataSources.fetchHourlyWeather(coordinate: coordinate);
      final data = jsonDecode(response);
      final datas = List<Map<String, dynamic>>.from(data['list']);

      miniWeathers.addAll(datas.map(MiniWeather.fromHourlyJson));
    } catch (e) {
      throw Exception('Failed to fetch hourly weather: $e');
    }

    return miniWeathers;
  }
}
