part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class FetchCurrentWeather extends WeatherState {}

class FetchCurrentWeatherLoading extends FetchCurrentWeather {}

class FetchCurrentWeatherLoaded extends FetchCurrentWeather {
  final CurrentWeather currentWeather;

  FetchCurrentWeatherLoaded(this.currentWeather);
}

class FetchCurrentWeatherError extends FetchCurrentWeather {
  final String error;

  FetchCurrentWeatherError(this.error);
}

class FetchDailyWeather extends WeatherState {}

class FetchDailyWeatherLoading extends FetchDailyWeather {}

class FetchDailyWeatherLoaded extends FetchDailyWeather {
  final List<ForecastWeather> forecastWeathers;

  FetchDailyWeatherLoaded(this.forecastWeathers);
}

class FetchDailyWeatherError extends FetchDailyWeather {
  final String error;

  FetchDailyWeatherError(this.error);
}

class FetchHourlyWeather extends WeatherState {}

class FetchHourlyWeatherLoading extends FetchHourlyWeather {}

class FetchHourlyWeatherLoaded extends FetchHourlyWeather {
  final List<ForecastWeather> forecastWeathers;

  FetchHourlyWeatherLoaded(this.forecastWeathers);
}

class FetchHourlyWeatherError extends FetchHourlyWeather {
  final String error;

  FetchHourlyWeatherError(this.error);
}
