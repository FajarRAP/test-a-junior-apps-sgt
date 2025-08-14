class ForecastWeather {
  const ForecastWeather({
    required this.datetime,
    required this.temperature,
    required this.iconUrl,
  });

  final DateTime datetime;
  final num temperature;
  final String iconUrl;

  factory ForecastWeather.fromHourlyJson(Map<String, dynamic> json) => ForecastWeather(
        datetime:
            DateTime.fromMillisecondsSinceEpoch(json['time_epoch'] * 1000),
        temperature: json['temp_c'],
        iconUrl: json['condition']['icon'],
      );

  factory ForecastWeather.fromDailyJson(Map<String, dynamic> json) => ForecastWeather(
        datetime:
            DateTime.fromMillisecondsSinceEpoch(json['date_epoch'] * 1000),
        temperature: json['day']['avgtemp_c'],
        iconUrl: json['day']['condition']['icon'],
      );
}
