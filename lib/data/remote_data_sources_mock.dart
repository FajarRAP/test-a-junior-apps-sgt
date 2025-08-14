import 'package:flutter/services.dart';

import '../entities/coordinate.dart';
import 'remote_data_sources.dart';

class RemoteDataSourcesMock extends RemoteDataSources<String> {
  @override
  Future<String> fetchCurrentWeather({required Coordinate coordinate}) async {
    return await rootBundle.loadString('assets/json/weather.json');
  }

  @override
  Future<String> fetchDailyWeather({required Coordinate coordinate}) async {
    return await rootBundle.loadString('assets/json/daily.json');
  }

  @override
  Future<String> fetchHourlyWeather({required Coordinate coordinate}) async {
    return await rootBundle.loadString('assets/json/hourly.json');
  }
}
