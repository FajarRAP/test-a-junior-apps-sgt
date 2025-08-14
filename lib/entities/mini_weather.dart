import 'weather.dart';

class MiniWeather {
  const MiniWeather({
    required this.datetime,
    required this.temperature,
    required this.weather,
  });

  final DateTime datetime;
  final double temperature;
  final Weather weather;

  factory MiniWeather.fromHourlyJson(Map<String, dynamic> json) => MiniWeather(
        datetime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: json['main']['temp'],
        weather: Weather.fromJson(
            List<Map<String, dynamic>>.from(json['weather']).first),
      );

  factory MiniWeather.fromDailyJson(Map<String, dynamic> json) => MiniWeather(
        datetime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temperature: json['temp']['day'],
        weather: Weather.fromJson(
            List<Map<String, dynamic>>.from(json['weather']).first),
      );
}
