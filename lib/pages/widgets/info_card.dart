import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entities/mini_weather.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    this.isActive = false,
    required this.miniWeather,
    required this.pattern,
  });

  final bool isActive;
  final MiniWeather miniWeather;
  final String pattern;

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive ? Color(0x80FFFFFF) : Color(0x33FFFFFF);
    final bgColor = isActive ? Color(0xFF48319D) : Color(0x3348319D);

    return UnconstrainedBox(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(35),
          color: bgColor,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        width: 70,
        child: Column(
          children: <Widget>[
            Text(
              DateFormat(pattern).format(miniWeather.datetime.toLocal()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            Image.network(_getWeatherIconUrl(miniWeather.weather.icon)),
            const SizedBox(height: 24),
            Text(
              '${(miniWeather.temperature.round())}°',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}

String _getWeatherIconUrl(String iconCode) =>
    'https://openweathermap.org/img/wn/$iconCode.png';
