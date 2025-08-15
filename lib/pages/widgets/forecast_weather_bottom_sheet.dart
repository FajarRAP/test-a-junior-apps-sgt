import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubit/weather_cubit.dart';
import '../../entities/coordinate.dart';
import '../../entities/current_weather.dart';
import 'current_weather_data_card.dart';
import 'info_card.dart';

class ForecastWeatherBottomSheet extends StatelessWidget {
  const ForecastWeatherBottomSheet({
    super.key,
    required this.coordinate,
    required this.currentWeather,
  });

  final Coordinate coordinate;
  final CurrentWeather currentWeather;

  @override
  Widget build(BuildContext context) {
    final weatherCubit = context.read<WeatherCubit>();

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            onTap: (value) => value == 0
                ? weatherCubit.fetchHourlyWeather(coordinate: coordinate)
                : weatherCubit.fetchDailyWeather(coordinate: coordinate),
            dividerColor: Colors.transparent,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            tabs: <Widget>[
              Tab(
                icon: Text(
                  'Hourly Forecast',
                  style: const TextStyle(
                    color: Color(0x99EBEBF5),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'Weekly Forecast',
                  style: const TextStyle(
                    color: Color(0x99EBEBF5),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: TabBarView(
              children: <Widget>[
                BlocBuilder<WeatherCubit, WeatherState>(
                  bloc: weatherCubit
                    ..fetchHourlyWeather(coordinate: coordinate),
                  buildWhen: (previous, current) =>
                      current is FetchHourlyWeather,
                  builder: (context, hourlyState) {
                    if (hourlyState is FetchHourlyWeatherLoading) {
                      return CircularProgressIndicator.adaptive();
                    }

                    if (hourlyState is FetchHourlyWeatherLoaded) {
                      return ListView.separated(
                        itemBuilder: (context, index) => InfoCard(
                          forecastWeather: hourlyState.forecastWeathers[index],
                          pattern: 'h a',
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: hourlyState.forecastWeathers.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        scrollDirection: Axis.horizontal,
                      );
                    }

                    return const SizedBox();
                  },
                ),
                BlocBuilder<WeatherCubit, WeatherState>(
                  bloc: weatherCubit..fetchDailyWeather(coordinate: coordinate),
                  buildWhen: (previous, current) =>
                      current is FetchDailyWeather,
                  builder: (context, dailyState) {
                    if (dailyState is FetchDailyWeatherLoading) {
                      return CircularProgressIndicator.adaptive();
                    }

                    if (dailyState is FetchDailyWeatherLoaded) {
                      return ListView.separated(
                        itemBuilder: (context, index) => InfoCard(
                          forecastWeather: dailyState.forecastWeathers[index],
                          pattern: 'E',
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 12),
                        itemCount: dailyState.forecastWeathers.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        scrollDirection: Axis.horizontal,
                      );
                    }

                    return const SizedBox();
                  },
                )
              ],
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              CurrentWeatherDataCard(
                title: 'SUNRISE',
                value: DateFormat('HH:mm a').format(currentWeather.sunrise),
              ),
              CurrentWeatherDataCard(
                title: 'SUNSET',
                value: DateFormat('HH:mm a').format(currentWeather.sunset),
              ),
              CurrentWeatherDataCard(
                title: 'WIND',
                value: '${currentWeather.windSpeed} m/s',
              ),
              CurrentWeatherDataCard(
                title: 'FEELS LIKE',
                value: '${currentWeather.feelsLikeTemperature.round()}°C',
              ),
              CurrentWeatherDataCard(
                title: 'HUMIDITY',
                value: '${currentWeather.humidity} %',
              ),
              CurrentWeatherDataCard(
                title: 'VISIBILITY',
                value: '${currentWeather.visibility} m',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
