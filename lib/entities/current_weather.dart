import 'weather.dart';

class CurrentWeather {
  const CurrentWeather({
    required this.city,
    required this.maxTemperature,
    required this.minTemperature,
    required this.temperature,
    required this.weather,
  });

  final String city;
  final double maxTemperature;
  final double minTemperature;
  final double temperature;
  final Weather weather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) => CurrentWeather(
        city: json['name'],
        maxTemperature: json['main']['temp_max'],
        minTemperature: json['main']['temp_min'],
        temperature: json['main']['temp'],
        weather: Weather.fromJson(
            List<Map<String, dynamic>>.from(json['weather']).first),
      );
}
