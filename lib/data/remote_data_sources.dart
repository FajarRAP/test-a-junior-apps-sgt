import '../entities/coordinate.dart';

abstract class RemoteDataSources<T> {
  Future<T> fetchCurrentWeather({required Coordinate coordinate});
  Future<T> fetchDailyWeather({required Coordinate coordinate});
  Future<T> fetchHourlyWeather({required Coordinate coordinate});
}
