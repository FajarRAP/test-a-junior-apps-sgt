import '../entities/coordinate.dart';

abstract class Repositories {
  Future<Object> fetchCurrentWeather({required Coordinate coordinate});
  Future<List> fetchDailyWeather({required Coordinate coordinate});
  Future<List> fetchHourlyWeather({required Coordinate coordinate});
}
