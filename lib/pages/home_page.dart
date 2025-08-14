import 'dart:ui';

import 'package:flutter/material.dart';

import '../entities/coordinate.dart';
import '../entities/mini_weather.dart';
import '../main.dart';
import 'widgets/info_card.dart';
import 'widgets/mini_weather_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      data.city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${data.temperature}°',
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
                            text: 'H:${data.maxTemperature}° ',
                            style: const TextStyle(color: Colors.white),
                          ),
                          TextSpan(
                            text: 'L:${data.minTemperature}°',
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
                      height: 350,
                      child: DefaultTabController(
                        initialIndex: 0,
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            TabBar(
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
                                  MiniWeatherList(
                                    future: repositories.fetchHourlyWeather(
                                        coordinate: coordinate),
                                    child: (snapshot) {
                                      final miniWeathers =
                                          List<MiniWeather>.from(
                                              snapshot.data!);

                                      return ListView.separated(
                                        itemBuilder: (context, index) =>
                                            InfoCard(
                                          miniWeather: miniWeathers[index],
                                          pattern: 'h a',
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 12),
                                        itemCount: miniWeathers.length,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                      );
                                    },
                                  ),
                                  MiniWeatherList(
                                    future: repositories.fetchDailyWeather(
                                        coordinate: coordinate),
                                    child: (snapshot) {
                                      final miniWeathers =
                                          List<MiniWeather>.from(
                                              snapshot.data!);

                                      return ListView.separated(
                                        itemBuilder: (context, index) =>
                                            InfoCard(
                                          miniWeather: miniWeathers[index],
                                          pattern: 'E',
                                        ),
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(width: 12),
                                        itemCount: miniWeathers.length,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        scrollDirection: Axis.horizontal,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
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
    );
  }
}
