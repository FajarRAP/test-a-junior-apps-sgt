import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../entities/coordinate.dart';
import '../entities/current_weather.dart';
import '../entities/forecast_weather.dart';
import '../repositories/repositories.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit({required this.repositories}) : super(WeatherInitial());

  final Repositories repositories;

  Future<void> fetchCurrentWeather({required Coordinate coordinate}) async {
    emit(FetchCurrentWeatherLoading());

    try {
      final result =
          await repositories.fetchCurrentWeather(coordinate: coordinate);
      emit(FetchCurrentWeatherLoaded(result));
    } catch (e) {
      emit(FetchCurrentWeatherError('$e'));
    }
  }

  Future<void> fetchDailyWeather({required Coordinate coordinate}) async {
    emit(FetchDailyWeatherLoading());

    try {
      final result =
          await repositories.fetchDailyWeather(coordinate: coordinate);
      emit(FetchDailyWeatherLoaded(List.from(result)));
    } catch (e) {
      emit(FetchDailyWeatherError('$e'));
    }
  }

  Future<void> fetchHourlyWeather({required Coordinate coordinate}) async {
    emit(FetchHourlyWeatherLoading());

    try {
      final result =
          await repositories.fetchHourlyWeather(coordinate: coordinate);
      emit(FetchHourlyWeatherLoaded(List.from(result)));
    } catch (e) {
      emit(FetchHourlyWeatherError('$e'));
    }
  }
}
