import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../core/constants/constants.dart';
import '../cubit/coordinate_cubit.dart';
import '../cubit/weather_cubit.dart';
import 'login_page.dart';
import 'widgets/forecast_weather_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coordinateCubit = context.read<CoordinateCubit>();
    final weatherCubit = context.read<WeatherCubit>();
    const height = 400.0;

    return Scaffold(
      body: Center(
        child: BlocConsumer<CoordinateCubit, CoordinateState>(
          bloc: coordinateCubit..getPosition(),
          listener: (context, state) {
            if (state is CoordinateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }

            if (state is CoordinateLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Success get location'),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CoordinateLoading) {
              return const CircularProgressIndicator.adaptive();
            }

            if (state is CoordinateError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(state.message),
                  if (state is LocationServiceOff)
                    ElevatedButton(
                      onPressed: Geolocator.openLocationSettings,
                      child: const Text('Turn On Location Service'),
                    ),
                  if (state is LocationPermissionDenied)
                    ElevatedButton(
                      onPressed: coordinateCubit.getPosition,
                      child: const Text('Ask Permission'),
                    ),
                  if (state is LocationPermanentlyDenied)
                    ElevatedButton(
                      onPressed: Geolocator.openAppSettings,
                      child: const Text('Manually Granting Permission'),
                    ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: coordinateCubit.getPosition,
                    child: const Text('Retry'),
                  ),
                ],
              );
            }

            return Scaffold(
              body: BlocBuilder<WeatherCubit, WeatherState>(
                bloc: weatherCubit
                  ..fetchCurrentWeather(coordinate: coordinateCubit.coordinate),
                buildWhen: (previous, current) =>
                    current is FetchCurrentWeather,
                builder: (context, state) {
                  if (state is FetchCurrentWeatherLoading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (state is FetchCurrentWeatherLoaded) {
                    final currentWeather = state.currentWeather;

                    return Stack(
                      children: <Widget>[
                        // Background Image
                        Positioned.fill(
                          child: Image.asset(
                            backgroundImgPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // House and Header
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
                                    currentWeather.city,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: coordinateCubit.getPosition,
                                    icon: const Icon(
                                      Icons.location_pin,
                                      color: Colors.white,
                                    ),
                                    tooltip: 'Get Location',
                                  ),
                                ],
                              ),
                              Text(
                                '${currentWeather.temperature.round()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 96,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      '${currentWeather.weather.description}\n',
                                  style: const TextStyle(
                                    color: Color(0x99EBEBF5),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          'H:${currentWeather.maxTemperature.round()}°C ',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    TextSpan(
                                      text:
                                          'L:${currentWeather.minTemperature.round()}°C',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              Image.asset(houseImgPath),
                            ],
                          ),
                        ),
                        // Bottom Sheet
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
                                        child: ForecastWeatherBottomSheet(
                                          coordinate:
                                              coordinateCubit.coordinate,
                                          currentWeather: currentWeather,
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
                  }

                  return const SizedBox();
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage())),
                child: const Icon(Icons.logout_outlined),
              ),
            );
          },
        ),
      ),
    );
  }
}
