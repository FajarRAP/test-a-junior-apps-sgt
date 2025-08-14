import 'weather.dart';

class CurrentWeather {
  const CurrentWeather({
    required this.city,
    required this.feelsLikeTemperature,
    required this.humidity,
    required this.maxTemperature,
    required this.minTemperature,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
    required this.visibility,
    required this.weather,
    required this.windSpeed,
  });

  final String city;
  final double feelsLikeTemperature;
  final int humidity;
  final double maxTemperature;
  final double minTemperature;
  final DateTime sunrise;
  final DateTime sunset;
  final double temperature;
  final int visibility;
  final Weather weather;
  final double windSpeed;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        city: json['name'],
        feelsLikeTemperature: json['main']['feels_like'],
        humidity: json['main']['humidity'],
        maxTemperature: json['main']['temp_max'],
        minTemperature: json['main']['temp_min'],
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
        temperature: json['main']['temp'],
        visibility: json['visibility'],
        weather: Weather.fromJson(
            List<Map<String, dynamic>>.from(json['weather']).first),
        windSpeed: json['wind']['speed'],
      );
}
