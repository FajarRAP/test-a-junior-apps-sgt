import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../entities/coordinate.dart';
import '../entities/forecast_weather.dart';
import '../main.dart';
import 'widgets/current_weather_data_card.dart';
import 'widgets/forecast_weather_list.dart';
import 'widgets/info_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * .5;
    const coordinate = Coordinate(latitude: 45.4215, longitude: -75.6972);

    return Scaffold(
      body: FutureBuilder(
        future: repositories.fetchCurrentWeather(coordinate: coordinate),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final data = snapshot.data!;
          final description = data.weather.description.splitMapJoin(' ',
              onMatch: (_) => ' ',
              onNonMatch: (notMatch) =>
                  notMatch[0].toUpperCase() +
                  notMatch.substring(1).toLowerCase());

          return Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data.city,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.location_pin,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${data.temperature.round()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 96,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '$description\n',
                        style: const TextStyle(
                          color: Color(0x99EBEBF5),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: 'H:${data.maxTemperature.round()}°C ',
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'L:${data.minTemperature.round()}°C',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Image.asset('assets/images/house.png'),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: height,
                  child: DraggableScrollableSheet(
                    minChildSize: .33,
                    builder: (context, scrollController) =>
                        SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 20,
                            sigmaY: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                colors: <Color>[
                                  Color(0xFF2E335A),
                                  Color(0xFF1C1B33),
                                ],
                                end: Alignment.bottomRight,
                              ).withOpacity(.2),
                            ),
                            height: height,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: DefaultTabController(
                                initialIndex: 0,
                                length: 2,
                                child: Column(
                                  children: <Widget>[
                                    TabBar(
                                      dividerColor: Colors.transparent,
                                      indicatorAnimation:
                                          TabIndicatorAnimation.elastic,
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
                                          ForecastWeatherList(
                                            future:
                                                repositories.fetchHourlyWeather(
                                                    coordinate: coordinate),
                                            child: (snapshot) {
                                              final forecastWeathers =
                                                  List<ForecastWeather>.from(
                                                      snapshot.data!);

                                              return ListView.separated(
                                                itemBuilder: (context, index) =>
                                                    InfoCard(
                                                  forecastWeather:
                                                      forecastWeathers[index],
                                                  pattern: 'h a',
                                                ),
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 12),
                                                itemCount:
                                                    forecastWeathers.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                              );
                                            },
                                          ),
                                          ForecastWeatherList(
                                            future:
                                                repositories.fetchDailyWeather(
                                                    coordinate: coordinate),
                                            child: (snapshot) {
                                              final forecastWeathers =
                                                  List<ForecastWeather>.from(
                                                      snapshot.data!);

                                              return ListView.separated(
                                                itemBuilder: (context, index) =>
                                                    InfoCard(
                                                  forecastWeather:
                                                      forecastWeathers[index],
                                                  pattern: 'E',
                                                ),
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(width: 12),
                                                itemCount:
                                                    forecastWeathers.length,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                              );
                                            },
                                          ),
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        CurrentWeatherDataCard(
                                          title: 'SUNRISE',
                                          value: DateFormat('HH:mm a')
                                              .format(data.sunrise),
                                        ),
                                        CurrentWeatherDataCard(
                                          title: 'SUNSET',
                                          value: DateFormat('HH:mm a')
                                              .format(data.sunset),
                                        ),
                                        CurrentWeatherDataCard(
                                          title: 'WIND',
                                          value: '${data.windSpeed} m/s',
                                        ),
                                        CurrentWeatherDataCard(
                                          title: 'FEELS LIKE',
                                          value:
                                              '${data.feelsLikeTemperature.round()}°C',
                                        ),
                                        CurrentWeatherDataCard(
                                          title: 'HUMIDITY',
                                          value: '${data.humidity} %',
                                        ),
                                        CurrentWeatherDataCard(
                                          title: 'VISIBILITY',
                                          value: '${data.visibility} m',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.logout_outlined,
        ),
      ),
    );
  }
}
