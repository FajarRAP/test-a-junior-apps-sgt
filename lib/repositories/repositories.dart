import '../entities/coordinate.dart';
import '../entities/current_weather.dart';

abstract class Repositories {
  Future<CurrentWeather> fetchCurrentWeather({required Coordinate coordinate});
  Future<List> fetchDailyWeather({required Coordinate coordinate});
  Future<List> fetchHourlyWeather({required Coordinate coordinate});
}
